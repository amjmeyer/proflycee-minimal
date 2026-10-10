// Calculs de probabilités (§52 de la doc ProfLycee 4.00f) : valeurs brutes,
// valeurs formatées, puis avec une loi fabriquée une fois.
#import "../../src/lib.typ": *
#set page(width: 16cm, height: auto, margin: 1cm)

= Valeurs brutes (\\Calc…)

#calc-binom-p(5, 0.4, 3) \

#calc-binom-c(5, 0.4, "*", 1) \

#calc-binom-p(100, 0.02, 10) \

#calc-binom-c(100, 0.02, 15, 25) \

#calc-poiss-p(5, 3) \

#calc-poiss-c(5, 2, none) \

#calc-geom-p(0.5, 3) \

#calc-geom-c(0.5, none, 5) \

#calc-hypergeom-p(50, 10, 5, 4) \

#calc-hypergeom-c(50, 10, 5, 1, 3) \

#calc-norm-c(0, 1, none, 1) \

#calc-norm-c(0, 1, -1.96, 1.96) \

#calc-norm-c(550, 30, 600, none) \

#calc-norm-c(550, 30, 500, 600) \

#calc-expo-c(0.001, 400, none) \

#calc-expo-c(0.001, 300, 750) \

#calc-norm-c(0, 1, 8, none)

= Valeurs formatées

$P(Y >= 600) approx #normale-c(550, 30, 600, none, arrondi: 4)$ \

$P(500 <= Y <= 600) approx #normale-c(550, 30, 500, 600, arrondi: 4)$ \

$P(X = 10) approx #binom-p(100, 0.02, 10, arrondi: 7) approx #binom-p(
  100, 0.02, 10,
  arrondi: 7,
  scientifique: true
)$ \

$P(15 <= X <= 25) approx #binom-c(100, 0.02, 15, 25, arrondi: 10) approx #binom-c(
  100, 0.02, 15, 25,
  arrondi: 10,
  scientifique: true
)$ \

$P(W = 4) approx #hypergeom-p(50, 10, 5, 4, arrondi: 5)$ \

$P(1 <= W <= 3) approx #hypergeom-c(50, 10, 5, 1, 3, arrondi: 4)$ \

$P(Z >= 400) approx #expo-c(0.001, 400, none)$ \

$P(T = 3) approx #poisson-p(5, 3)$ \

$P(T >= 2) approx #poisson-c(5, 2, none, arrondi: 4)$

= Avec une loi fabriquée une fois

#let X = loi-binomiale(5, 0.4)

$P(X = 3) approx #X(3)$ \

$P(X <= 1) approx #X(none, 1)$ \

$P(X >= 2) approx #X(2, none, arrondi: 5)$ \

$P(X = 3) + P(X = 2) = #(X(3, brut: true) + X(2, brut: true))$ \

#let Y = loi-normale(1000, 100)

$P(Y >= 950) approx #Y(950, none, arrondi: 4)$ \

#Y(950, none) hors maths.
