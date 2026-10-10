// Écrans NumWorks : beaucoup de cas variés (fenêtre automatique ou imposée,
// k nul, positif, négatif, racines négatives, grandes et petites valeurs).
#import "../../src/lib.typ": *
#set page(width: 19cm, height: auto, margin: 0.8cm)
#set text(size: 9pt)

#let cas(titre, s, ..cles) = box(width: 5.6cm, inset: (bottom: 6pt))[
  #titre \
  #numworks-graphique(s, largeur: 5.6cm, ..cles)
]

= Fenêtre automatique

#cas($x^2 = 2$, resolution-approchee(x => x * x, k: 2, intervalle: (0, 3)))
#h(0.2cm)
#cas($x^3 - 3x + 1 = 0$, resolution-approchee(x => calc.pow(x, 3) - 3 * x + 1, intervalle: (1, 2)))
#h(0.2cm)
#cas($cos x = x$, resolution-approchee(x => calc.cos(x) - x, intervalle: (0, 1)))

#cas($e^x = 5$, resolution-approchee(x => calc.exp(x), k: 5, intervalle: (0, 3)))
#h(0.2cm)
#cas($ln x = -1$, resolution-approchee(x => calc.ln(x), k: -1, intervalle: (0.1, 1)))
#h(0.2cm)
#cas($1/x = 3$, resolution-approchee(x => 1 / x, k: 3, intervalle: (0.1, 2)))

#cas([$x^3 + 8 = 0$ (racine négative)], resolution-approchee(x => calc.pow(x, 3) + 8, intervalle: (-3, 0)))
#h(0.2cm)
#cas([$-x^2 + 4 = 1$ (décroissante)], resolution-approchee(x => -x * x + 4, k: 1, intervalle: (0, 3)))
#h(0.2cm)
#cas($sin x = 0,5$, resolution-approchee(x => calc.sin(x), k: 0.5, intervalle: (0, 1.5)))

#cas([$1000 x^2 = 50$ (grandes valeurs)], resolution-approchee(x => 1000 * x * x, k: 50, intervalle: (0, 1)))
#h(0.2cm)
#cas([$x^2 = 0,0001$ (petites valeurs)], resolution-approchee(x => x * x, k: 0.0001, intervalle: (0, 0.05)))
#h(0.2cm)
#cas($x e^(-x) = 0,2$, resolution-approchee(x => x * calc.exp(-x), k: 0.2, intervalle: (0, 1)))

= Fenêtre imposée

#cas([même courbe, fenêtre $[-3 ; 3] times [-5 ; 5]$], resolution-approchee(x => calc.pow(x, 3) - 3 * x + 1, intervalle: (1, 2)), fenetre: (-3, 3, -5, 5))
#h(0.2cm)
#cas($tan x = 1$, resolution-approchee(x => calc.tan(x), k: 1, intervalle: (0, 1.5)), fenetre: (-3, 3, -4, 4), couleur: blue)
#h(0.2cm)
#cas($3t e^(-0,5t+1) = 4$, resolution-approchee(t => 3 * t * calc.exp(-0.5 * t + 1), k: 4, intervalle: (2, 10), variable: "t"), fenetre: (-4, 14, -1, 8), couleur: blue)

#cas([solution hors fenêtre], resolution-approchee(x => x * x, k: 2, intervalle: (0, 3)), fenetre: (-3, 1, -1, 5))
#h(0.2cm)
#cas([$x^2 = -1 + 5$ (k négatif hors de vue)], resolution-approchee(x => x * x - 5, k: -1, intervalle: (0, 3)), fenetre: (-3, 3, 0.5, 6))
#h(0.2cm)
#cas([$1/x = 2$, fenêtre avec 0, domaine $[0,05 ; 3]$], resolution-approchee(x => 1 / x, k: 2, intervalle: (0.1, 2)), fenetre: (-1, 3, -1, 6), domaine: (0.05, 3))
#h(0.2cm)
#cas([$sqrt(x) = 1,5$, intervalle depuis 0], resolution-approchee(x => calc.sqrt(x), k: 1.5, intervalle: (0, 4)))
#h(0.2cm)
#cas([couleur verte], resolution-approchee(x => calc.sqrt(x), k: 1.5, intervalle: (0, 4)), couleur: green.darken(20%))

= Solveur

#box(width: 5.6cm)[#numworks-solveur(resolution-approchee(x => x * x, k: 2, intervalle: (0, 3)), largeur: 5.6cm)]
#h(0.2cm)
#box(width: 5.6cm)[#numworks-solveur(resolution-approchee(x => calc.pow(x, 3) + 8, intervalle: (-3, 0)), largeur: 5.6cm, lignes: (("Δ", "-1728"),))]
#h(0.2cm)
#box(width: 5.6cm)[#numworks-solveur(resolution-approchee(t => calc.exp(t), k: 1000, intervalle: (0, 10), variable: "t"), largeur: 5.6cm, lignes: (("t2", "…"), ("t3", "…")))]

= Tailles

#numworks-graphique(resolution-approchee(x => x * x, k: 2, intervalle: (0, 3)), largeur: 3cm)
#numworks-solveur(resolution-approchee(x => x * x, k: 2, intervalle: (0, 3)), largeur: 3cm)
#numworks-graphique(resolution-approchee(x => x * x, k: 2, intervalle: (0, 3)), largeur: 9cm)
