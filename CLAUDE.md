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
  cette dernière absente de ProfLycee). Clés documentées en commentaire en
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

## Pièges connus

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
