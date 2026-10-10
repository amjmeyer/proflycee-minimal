// Arbres de probabilités (§53 de la doc ProfLycee 4.00f) : exemples de la doc.
#import "../../src/lib.typ": *
#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 1cm)

#arbre-probas((
  ($A$, $0,5$),
    ($B$, $0,4$),
    ($overline(B)$, $...$),
  ($overline(A)$, $...$),
    ($B$, $...$),
    ($overline(B)$, $1/3$),
))

#cetz.canvas({
  import cetz.draw: *
  arbre-probas-dessin(
    (
      ($A_1$, $0,5$),
        ($B$, $0,4$),
        ($overline(B)$, $dots$),
      ($A_2$, $dots$),
        ($B$, $dots$),
        ($overline(B)$, $1/3$),
      ($A_3$, $dots$),
        ($B$, $dots$),
        ($overline(B)$, $4/15$),
    ),
    type: "3x2",
    fleche: true,
    espace-niveau: 5,
    espace-feuille: 1.25,
    position-probas: "auto"
  )
  line(
    "A24", 
    (rel: (1.5, 0)), 
    stroke: green.darken(30%), 
    mark: (end: "stealth")
  )
  content(
    (),
    [$P(A_2 inter overline(B))$], 
    anchor: "west", 
    padding: 0.1  )
})

#arbre-probas(
  (
    ($A$, $0,05$, "dessus"),
      ($B_1$, $0,4$, "dessus"), ($B_2$, $0,35$), ($B_3$, none, "dessous"),
    ($overline(A)$, $...$, "dessous"),
      ($B_1$, $2/15$, "dessus"), ($B_2$, $...$), ($B_3$, $1/3$, "dessous"),
  ),
  type: "2x3",
  incline-probas: false,
  espace-feuille: 1.15
)

#let tiers = $1"/"3$

#arbre-probas(
  (
    ($A_1$, $0,05$), ($B_1$, tiers), ($B_2$, tiers), ($B_3$, tiers),
    ($A_2$, $0,80$), ($B_1$, tiers), ($B_2$, tiers), ($B_3$, tiers),
    ($A_3$, $0,15$), ($B_1$, tiers), ($B_2$, tiers), ($B_3$, tiers),
  ),
  type: "3x3",
  style-trait: "densely-dashed",
  couleur-traits: red,
  couleur-probas: blue,
  couleur-noeuds: olive,
  espace-feuille: 0.7,
  police-probas: text.with(size: 7pt),
  police: text.with(size: 0.9em)
)
