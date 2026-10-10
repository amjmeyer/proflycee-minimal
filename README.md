# proflycee-minimal

Quelques commandes du package LaTeX
[ProfLycee](https://ctan.org/pkg/proflycee) de **Cédric Pierquet**, portées en
Typst (avec [CeTZ](https://typst.app/universe/package/cetz)). Pour l'instant :
le cercle trigonométrique (`\CercleTrigo`), la présentation de l'algorithme
d'Euclide (`\PresentationPGCD`), complétée par sa remontée automatique
(coefficients de Bézout), absente de ProfLycee, et les probabilités : calculs
avec les lois classiques (`\CalcBinomP`, `\BinomP`, …), arbres
(`\ArbreProbasTikz`) et petits schémas des lois normale et exponentielle
(`\LoiNormaleGraphe`, `\LoiExpoGraphe`), et l'arithmétique : réduction modulo
(`\ResteMod`, `\QuoMod`), conversions entre bases (`\ConversionEntreBases`)
division euclidienne (`\DivisionEucl`, `\DivEucl`), diviseurs et facteurs
premiers (`\ListeDiviseurs`, `\ArbreDiviseurs`, `\DecompFactPremiers`,
`\PresFactPremiers`, `\SimplFracDecomp`).

Ajout propre à ce paquet : des fonctions fabriquées une fois pour toutes
(une loi de probabilité, une réduction modulo n, une conversion de base),
qui s'emploient ensuite directement.

```typst
#let X = loi-binomiale(5, 0.4)
$P(X = 3) approx #X(3)$ et $P(X >= 2) approx #X(2, none, arrondi: 4)$.

#let m26 = modulo(26)
$1234 equiv #m26(1234) space [26]$

#let binaire = conversion("10->2", aff-bases: true)
#binaire(255)
```

> **Note :** une toute petite partie seulement de ProfLycee, qui reste la
> référence. Écrit d'abord pour mon usage personnel, le paquet pourra évoluer
> de façon incompatible entre deux versions `0.x`.

*A few commands from Cédric Pierquet's LaTeX package ProfLycee, ported to Typst
(in French). For now: the trigonometric circle, Euclid's algorithm with
automatic back-substitution (Bézout coefficients), probability computations
for the usual distributions, probability trees and small sketches of normal
and exponential densities, modular reduction, base conversions,
Euclidean division, divisors (with a divisor tree) and prime factorisation.*


## Licence

MIT. Voir [LICENSE](LICENSE).

proflycee-minimal est une réécriture indépendante en Typst : il reprend des
idées et les noms des clés de ProfLycee (distribué sous LPPL 1.3c), mais pas
son code.
