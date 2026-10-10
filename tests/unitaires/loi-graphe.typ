// Tests unitaires de src/probas/loi-graphe.typ.
#import "aide.typ": *
#import "/src/deps.typ": cetz
#import "/src/probas/loi-graphe.typ": *
#import "/src/probas/loi-graphe.typ": _nombre, _axe

#{
  // écriture française des valeurs affichées
  for (x, t) in ((150, "150"), (12.5, "12,5"), (4000, "4000"), (13500, "13500"), (-2.25, "−2,25"), (0.001, "0,001"), (1000.0, "1000")) {
    egal(texte(_nombre(x)), t, quoi: "_nombre(" + repr(x) + ")")
  }
}

// taille : largeur × hauteur (le cadre fixe la taille, même invisible)
#context {
  for (L, H) in ((2, 1), (4, 2), (5, 2.5), (1, 3)) {
    for cadre in (true, false) {
      let m = measure(loi-normale-graphe(0, 1, -1, 1, largeur: L, hauteur: H, affiche-cadre: cadre))
      proche(m.width / 1cm, L, tol: 0.03, quoi: "largeur " + str(L))
      proche(m.height / 1cm, H, tol: 0.03, quoi: "hauteur " + str(H))
      let m = measure(loi-expo-graphe(1, 0, 2, largeur: L, hauteur: H, affiche-cadre: cadre))
      proche(m.width / 1cm, L, tol: 0.03, quoi: "largeur expo " + str(L))
    }
  }
}

// toutes les bornes : finies, none, "*", hors de l'intervalle tracé, a > b
#for (a, b) in ((none, none), ("*", 1), (-1, "*"), (-10, 10), (2, 1), (0, 0), (-0.5, 0.5), (3.9, 100)) {
  loi-normale-graphe(0, 1, a, b)
  loi-expo-graphe(0.5, a, b)
}

// paramètres variés, toutes les clés, baseline
#for (m, s) in ((0, 1), (1000, 100), (150, 12.5), (-50, 0.01), (1e6, 1e4)) {
  loi-normale-graphe(m, s, m - s, m + 2 * s, couleur-aire: aqua, couleur-courbe: blue, largeur: 3, hauteur: 1.5, affiche-m: false, affiche-cadre: false)
}
#for l in (0.00025, 0.05, 1, 30) {
  loi-expo-graphe(l, 1 / l, none, baseline: "axe")
}
Texte #loi-normale-graphe(0, 1, 0, none, baseline: "axe") texte #loi-normale-graphe(0, 1, 0, none, baseline: 50%) texte #loi-normale-graphe(0, 1, 0, none, baseline: 3pt).

// la ligne de base "axe" pose l'axe des abscisses à _axe du bas
#context {
  let b = box(loi-normale-graphe(0, 1, 0, none, baseline: "axe"))
  egal(_axe, 0.2, quoi: "hauteur de l'axe")
}

// versions -dessin dans un canvas de l'utilisateur
#cetz.canvas({
  loi-normale-graphe-dessin(10, 2, 9, 12)
  cetz.draw.translate((3, 0))
  loi-expo-graphe-dessin(2, none, 1, affiche-m: false)
})

loi-graphe : ok
