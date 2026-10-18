// Tests unitaires de src/analyse/cercle-trigo.typ.
#import "aide.typ": *
#import "/src/deps.typ": cetz
#import "/src/analyse/cercle-trigo.typ": cercle-trigo, cercle-trigo-dessin, _angles-moins-pi, _angles-zero-deux-pi
#set page(width: auto, height: auto)

#{
  // tables des angles remarquables : 14 angles, multiples de 30° ou 45°,
  // dans l'intervalle annoncé, sans doublon
  for (table, mini, maxi) in ((_angles-moins-pi, -180, 180), (_angles-zero-deux-pi, 0, 360)) {
    egal(table.len(), 14, quoi: "14 angles")
    let degres = table.map(x => x.first())
    egal(degres.dedup().len(), 14, quoi: "angles distincts")
    for d in degres {
      assert(calc.rem(d, 30) == 0 or calc.rem(d, 45) == 0, message: "angle non remarquable " + str(d))
      assert(mini < d and d < maxi, message: "angle hors intervalle " + str(d))
    }
  }
  // les deux tables désignent les mêmes points du cercle
  egal(_angles-moins-pi.map(x => calc.rem-euclid(x.first(), 360)).sorted(), _angles-zero-deux-pi.map(x => x.first()).sorted(), quoi: "mêmes points")
}

// taille : le cercle de rayon R tient dans un carré d'au moins 2R
#context {
  for R in (1, 2, 3, 4.5) {
    let m = measure(cercle-trigo(rayon: R, aff-valeurs: false, aff-angles: false))
    assert(m.width >= 2 * R * 1cm and m.width < (2 * R + 2) * 1cm, message: "largeur rayon " + str(R))
    assert(m.height >= 2 * R * 1cm, message: "hauteur rayon " + str(R))
  }
}

// combinaisons de toutes les clés booléennes
#for aa in (true, false) { for at in (true, false) { for av in (true, false) { for mp in (true, false) { for vt in (true, false) {
  cercle-trigo(rayon: 1.5, aff-angles: aa, aff-traits: at, aff-valeurs: av, moins-pi: mp, valeurs-tan: vt)
} } } } }

// équations : cos et sin sur une grille d'angles, y compris 0, ±90, 180
#for c in range(-180, 181, step: 30) {
  cercle-trigo(rayon: 1, aff-valeurs: false, aff-angles: false, equation-cos: true, cos: c)
  cercle-trigo(rayon: 1, aff-valeurs: false, aff-angles: false, equation-sin: true, sin: c, aff-traits-eq: false)
}
#cercle-trigo(rayon: 1.5, equation-cos: true, equation-sin: true, cos: 135, sin: 45, couleur-sol: orange)

// point M dans toutes les directions (axes compris), noms personnalisés
#for a in range(-360, 361, step: 15) {
  cercle-trigo(rayon: 1, aff-valeurs: false, aff-angles: false, aff-traits: false, point: a)
}
#cercle-trigo(rayon: 2, point: 200, nom-point: $P$, nom-angle: $alpha$)

// autres clés
#cercle-trigo(rayon: 2.5, epaisseur: 2pt, marge: 0.5, taille-valeurs: 5pt, taille-angles: 10pt, couleur-fond: yellow.lighten(80%), decal: 4pt)

// clés absentes de ProfLycee : interrupteur des remarquables, couleur, sens
// direct, origine, graduations, vecteurs, points des angles sans les angles
#cercle-trigo(rayon: 1.5, aff-remarquables: false, couleur-cercle: blue, aff-sens: true, aff-origine: true, aff-graduations: true, aff-vecteurs: true)
#cercle-trigo(rayon: 2, aff-valeurs: false, aff-angles: false, aff-points: true)
#cercle-trigo(rayon: 2, aff-points: false)
#cercle-trigo(rayon: 2, aff-remarquables: false, aff-points: true, aff-axes: false)

// aff-remarquables: false l'emporte sur les clés de ProfLycee
#context {
  let a = measure(cercle-trigo(rayon: 1, aff-remarquables: false))
  let b = measure(cercle-trigo(rayon: 1, aff-remarquables: false, aff-valeurs: true, aff-angles: true))
  let c = measure(cercle-trigo(rayon: 1, aff-valeurs: false, aff-angles: false, aff-traits: false))
  egal(a, b, quoi: "remarquables coupés")
  egal(a, c, quoi: "équivaut aux trois clés")
}

// angles : nombre de degrés ou angle Typst, même figure
#context {
  let deg = measure(cercle-trigo(rayon: 1, aff-remarquables: false, point: 135, points: ((angle: 200, nom: $P$),), arcs: ((de: 0, a: 60),)))
  let rad = measure(cercle-trigo(rayon: 1, aff-remarquables: false, point: 3 * calc.pi / 4 * 1rad, points: ((angle: 200deg, nom: $P$),), arcs: ((de: 0deg, a: calc.pi / 3 * 1rad),)))
  egal(deg, rad, quoi: "degrés ou angle Typst")
}
#cercle-trigo(rayon: 1.5, aff-remarquables: false, equation-cos: true, cos: 60deg, equation-sin: true, sin: calc.pi / 6 * 1rad)

// éléments ajoutés : points (axes compris, ancre imposée), angles au centre,
// arcs (plus d'un tour), rayons, axe réel et enroulements (réels négatifs,
// nuls, de plus d'un tour)
#cercle-trigo(rayon: 1.5, aff-remarquables: false, points: range(-360, 361, step: 45).map(a => (angle: a, nom: $P$)) + ((angle: 100, nom: $Q$, ancre: "north", couleur: red),))
#cercle-trigo(rayon: 2, aff-remarquables: false, aff-axes: false, taille-noms: 12pt,
  angles: ((de: 0, a: 1rad, nom: $1$, fond: gray), (de: 200, a: -30)),
  arcs: ((de: 0, a: 57.3, fleche: true, nom: [arc]), (de: 90, a: 450, couleur: blue, epaisseur: 0.5pt)),
  rayons: ((angle: 0, nom: $A$, etiquette: $1$), (angle: 135, nom: $B$, couleur: green, fleche: true, copie: (-2, 1), nom-copie: $arrow(u)$)))
#cercle-trigo(rayon: 1, aff-remarquables: false, aff-axe-reel: true,
  enroulements: ((x: 2, nom: $M$), (x: -1, couleur: orange), (x: 0), (x: 9, segment: false, arc: false)),
  intervalles: ((de: -1, a: 2), (de: 3, a: 0, couleur: blue, epaisseur: 1pt)))

// version dessin dans un canvas
#cetz.canvas({
  cercle-trigo-dessin(rayon: 1, aff-valeurs: false)
  cetz.draw.circle((0, 0), radius: 0.05, fill: red)
})

cercle-trigo : ok
