# proflycee-minimal — repères pour Claude

Paquet **Typst** (pas LaTeX) : portage minimaliste de quelques commandes du
paquet LaTeX [ProfLycee](https://ctan.org/pkg/proflycee) de Cédric Pierquet.
Même organisation que `../to-be-published_profmaquette-minimal` (à imiter).

## Où est quoi

- [src/lib.typ](src/lib.typ) — point d'entrée (déclaré dans `typst.toml`), ne
  fait qu'exporter les fonctions publiques ; tient la table de correspondance
  commande ProfLycee → fonction Typst.
- Une commande ProfLycee par fichier : [src/cercle-trigo.typ](src/cercle-trigo.typ),
  [src/pgcd.typ](src/pgcd.typ) (`presentation-pgcd` et `remontee-euclide`,
  cette dernière absente de ProfLycee), [src/probas.typ](src/probas.typ)
  (calculs de probabilités, §52), [src/arbre-probas.typ](src/arbre-probas.typ)
  (§53), [src/loi-graphe.typ](src/loi-graphe.typ) (§54 ancienne
  numérotation), [src/modulo.typ](src/modulo.typ),
  [src/conversion-bases.typ](src/conversion-bases.typ),
  [src/division-eucl.typ](src/division-eucl.typ) (§52–54 de la doc 4.02b).
  Outils communs non exportés (`_nombre`…) : [src/outils.typ](src/outils.typ).
  Les numéros de section citent la doc ProfLycee 4.02b (en local :
  `~/texmf/tex/latex/cpierquet/proflycee/doc/ProfLycee-doc.pdf`, l'ancienne
  4.00f, plus complète, à côté). Clés documentées en commentaire en
  tête de chaque fichier : source de vérité.
- [src/deps.typ](src/deps.typ) — seul endroit qui importe `@preview/cetz`.
- [tests/beta/](tests/beta/) — un cas par fichier, compilés par
  `tests/lancer.sh` (sortie dans `tests/sortie/`, ignorée par git) ; contrôle
  visuel manuel.
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
  mathématiques : écrire `#math.cos` / `#math.sin` dans les `$…$`.
- Le dossier `src/` est relié par lien symbolique depuis
  `MATHEMATIQUES/PREAMBULE_PERSO_Typst/proflycee-minimal` (relais
  `proflycee-dev.typ`) : toute modification s'applique aussitôt aux cours.
