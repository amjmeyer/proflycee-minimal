// Tests unitaires de src/arithmetique/conversion-bases.typ.
#import "aide.typ": *
#import "/src/arithmetique/conversion-bases.typ": _lire, conversion, conversion-entre-bases

#{
  // exemples de la doc
  egal(texte(conversion-entre-bases("2->16", "11111110")), "11111110=FE")
  egal(texte(conversion-entre-bases("2->16", "11111110", aff-bases: true)), "11111110_2=FE_16")
  egal(texte(conversion-entre-bases("16->10", "ACDC")), "ACDC=44252")
  egal(texte(conversion-entre-bases("16->2", "ACDC", aff-bases: true, espace: none)), "ACDC_16=1010110011011100_2")
  egal(texte(conversion-entre-bases("16->5", "A47E", aff-bases: true)), "A47E_16=2321420_5")
  egal(texte(conversion-entre-bases("8->7", 7777, aff-bases: true)), "7777_8=14640_7")

  // _lire contre str(v, base: b), toutes bases, beaucoup de valeurs
  for b in range(2, 37) {
    for v in range(0, 400) + (1295, 46655, 1000000, 2147483647, 9007199254740993) {
      let s = str(v, base: b)
      egal(_lire(s, b), v, quoi: "_lire " + s + " base " + str(b))
      egal(_lire(upper(s), b), v, quoi: "_lire majuscules")
    }
  }
  // aller-retour par conversion, entre toutes les paires de bases
  for d in (2, 3, 7, 8, 10, 16, 36) {
    for a in (2, 5, 8, 10, 12, 16, 20, 36) {
      let f = conversion(str(d) + "->" + str(a), espace: none)
      for v in (0, 1, 2, 35, 36, 255, 256, 4096, 99999) {
        let gauche = str(v, base: d)
        let t = texte(f(gauche))
        egal(t, upper(gauche) + "=" + upper(str(v, base: a)), quoi: "conversion " + str(d) + "->" + str(a) + " de " + str(v))
      }
    }
  }
  // espaces dans le sens, minuscules en entrée
  egal(texte(conversion-entre-bases(" 16 -> 10 ", "ff")), "FF=255")
  // blocs de 4 en binaire seulement (le texte ignore les espaces : on
  // vérifie la structure avec espace: none / défaut sur le nombre de h())
  let nb-h(c) = repr(c).matches("h(").len()
  assert(nb-h(conversion-entre-bases("10->2", 255)) >= 1, message: "blocs binaires absents")
  egal(nb-h(conversion-entre-bases("10->2", 255, espace: none)), 0, quoi: "espace none")
  egal(nb-h(conversion-entre-bases("10->2", 15)), 0, quoi: "4 chiffres : pas de bloc")
  egal(nb-h(conversion-entre-bases("10->16", 65535)), 0, quoi: "pas de bloc hors binaire")
  egal(nb-h(conversion-entre-bases("10->2", 1024)), 2, quoi: "11 chiffres : 3 blocs")
  // la fonction fabriquée et la commande coïncident
  let hexa = conversion("10->16", aff-bases: true)
  for v in range(0, 300, step: 13) {
    egal(texte(hexa(v)), texte(conversion-entre-bases("10->16", v, aff-bases: true)), quoi: "fabrique " + str(v))
  }
}

conversion-bases : ok
