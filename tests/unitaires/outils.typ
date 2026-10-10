// Tests unitaires de src/outils.typ : _nombre, _facteur.
#import "aide.typ": *
#import "/src/outils.typ": _nombre, _facteur

#{
  // groupement par 3 à partir de 5 chiffres, signe moins
  let cas = (
    (0, "0"), (7, "7"), (42, "42"), (999, "999"), (1000, "1000"), (9999, "9999"),
    (10000, "10000"), (12345, "12345"), (123456, "123456"), (1234567, "1234567"),
    (-5, "−5"), (-2500, "−2500"), (-13500, "−13500"),
  )
  for (n, t) in cas { egal(texte(_nombre(n)), t, quoi: "_nombre(" + str(n) + ")") }

  // les groupes sont bien séparés par des espaces fines
  egal(_nombre(13500).body.text, "13" + sym.space.thin + "500", quoi: "_nombre 13500 : espace fine")
  egal(_nombre(1234567).body.text, "1" + sym.space.thin + "234" + sym.space.thin + "567", quoi: "_nombre 1234567")
  egal(_nombre(2500).body.text, "2500", quoi: "_nombre 2500 : pas d'espace")

  // reconstruction : les chiffres affichés sont ceux de n, pour beaucoup de n
  for n in range(-3000, 3000, step: 7) + range(0, 20000000, step: 98765) {
    let t = texte(_nombre(n)).replace("−", "-")
    egal(int(t), n, quoi: "_nombre relu " + str(n))
  }

  // _facteur : parenthèses pour les négatifs seulement
  egal(texte(_facteur(6)), "6", quoi: "_facteur(6)")
  egal(texte(_facteur(0)), "0", quoi: "_facteur(0)")
  egal(texte(_facteur(-6)), "(−6)", quoi: "_facteur(-6)")
  egal(texte(_facteur(-12345)), "(−12345)", quoi: "_facteur(-12345)")
}

outils : ok
