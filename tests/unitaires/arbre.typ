// Tests unitaires de src/arbre.typ (moteur commun des arbres).
#import "aide.typ": *
#import "/src/deps.typ": cetz
#import "/src/arbre.typ": _arbre-dessin

#{
  // le « chemin » passé à etiquette et proba est l'écriture de i dans la
  // base mixte (b1, …, bk) ; on le vérifie dans les fonctions elles-mêmes,
  // pour beaucoup de formes d'arbre
  let attendu(branchements, k, i) = {
    let c = ()
    for j in range(k - 1, -1, step: -1) {
      c.insert(0, calc.rem(i, branchements.at(j)))
      i = calc.quo(i, branchements.at(j))
    }
    c
  }
  for b in ((1,), (2,), (5,), (2, 2), (2, 3), (3, 2), (3, 3), (1, 4), (4, 1), (2, 2, 2), (3, 1, 2), (2, 3, 2, 2), (1, 1, 1)) {
    let verifie(k, i, chemin) = {
      egal(chemin, attendu(b, k, i), quoi: "chemin " + repr(b) + " niveau " + str(k) + " nœud " + str(i))
      assert(chemin.len() == k)
      [#i]
    }
    let _ = cetz.canvas(_arbre-dessin(
      b,
      verifie,
      proba: (k, i, chemin) => { let _ = verifie(k, i, chemin); ([p], none) },
    ))
  }
}

// nœuds nommés R, A11…, A21…, utilisables ensuite ; feuilles espacées de
// espace-feuille, racine à mi-hauteur
#cetz.canvas({
  import cetz.draw: *
  _arbre-dessin((2, 3), (k, i, c) => [x], espace-niveau: 2, espace-feuille: 0.5)
  get-ctx(ctx => {
    let (ctx, r) = cetz.coordinate.resolve(ctx, "R")
    let (ctx, a11) = cetz.coordinate.resolve(ctx, "A11")
    let (ctx, a12) = cetz.coordinate.resolve(ctx, "A12")
    let (ctx, a21) = cetz.coordinate.resolve(ctx, "A21")
    let (ctx, a26) = cetz.coordinate.resolve(ctx, "A26")
    proche(r.at(0), 0, quoi: "racine en x = 0")
    proche(r.at(1), 0, quoi: "racine en y = 0")
    proche(a11.at(0), 2, quoi: "niveau 1 en x = espace-niveau")
    proche(a21.at(0), 4, quoi: "niveau 2 en x = 2 espace-niveau")
    proche(a21.at(1) - a26.at(1), 5 * 0.5, quoi: "6 feuilles espacées de 0,5")
    proche(a11.at(1), -a12.at(1), quoi: "symétrie haut / bas")
    proche(a11.at(1), (a21.at(1) + (a21.at(1) - 2 * 0.5)) / 2, quoi: "nœud à mi-hauteur de ses feuilles")
  })
})

// toutes les clés acceptées, toutes les positions de probas
#for pos in (none, "auto", "dessus", "dessous", "sur") {
  for incl in (true, false) {
    cetz.canvas(_arbre-dessin(
      (2, 2),
      (k, i, c) => [N],
      proba: (k, i, c) => ([p], ("dessus", "dessous", "sur", none, "above", "below").at(calc.rem(i, 6))),
      racine: [Ω],
      espace-niveau: 1.5,
      espace-feuille: 0.8,
      fleche: true,
      trait: (paint: red, thickness: 1pt, dash: "dashed"),
      police: text.with(size: 8pt),
      police-probas: text.with(size: 6pt),
      couleur-noeuds: blue,
      couleur-probas: green,
      incline-probas: incl,
      position-probas: pos,
    ))
  }
}

arbre : ok
