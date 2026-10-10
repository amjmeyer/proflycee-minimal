// Tests unitaires de src/arithmetique/division-eucl.typ.
#import "aide.typ": *
#import "/src/arithmetique/division-eucl.typ": _division, division-eucl, div-eucl

#{
  // exemples de la doc, rendu exact
  egal(texte(division-eucl(145, 7)), "7×20+5")
  egal(texte(division-eucl(-40, 7)), "7×(−6)+2")
  egal(texte(division-eucl(145, -7)), "−7×(−20)+5")
  egal(texte(div-eucl(145, 7)), "145=7×20+5")
  egal(texte(div-eucl(145, 7, aff-verif: true)), "145=7×20+5avec0⩽5<7")
  egal(texte(div-eucl(-145, 7, aff-verif: true, quotient: false)), "−145=7×…+2avec0⩽2<7")
  egal(texte(div-eucl(145, -7, reste: false)), "145=−7×(−20)+…")
  egal(texte(div-eucl(-145, -7, vide: true)), "−145=−7×…+…")
  egal(texte(div-eucl(123456789, 8547, aff-verif: true)), "123456789=8547×14444+3921avec0⩽3921<8547")
  egal(texte(div-eucl(10, 3, vide: true, pointilles: [?])), "10=3×?+?")
  egal(texte(div-eucl(10, 3, quotient: false, reste: false)), "10=3×…+…")
  egal(texte(div-eucl(-7, -7)), "−7=−7×1+0")
  egal(texte(div-eucl(0, 5)), "0=5×0+0")

  // identité et encadrement du reste, grande grille
  for a in range(-300, 301) {
    for b in range(-25, 26) {
      if b == 0 { continue }
      let (q, r) = _division(a, b)
      egal(b * q + r, a, quoi: "a = bq + r pour " + str(a) + ", " + str(b))
      assert(0 <= r and r < calc.abs(b), message: "reste hors de [0 ; |b|[ : " + str(a) + ", " + str(b))
    }
  }
  // grands entiers, près des bornes 64 bits (b × q dépasserait : on compare
  // aux valeurs attendues)
  for (a, b, q, r) in (
    (9223372036854775807, 2, 4611686018427387903, 1),
    (-9223372036854775807, 10, -922337203685477581, 3),
    (-9223372036854775807, -10, 922337203685477581, 3),
    (9223372036854775807, -1, -9223372036854775807, 0),
    (1000000007, -97, -10309278, 41),
    (123456789123, 987654, 125000, 39123),
  ) {
    egal(_division(a, b), (q, r), quoi: "grand " + str(a) + " / " + str(b))
  }
  egal(texte(div-eucl(-9223372036854775807, 10)), "−9223372036854775807=10×(−922337203685477581)+3", quoi: "rendu près de la borne")

  // le texte relu redonne bien q et r
  for (a, b) in ((17, 5), (-17, 5), (17, -5), (-17, -5), (4, 9), (-4, 9)) {
    let (q, r) = _division(a, b)
    let t = texte(division-eucl(a, b)).replace("−", "-").replace("(", "").replace(")", "")
    egal(t, (str(b) + "×" + str(q) + "+" + str(r)).replace("−", "-"), quoi: "texte " + str(a) + ", " + str(b))
  }
}

division-eucl : ok
