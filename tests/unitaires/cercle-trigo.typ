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

// version dessin dans un canvas
#cetz.canvas({
  cercle-trigo-dessin(rayon: 1, aff-valeurs: false)
  cetz.draw.circle((0, 0), radius: 0.05, fill: red)
})

cercle-trigo : ok
