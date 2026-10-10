# Historique des versions

## 0.1.0 — première version publiée

- Probabilités (§52 de ProfLycee) : `calc-binom-p`, `binom-p`, etc. pour
  les lois binomiale, de Poisson, géométrique, hypergéométrique, normale et
  exponentielle. Absent de ProfLycee : les fabriques `loi-binomiale(n, p)`,
  etc., qui renvoient une fonction `X` (`X(k)`, `X(a, b)`), et les clés
  `arrondi`, `scientifique` (version étoilée) et `brut` (commandes `\Calc…`).
- Arbres de probabilités (§53) : `arbre-probas`, `arbre-probas-dessin`.
  Absent de ProfLycee : tout type « pxq », pas seulement 2 ou 3 branches.
- Schémas des lois continues (§54) : `loi-normale-graphe`, `loi-expo-graphe`.
  Absent de ProfLycee : les versions `-dessin` et la clé `baseline`
  (avec la valeur `"axe"`).
- Réduction modulo (§52 de ProfLycee 4.02b) : `reste-mod`, `quo-mod`.
  Absent de ProfLycee : la fabrique `modulo(n)` et la clé `puissance`
  (exponentiation modulaire, les entiers Typst étant limités à 64 bits).
- Conversions entre bases (§53) : `conversion-entre-bases`. Absent de
  ProfLycee : la fabrique `conversion(sens)`.
- Division euclidienne (§54) : `division-eucl`, `div-eucl`.
- Diviseurs et facteurs premiers (§60), sous des noms abrégés :
  `liste-div` (`\ListeDiviseurs`), `arbre-div` (`\ArbreDiviseurs`),
  `dpfp` (`\DecompFactPremiers`), `prespfp` (`\PresFactPremiers`),
  `simpfrac` (`\SimplFracDecomp`). Absent de ProfLycee : `arbre-div-dessin`,
  `liste-div` écrit le nom de l'ensemble en écriture ronde par défaut
  (`scr: true`), et dans `simpfrac`, la clé `aff-couleur` (couleurs
  désactivées par défaut) et, avec `barrer`, une couleur par nombre premier
  commun (clé `couleurs-barres`).
- `arbre-probas` et `arbre-div` partagent un même moteur d'arbre
  (`src/arbre.typ`, non exporté) ; rendu d'`arbre-probas` inchangé.
- `src/` rangé par thème : `analyse/`, `arithmetique/`, `probas/`.
- Résolution approchée d'une équation (§7 de ProfLycee 4.02b) :
  `resolution-approchee`, qui renvoie un dictionnaire (`defaut`, `exces`,
  `approchee`, et `valeur`, absente de ProfLycee) au lieu de macros.
  Absent de ProfLycee : les écrans NumWorks dessinés `numworks-solveur` et
  `numworks-graphique` (la doc de ProfLycee montre des captures d'écran).
- Suites récurrentes simples (§9 de ProfLycee 4.02b) :
  `calcul-terme-recurrence`, `solution-seuil`, `rang-seuil` (le compteur
  `\CompteurSeuil`). Absent de ProfLycee : la fabrique `suite-recurrente`,
  la clé `brut`, et l'écran NumWorks `numworks-suite` (tableau n | u_n,
  clés `debut` et `surligne`) qui remplace le tableau de la doc. Précision
  par défaut de `solution-seuil` : 3, comme dans l'exemple de la doc (son
  texte annonce 2).
- `_grouper` et `_decimal` déplacés dans `outils.typ`.
- Tests unitaires (`tests/unitaires/`) et d'erreurs (`tests/erreurs/`),
  lancés avec les tests visuels par `tests/lancer.sh`.
- Corrigé : `cercle-trigo(point: 0)` plantait (arc de 0°).
- Corrigé : `loi-geometrique(1)` plantait (`calc.pow(0, 0)`).
- Corrigé : `div-eucl` et `division-eucl` débordaient près des bornes des
  entiers 64 bits.
- Les commandes de probabilités vérifient leur nombre d'arguments (message
  rappelant la signature, au lieu de « missing argument »).
- `_nombre` déplacé de `pgcd.typ` vers `outils.typ`, commun à plusieurs
  commandes.

## 0.1.0 — version de départ
 
