// Tests unitaires de src/probas/arbre-probas.typ.
#import "aide.typ": *
#import "/src/deps.typ": cetz
#import "/src/probas/arbre-probas.typ": arbre-probas, arbre-probas-dessin

// données d'un arbre p × q : nœud du 1er niveau puis ses q enfants
#let donnees(p, q) = range(p).map(i => (([$A_#i$], [$#i$]),) + range(q).map(j => ([$B_#j$], [$#j$]))).flatten().chunks(2)

// toutes les formes, y compris hors de ProfLycee (1×4, 4×1, 5×2)
#for (p, q) in ((2, 2), (2, 3), (3, 2), (3, 3), (1, 1), (1, 4), (4, 1), (5, 2)) {
  arbre-probas(donnees(p, q), type: str(p) + "x" + str(q))
}

// nœuds nommés comme EnvArbreProbasTikz, et texte des nœuds dans l'ordre
#cetz.canvas({
  import cetz.draw: *
  arbre-probas-dessin(donnees(3, 2), type: "3x2")
  for nom in ("R", "A11", "A12", "A13", "A21", "A24", "A26") {
    line(nom, (rel: (0.1, 0)))
  }
})

// probas absentes (none), position par donnée, toutes les clés
#arbre-probas(
  (
    ($A$, none, "dessus"), ($B$, $0,4$, "above"), ($overline(B)$, none),
    ($overline(A)$, $0,5$, "dessous"), ($B$, $0,1$, "below"), ($overline(B)$, $0,9$, "sur"),
  ),
  unite: 0.8cm,
  espace-niveau: 2,
  espace-feuille: 0.7,
  police: text.with(size: 9pt),
  police-probas: text.with(size: 7pt),
  incline-probas: false,
  racine: $Omega$,
  fleche: true,
  style-trait: "dotted",
  epaisseur-trait: 1pt,
  couleur-traits: red,
  couleur-noeuds: blue,
  couleur-probas: green,
)

#for pos in ("auto", "dessus", "dessous", "sur") {
  arbre-probas(donnees(2, 3), type: "2x3", position-probas: pos)
}

// couleurs effectivement employées
#releve("ap", arbre-probas(donnees(2, 2), couleur-noeuds: blue, couleur-probas: green))
#context egal(couleurs("ap").sorted(key: repr), (blue, green).sorted(key: repr), quoi: "couleurs des nœuds et probas")

arbre-probas : ok
