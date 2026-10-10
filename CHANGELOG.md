# Historique des versions

## Non publié

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
- `_nombre` déplacé de `pgcd.typ` vers `outils.typ`, commun à plusieurs
  commandes.

## 0.1.0 — version de départ
 
