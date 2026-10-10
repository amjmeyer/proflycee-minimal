// Tests unitaires de src/arithmetique/pgcd.typ.
#import "aide.typ": *
#import "/src/arithmetique/pgcd.typ": _divisions, presentation-pgcd, remontee-euclide

#{
  // _divisions : chaque ligne est une division euclidienne, la suite des
  // restes décroît jusqu'à 0, le dernier reste non nul est le PGCD
  for a in range(1, 121) {
    for b in range(1, 121) {
      let e = _divisions(a, b)
      for (x, y, q, r) in e {
        egal(y * q + r, x, quoi: "division " + str(a) + ", " + str(b))
        assert(0 <= r and r < y)
      }
      for i in range(1, e.len()) {
        egal(e.at(i).slice(0, 2), (e.at(i - 1).at(1), e.at(i - 1).at(3)), quoi: "enchaînement " + str(a) + ", " + str(b))
      }
      egal(e.last().at(3), 0, quoi: "dernier reste nul")
      egal(e.last().at(1), calc.gcd(a, b), quoi: "PGCD " + str(a) + ", " + str(b))
    }
  }

  // presentation-pgcd : texte exact de la doc, conclusion juste partout
  egal(texte(presentation-pgcd(150, 27)), "{150|=|27×5|+|15|27|=|15×1|+|12|15|=|12×1|+|3|12|=|3×4|+|0|⟹PGCD(150;27)=3")
  egal(texte(presentation-pgcd(420, 540)).starts-with("{420|=|540×0|+|420"), true, quoi: "a < b")
  egal(texte(presentation-pgcd(48, 12)), "{48|=|12×4|+|0|⟹PGCD(48;12)=12")
  egal(texte(presentation-pgcd(7, 7)), "{7|=|7×1|+|0|⟹PGCD(7;7)=7")
  egal(texte(presentation-pgcd(150, 27, aff-conclusion: false)), "{150|=|27×5|+|15|27|=|15×1|+|12|15|=|12×1|+|3|12|=|3×4|+|0|")
  egal(texte(presentation-pgcd(150, 27, aff-delimiteurs: false)).starts-with("150|"), true, quoi: "sans délimiteurs")
  egal(texte(presentation-pgcd(13500, 2500)).ends-with("PGCD(13500;2500)=500"), true, quoi: "grands nombres")
  for (a, b) in ((1, 1), (1, 99), (99, 1), (89, 55), (1000000, 999999), (2147483647, 1073741823)) {
    egal(texte(presentation-pgcd(a, b)).ends-with("=" + str(calc.gcd(a, b))), true, quoi: "conclusion " + str(a) + ", " + str(b))
  }
  // toutes les clés acceptées
  let _ = presentation-pgcd(150, 27, couleur: blue, decal-rect: 4pt, rectangle: false, couleur-resultat: true)

  // remontee-euclide : son assertion interne vérifie a u + b v = PGCD ; on
  // la déclenche sur une grande grille, et on relit (u ; v)
  for a in range(1, 70) {
    for b in range(1, 70) {
      let t = texte(remontee-euclide(a, b))
      if t.contains("(u;v)=(") {
        let (u, v) = t.split("(u;v)=(").last().split(")").first().replace("−", "-").split(";").map(int)
        egal(a * u + b * v, calc.gcd(a, b), quoi: "Bézout relu " + str(a) + ", " + str(b))
      } else {
        // b divise a : conclusion « a × 0 + b × 1 = d »
        assert(t.ends-with("×0+" + str(b) + "×1=" + str(b) + "."), message: "remontée, b | a : " + str(a) + ", " + str(b))
      }
    }
  }
  // Fibonacci : la plus longue remontée pour sa taille
  let _ = remontee-euclide(832040, 514229)
  egal(texte(remontee-euclide(150, 27)).ends-with("(u;v)=(2;−11)convient."), true, quoi: "doc 150, 27")
  egal(texte(remontee-euclide(240, 46, aff-conclusion: false)).contains("Ainsi"), false, quoi: "sans conclusion")
}

pgcd : ok
