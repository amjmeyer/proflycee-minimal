# proflycee-minimal — repères pour Claude

Paquet **Typst** (pas LaTeX) : portage minimaliste de quelques commandes du
paquet LaTeX [ProfLycee](https://ctan.org/pkg/proflycee) de Cédric Pierquet.
Même organisation que `../to-be-published_profmaquette-minimal` (à imiter).

## Où est quoi

- [src/lib.typ](src/lib.typ) — point d'entrée (déclaré dans `typst.toml`), ne
  fait qu'exporter les fonctions publiques ; tient la table de correspondance
  commande ProfLycee → fonction Typst.
- Une commande ProfLycee par fichier, rangée par thème dans `src/analyse/`,
  `src/arithmetique/` ou `src/probas/` (dossiers sans accent) : [src/analyse/cercle-trigo.typ](src/analyse/cercle-trigo.typ),
  [src/analyse/resolution-approchee.typ](src/analyse/resolution-approchee.typ)
  (§7 de la doc 4.02b), [src/analyse/numworks.typ](src/analyse/numworks.typ)
  (écrans NumWorks dessinés, pas dans ProfLycee),
  [src/arithmetique/pgcd.typ](src/arithmetique/pgcd.typ) (`presentation-pgcd` et `remontee-euclide`,
  cette dernière absente de ProfLycee), [src/probas/calculs-lois.typ](src/probas/calculs-lois.typ)
  (calculs de probabilités, §52), [src/probas/arbre-probas.typ](src/probas/arbre-probas.typ)
  (§53), [src/probas/loi-graphe.typ](src/probas/loi-graphe.typ) (§54 ancienne
  numérotation), [src/arithmetique/modulo.typ](src/arithmetique/modulo.typ),
  [src/arithmetique/conversion-bases.typ](src/arithmetique/conversion-bases.typ),
  [src/arithmetique/division-eucl.typ](src/arithmetique/division-eucl.typ) (§52–54 de la doc 4.02b),
  [src/arithmetique/diviseurs.typ](src/arithmetique/diviseurs.typ) (§60 :
  diviseurs, arbre des diviseurs, facteurs premiers).
  Moteur commun des arbres (`arbre-probas`, `arbre-div`), non
  exporté : [src/arbre.typ](src/arbre.typ).
  Outils communs non exportés (`_nombre`…) : [src/outils.typ](src/outils.typ).
  Les numéros de section citent la doc ProfLycee 4.02b (en local :
  `~/texmf/tex/latex/cpierquet/proflycee/doc/ProfLycee-doc.pdf`, l'ancienne
  4.00f, plus complète, à côté). Clés documentées en commentaire en
  tête de chaque fichier : source de vérité.
- [src/deps.typ](src/deps.typ) — seul endroit (importé par `../deps.typ`
  depuis les sous-dossiers) qui importe `@preview/cetz`.
- Tests, tous lancés par `tests/lancer.sh` (sortie dans `tests/sortie/`,
  ignorée par git ; code de sortie = nombre d'échecs) :
  - [tests/beta/](tests/beta/) — un cas par fichier, contrôle visuel manuel ;
  - [tests/unitaires/](tests/unitaires/) — un fichier par `.typ` de `src/`,
    vérifications automatiques (`assert`) ; outils dans
    [tests/unitaires/aide.typ](tests/unitaires/aide.typ) : `texte(c)`
    (contenu → texte brut comparable), `egal`, `proche`, `releve`/`couleurs`
    (couleurs réellement employées), `releve-textes`/`textes` (textes
    affichés, y compris dans un canvas CeTZ, que `texte` ne voit pas) ;
  - [tests/erreurs/](tests/erreurs/) — entrées invalides, chaque fichier doit
    échouer avec le message de sa 1re ligne (`// attendu : …`).
  Toute nouvelle commande : ajouter ses tests unitaires et d'erreurs.
- `PUBLIER.md` — procédure de publication (pas sur GitHub).

## Conventions

- Clés : celles de ProfLycee, en kebab-case français (`Rayon` → `rayon`,
  `AffValeurs` → `aff-valeurs`). Une clé ajoutée qui n'existe pas dans
  ProfLycee est signalée comme telle (commentaire + README + CHANGELOG).
- Chaque commande dessinée existe en deux versions : `xxx(...)` (canvas
  autonome) et `xxx-dessin(...)` (éléments CeTZ seuls, à mettre dans le canvas
  de l'utilisateur, comme la commande TikZ dans un `tikzpicture`).
- Unités du canvas : 1 = 1 cm.
- Licence MIT (différente de profmaquette-minimal, qui est en LPPL) : même
  en-tête court (Copyright + `SPDX-License-Identifier: MIT`) en tête de chaque
  `.typ` de `src/`, recopié tel quel.
- Réécriture indépendante : s'inspirer de la doc de ProfLycee (rendu, noms
  des clés), ne jamais recopier ni traduire son code source LPPL.

- Simplifier par des fabriques de fonctions (closures) : une loi est une
  fonction renvoyée par `loi-binomiale(n, p)` etc. ; les commandes ProfLycee
  (`binom-p`, `calc-binom-p`…) sont fabriquées par `_commande(loi, …)` ; les
  schémas par `_graphe(densite, …)` et `_autonome(dessin)` ; `modulo(n)` et
  `conversion(sens)` renvoient la fonction qui calcule.

## Pièges connus

- On ne peut pas appeler une fonction rangée dans un dictionnaire avec
  `d.f(x)` (il faut `(d.f)(x)`) : d'où des lois-fonctions plutôt que des
  dictionnaires de fonctions.

- Grilles Typst : l'espacement s'écrit `column-gutter` / `row-gutter`, pas
  `column-gap` (erreur « unexpected argument »).
- `presentation-pgcd` renvoie des maths en ligne : le tableau est une `box`
  dont la `baseline` (50 % − 0,25 em) la centre sur l'axe mathématique, sinon
  l'accolade et le trait de `lr(…)` descendent bien trop bas.

- Dans `cercle-trigo-dessin`, les clés `cos` et `sin` masquent les opérateurs
  mathématiques : écrire `#math.cos` / `#math.sin` dans les `$…$`. Même
  piège pour la clé `scr` de `liste-div` (`#math.scr`).
- `tableau.remove(i)` renvoie l'élément retiré : dans un bloc qui produit du
  contenu, écrire `let _ = tableau.remove(i)`, sinon il est ajouté au résultat.
- Typst arrête une boucle `while` au-delà de 10 000 tours (« loop seems to be
  infinite ») ; les `for` ne sont pas limités. D'où la limite de 10^8 de la
  décomposition en facteurs premiers.
- `calc.pow(0, 0)` est une erreur : traiter l'exposant nul à part.
- Entiers 64 bits : `a - b * q` peut déborder près des bornes même si le
  résultat tient ; préférer `calc.rem-euclid`.
- Les styles (couleur, `math.display`, `scr`/`cal`) n'apparaissent pas dans
  `repr` : pour les tester, mesurer (`measure`) ou relever avec une règle
  `show` (voir `releve` dans `tests/unitaires/aide.typ`).
- Une fonction locale (closure) ne peut pas modifier une variable extérieure.
- Le dossier `src/` est relié par lien symbolique depuis
  `MATHEMATIQUES/PREAMBULE_PERSO_Typst/proflycee-minimal` (relais
  `proflycee-dev.typ`) : toute modification s'applique aussitôt aux cours.
