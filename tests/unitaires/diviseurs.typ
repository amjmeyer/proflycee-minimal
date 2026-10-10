// Tests unitaires de src/arithmetique/diviseurs.typ.
#import "aide.typ": *
#import "/src/deps.typ": cetz
#import "/src/arithmetique/diviseurs.typ": (
  _facteurs, _facteurs-longs, liste-div, dpfp, prespfp, simpfrac, arbre-div, arbre-div-dessin,
)

#{
  let premier(p) = p >= 2 and range(2, calc.floor(calc.sqrt(p)) + 1).all(d => calc.rem(p, d) != 0)

  // _facteurs : produit, primalité, ordre strict, pour n de 1 à 3000
  for n in range(1, 3001) + (65536, 999983, 1000000, 2781240, 9699690, 9999991, 10000000, 99999989) {
    let f = _facteurs(n)
    egal(f.fold(1, (s, (p, a)) => s * calc.pow(p, a)), n, quoi: "produit des facteurs de " + str(n))
    for (p, a) in f { assert(a >= 1 and premier(p), message: "facteur non premier " + str(p) + " dans " + str(n)) }
    for i in range(1, f.len()) { assert(f.at(i - 1).first() < f.at(i).first(), message: "facteurs non croissants : " + str(n)) }
    egal(_facteurs-longs(n).fold(1, (s, p) => s * p), n, quoi: "facteurs longs de " + str(n))
  }
  egal(_facteurs(1), (), quoi: "1 n'a pas de facteur")
  egal(_facteurs(2781240), ((2, 3), (3, 1), (5, 1), (7, 2), (11, 1), (43, 1)), quoi: "doc")
  egal(_facteurs(9699690), ((2, 1), (3, 1), (5, 1), (7, 1), (11, 1), (13, 1), (17, 1), (19, 1)), quoi: "primorielle 19")
  egal(_facteurs(99999989), ((99999989, 1),), quoi: "grand premier < 10^8")
  egal(_facteurs(9973 * 9967), ((9967, 1), (9973, 1)), quoi: "deux premiers proches de 10^4")

  // liste-div : contre la force brute
  for n in range(1, 400) + (720, 5040, 9973, 10000) {
    let attendu = range(1, n + 1).filter(d => calc.rem(n, d) == 0).map(str).join(";")
    egal(texte(liste-div(n, aff-nom: false)), "{" + attendu + "}", quoi: "liste-div " + str(n))
  }
  egal(texte(liste-div(150)), "D_150={1;2;3;5;6;10;15;25;30;50;75;150}")
  egal(texte(liste-div(36, scr: false)), "D_36={1;2;3;4;6;9;12;18;36}")
  egal(texte(liste-div(1)), "D_1={1}")
  egal(texte(liste-div(10007)), "D_10007={1;10007}")
  egal(texte(liste-div(13500, aff-nom: false)).ends-with(";6750;13500}"), true, quoi: "grands diviseurs")

  // dpfp
  egal(texte(dpfp(2781240)), "2^3×3×5×7^2×11×43")
  egal(texte(dpfp(2781240, puissance-un: true)), "2^3×3^1×5^1×7^2×11^1×43^1")
  egal(texte(dpfp(2781240, longue: true)), "2×2×2×3×5×7×7×11×43")
  egal(texte(dpfp(1)), "1")
  egal(texte(dpfp(97)), "97")
  egal(texte(dpfp(1024)), "2^10")
  egal(texte(dpfp(1024, longue: true)), (("2",) * 10).join("×"))
  egal(texte(dpfp(13500)), "2^2×3^3×5^3")
  egal(texte(dpfp(9973 * 9967)), "9967×9973")
  // relecture : la décomposition affichée redonne n
  for n in range(2, 1500, step: 7) {
    let t = texte(dpfp(n))
    let v = t.split("×").map(x => {
      let (p, ..e) = x.split("^")
      calc.pow(int(p), if e.len() > 0 { int(e.first()) } else { 1 })
    }).fold(1, (s, x) => s * x)
    egal(v, n, quoi: "dpfp relu " + str(n))
  }

  // prespfp : colonnes n | p, jusqu'au 1
  egal(texte(prespfp(12)), "12|2|6|2|3|3|1|")
  egal(texte(prespfp(1)), "1|")
  egal(texte(prespfp(97)), "97|97|1|")
  egal(texte(prespfp(2781240)).split("|").len(), 2 * 10, quoi: "prespfp 2781240 : 9 facteurs + la ligne du 1")
  egal(texte(prespfp(360, encadre-fin: true)), "360|2|180|2|90|2|45|3|15|3|5|5|1|")

  // simpfrac
  egal(texte(simpfrac(1320, 1248)), "(1320)/(1248)=(2×2×2×3×5×11)/(2×2×2×2×2×3×13)=(55)/(52)")
  egal(texte(simpfrac(1320, 1248, barrer: true)), "(1320)/(1248)=(~2~×~2~×~2~×~3~×5×11)/(~2~×~2~×~2~×2×2×~3~×13)=(55)/(52)")
  egal(texte(simpfrac(84, 12)), "(84)/(12)=(2×2×3×7)/(2×2×3)=7")
  egal(texte(simpfrac(7, 15)), "(7)/(15)=(7)/(3×5)=(7)/(15)")
  egal(texte(simpfrac(1, 1)), "(1)/(1)=(1)/(1)=1")
  egal(texte(simpfrac(5, 10)), "(5)/(10)=(5)/(2×5)=(1)/(2)")
  egal(texte(simpfrac(12, 1)), "(12)/(1)=(2×2×3)/(1)=12")
  // le résultat est la fraction irréductible, et seuls les communs sont barrés
  for (a, b) in ((6, 4), (100, 75), (360, 84), (17, 51), (2 * 3 * 3 * 5 * 7 * 11, 2 * 3 * 3 * 5 * 7 * 13), (1000, 1000)) {
    let g = calc.gcd(a, b)
    let t = texte(simpfrac(a, b, barrer: true))
    let fin = t.split("=").last()
    let attendu = if b == g { str(calc.quo(a, g)) } else { "(" + str(calc.quo(a, g)) + ")/(" + str(calc.quo(b, g)) + ")" }
    egal(fin, attendu, quoi: "simpfrac résultat " + str(a) + "/" + str(b))
    egal(t.matches("~").len(), 2 * 2 * _facteurs-longs(g).len(), quoi: "nombre de barrés " + str(a) + "/" + str(b))
  }

  // arbre-div : construction sans erreur pour beaucoup de n et de clés
  for n in (2, 3, 4, 6, 12, 30, 36, 60, 64, 97, 210, 360, 1024, 2 * 3 * 5 * 7 * 11) {
    let _ = cetz.canvas(arbre-div-dessin(n))
  }
  let _ = arbre-div(60, echelle: 0.5, details: false, fleches: false, espace-niveau: 4, espace-feuille: 1, couleur-details: teal)
}

// couleurs de simpfrac : rien sans aff-couleur, une couleur commune, ou une
// couleur par nombre premier barré (liste reprise en boucle si trop courte)
#releve("s-defaut", simpfrac(1320, 1248))
#releve("s-barrer", simpfrac(1320, 1248, barrer: true))
#releve("s-commun", simpfrac(1320, 1248, aff-couleur: true))
#releve("s-4", simpfrac(2 * 3 * 5 * 7, 2 * 3 * 5 * 7 * 11, aff-couleur: true, barrer: true))
#releve("s-2", simpfrac(2 * 3 * 5 * 7, 2 * 3 * 5 * 7 * 11, aff-couleur: true, barrer: true, couleurs-barres: (red, blue)))
#releve("s-perso", simpfrac(6, 4, aff-couleur: true, couleur-commun: teal))
#context {
  egal(couleurs("s-defaut"), (), quoi: "pas de couleur par défaut")
  egal(couleurs("s-barrer"), (), quoi: "barrer sans couleur")
  egal(couleurs("s-commun"), (red.darken(10%),), quoi: "couleur commune par défaut")
  egal(couleurs("s-4"), (red, blue, green.darken(20%), orange), quoi: "4 premiers, 4 couleurs dans l'ordre")
  egal(couleurs("s-2"), (red, blue), quoi: "liste de 2 couleurs reprise en boucle")
  egal(couleurs("s-perso"), (teal,), quoi: "couleur-commun")
}

// simpfrac : d agrandit les fractions, t les garde en taille de texte
#context {
  let h(c) = measure(c).height
  assert(h(simpfrac(4, 6, d: true)) > h(simpfrac(4, 6)), message: "simpfrac d : fractions pas plus grandes")
  egal(h(simpfrac(4, 6, t: true)), h(simpfrac(4, 6)), quoi: "simpfrac t (en ligne, déjà en petit)")
  egal(h($#simpfrac(4, 6, t: true)$), h(simpfrac(4, 6, t: true)), quoi: "simpfrac t stable")
}

// scr par défaut, cal sur demande : les styles n'apparaissent pas dans
// repr, on compare les largeurs des rendus
#context {
  let l(c) = measure(c).width
  egal(l(liste-div(6)), l(liste-div(6, scr: true)), quoi: "liste-div : scr par défaut")
  assert(l(liste-div(6)) != l(liste-div(6, scr: false)), message: "liste-div : scr et cal identiques")
  egal(l(liste-div(6, scr: false)), l($cal(D)_6 = lr(\{1 med";"med 2 med";"med 3 med";"med 6\})$), quoi: "liste-div : cal")
}

diviseurs : ok
