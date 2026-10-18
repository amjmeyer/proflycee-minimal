// Clés de cercle-trigo absentes de ProfLycee : une figure de cours par cas
// (repère, points nommés, gabarit, radian, enroulement, angle orienté).
#import "../../src/lib.typ": *
#import "../../src/deps.typ": cetz
#set page(width: 17cm, height: auto, margin: 1cm)
#set text(size: 9pt)

#let vert = rgb("#228B22")
#let ocre = rgb("#B8860B")
#let exemple(titre, code, figure) = block(breakable: false, width: 100%, inset: 6pt, stroke: 0.4pt + gray, radius: 3pt)[
  *#titre* \
  #grid(columns: (1fr, auto), column-gutter: 8pt, align: horizon, text(size: 7pt, raw(code, lang: "typc")), figure)
]

#exemple(
  "Repère, sens direct, vecteurs i et j",
  "cercle-trigo(rayon: 1.5, aff-remarquables: false, couleur-cercle: blue,\n  aff-sens: true, aff-origine: true, aff-vecteurs: true)",
  cercle-trigo(rayon: 1.5, aff-remarquables: false, couleur-cercle: blue, aff-sens: true, aff-origine: true, aff-vecteurs: true),
)

#exemple(
  "Points nommés : angles en degrés (80) ou angles Typst (180deg, … * 1rad)",
  "cercle-trigo(rayon: 1.5, aff-remarquables: false, aff-origine: true,\n  aff-graduations: true, points: (\n  (angle: 80, nom: $A$), (angle: 0.8 * calc.pi * 1rad, nom: $B$),\n  (angle: 180deg, nom: $C$), (angle: 9 * calc.pi / 7 * 1rad, nom: $D$),\n  (angle: -90, nom: $E$)))",
  cercle-trigo(
    rayon: 1.5,
    aff-remarquables: false, 
    aff-origine: true, 
    aff-graduations: true, 
    points: (
      (angle: 80, nom: $A$), 
      (angle: 0.8 * calc.pi * 1rad, nom: $B$), 
      (angle: 180deg, nom: $C$), 
      (angle: 9 * calc.pi / 7 * 1rad, nom: $D$), 
      (angle: -90, nom: $E$)
    ),
  ),
)

#exemple(
  "Gabarit vierge : points remarquables sans leurs angles",
  "cercle-trigo(rayon: 2, aff-valeurs: false,\n  aff-angles: false, aff-points: true)",
  cercle-trigo(rayon: 2, aff-valeurs: false, aff-angles: false, aff-points: true),
)

#exemple(
  "Définition du radian : cercle sans axes, angle, rayons, arc",
  "cercle-trigo(rayon: 2, aff-remarquables: false, aff-axes: false,\n  aff-origine: true,\n  angles: ((de: 0, a: 1rad, nom: $1 upright(\"rad\")$,\n    couleur: black, fond: gray.lighten(70%)),),\n  rayons: ((angle: 0, nom: $A$),\n    (angle: 1rad, nom: $B$)),\n  arcs: ((de: 0, a: 1rad, epaisseur: 1pt,\n    fleche: true),))",
  {
    cercle-trigo(rayon: 2, aff-remarquables: false, aff-axes: false, aff-origine: true,
      angles: ((de: 0, a: 1rad, nom: $1 upright("rad")$, couleur: black, fond: gray.lighten(70%)),),
      rayons: ((angle: 0, nom: $A$), (angle: 1rad, nom: $B$)),
      arcs: ((de: 0, a: 1rad, epaisseur: 1pt, fleche: true),))
  },
)

#exemple(
  "Enroulement de la droite réelle (x en radians)",
  "cercle-trigo(rayon: 1, aff-remarquables: false, aff-origine: true,\n  aff-vecteurs: true, aff-axe-reel: true,\n  enroulements: (\n    (x: 2, nom: $M(2)$),\n    (x: -1, nom: $P(-1)$, couleur: orange)))",
  cercle-trigo(rayon: 1, aff-remarquables: false, aff-origine: true, aff-vecteurs: true, aff-axe-reel: true,
    enroulements: ((x: 2, nom: $M(2)$), (x: -1, nom: $P(-1)$, couleur: orange))),
)

#exemple(
  "Plus d'un tour : deux réels pour un même point",
  "cercle-trigo(rayon: 0.8, aff-remarquables: false, aff-sens: true,\n  enroulements: (\n    (x: 9 * calc.pi / 8, nom: $M((9pi)/8)$),\n    (x: -7 * calc.pi / 8, nom: $P(-(7pi)/8)$,\n     couleur: ocre)))",
  cercle-trigo(rayon: 0.8, aff-remarquables: false, aff-sens: true,
    enroulements: ((x: 9 * calc.pi / 8, nom: $M((9pi)/8)$), (x: -7 * calc.pi / 8, nom: $P(-(7pi)/8)$, couleur: ocre))),
)

#exemple(
  "Angle orienté de deux vecteurs de norme 1",
  "cercle-trigo(rayon: 2, aff-remarquables: false, couleur-cercle: blue,\n  aff-origine: true, aff-sens: true,\n  arcs: ((de: 20, a: 110),),\n  rayons: (\n    (angle: 20, nom: $U$, couleur: vert, fleche: true),\n    (angle: 110, nom: $V$, couleur: ocre, fleche: true)),\n  angles: ((de: 20, a: 110,\n    nom: $(arrow(u), arrow(v))$),))",
  cercle-trigo(rayon: 2, aff-remarquables: false, couleur-cercle: blue, aff-origine: true, aff-sens: true,
    arcs: ((de: 20, a: 110),),
    rayons: ((angle: 20, nom: $U$, couleur: vert, fleche: true), (angle: 110, nom: $V$, couleur: ocre, fleche: true)),
    angles: ((de: 20, a: 110, nom: $(arrow(u), arrow(v))$),)),
)

#exemple(
  "Arc IU = x, arc IV = y : spirales seules, complétées dans son canvas",
  "cetz.canvas(length: 1.5cm, {\n  let (x, y) = (70deg.rad(), 120deg.rad())\n  cercle-trigo-dessin(rayon: 1, aff-remarquables: false, aff-origine: true,\n    aff-axe-reel: true, arcs: ((de: 70, a: 120),),\n    rayons: ((angle: 70, nom: $U$, couleur: vert),\n      (angle: 120, nom: $V$, couleur: ocre)),\n    enroulements: (\n      (x: x, nom: $x$, segment: false, arc: false),\n      (x: y, nom: $y$, couleur: ocre,\n       segment: false, arc: false)))\n  cetz.draw.line((1, x), (1, y), stroke: red + 2pt)\n})",
  cetz.canvas(length: 1.5cm, {
    let (x, y) = (70deg.rad(), 120deg.rad())
    cercle-trigo-dessin(rayon: 1, aff-remarquables: false, aff-origine: true, aff-axe-reel: true,
      arcs: ((de: 70, a: 120),),
      rayons: ((angle: 70, nom: $U$, couleur: vert), (angle: 120, nom: $V$, couleur: ocre)),
      enroulements: ((x: x, nom: $x$, segment: false, arc: false), (x: y, nom: $y$, couleur: ocre, segment: false, arc: false)))
    cetz.draw.line((1, x), (1, y), stroke: red + 2pt)
  }),
)
