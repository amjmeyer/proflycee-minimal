// Résolution approchée d'une équation (§7 de ProfLycee 4.02b), avec les
// écrans NumWorks dessinés à la place des captures de la doc.
#import "../../src/lib.typ": *
#set page(width: 16cm, height: auto, margin: 1cm)

#let s = resolution-approchee(
  x => calc.pow(x, 3) - 2 * x * x - x - 1,
  k: 2,
  intervalle: (0, 10)
)

$x_0 approx #s.defaut$ par défaut ; \
$x_0 approx #s.exces$ par excès ; \
$x_0 approx #s.approchee$ arrondi à $10^(-2)$.

#align(center, numworks-solveur(s, lignes: (("Δ", "-439"),)))

#let b = resolution-approchee(
  x => calc.exp(0.5 * x) + x * x - 4,
  intervalle: (0, 2),
  precision: 4
)

Une valeur approchée, à $10^(-4)$ près, d'une solution de $e^(0,5 x) + x^2 - 4 = 0$ sur $[0 ; 2]$ est $beta$ avec :
- $beta approx #b.defaut$ par défaut ;
- $beta approx #b.exces$ par excès ;
- $beta approx #b.approchee$.

#let t1 = resolution-approchee(
  t => 3 * t * calc.exp(-0.5 * t + 1),
  k: 4,
  intervalle: (-1, 2),
  variable: "t"
)

#let t2 = resolution-approchee(
  t => 3 * t * calc.exp(-0.5 * t + 1),
  k: 4,
  intervalle: (2, 10),
  precision: 3,
  variable: "t"
)

Une valeur approchée, à $10^(-2)$ près, d'une solution de $3t e^(-0,5t + 1) = 4$ est $t_1$ avec :
- $t_1 approx #t1.defaut$ par défaut ;
- $t_1 approx #t1.exces$ par excès ;
- $t_1 approx #t1.approchee$.

Une valeur approchée, à $10^(-3)$ près, d'une solution de $3t e^(-0,5t + 1) = 4$ est $t_2$ avec :
- $t_2 approx #t2.defaut$ par défaut ;
- $t_2 approx #t2.exces$ par excès ;
- $t_2 approx #t2.approchee$.

#align(center, stack(
  dir: ltr,
  spacing: 0.4cm,
  numworks-graphique(b, largeur: 4.8cm),
  numworks-graphique(t1, largeur: 4.8cm, couleur: blue, fenetre: (-4, 14, -1, 8)),
  numworks-graphique(t2, largeur: 4.8cm, couleur: blue, fenetre: (-4, 14, -1, 8)),
))

#align(center, numworks-solveur(t2))
