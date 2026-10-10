// Tests unitaires de src/analyse/suites.typ.
#import "aide.typ": *
#import "/src/analyse/suites.typ": *
#import "/src/analyse/suites.typ": _termes

#{
  let g = x => 1 / (x + 2)
  let f = x => 1 + (1 + x * x) / (1 + x)

  // exemples de la doc
  egal(texte(calcul-terme-recurrence(g, no: 0, uno: 50, n: 10)), "0,414")
  egal(texte(calcul-terme-recurrence(g, no: 0, uno: 50, n: 15, precision: 4)), "0,4142")
  egal(texte(calcul-terme-recurrence(g, no: 0, uno: 50, n: 20, precision: 6)), "0,414214")
  egal(texte(solution-seuil(f, 5, balayage: true, no: 1, uno: 2)), "Parbalayage,onobtient{u_7≈4,868⩽5|u_8≈5,209>5|⟹n⩾8")
  egal(texte(solution-seuil(f, 5, calculatrice: true, precision: 4, no: 1, uno: 2, conclusion: false)), "Parcalculatrice,onobtient{u_7≈4,8681⩽5|u_8≈5,2089>5")
  egal(texte(solution-seuil(f, 10, precision: 4, no: 1, uno: 2, simple: true)), "u_28≈9,9408⩽10etu_29≈10,1236>10")
  egal(rang-seuil(f, 10, no: 1, uno: 2), 29)
  let u = suite-recurrente(f, no: 1, uno: 2)
  egal(range(1, 8).map(n => texte(u(n))), ("2,000", "2,667", "3,212", "3,687", "4,114", "4,505", "4,868"), quoi: "tableau de la doc")

  // termes : suites arithmétiques, géométriques, formule explicite
  for (r, u0, no) in ((3, 5, 0), (-2, 1, 1), (0.5, -7, 4)) {
    for n in range(no, no + 40) {
      proche(calcul-terme-recurrence(x => x + r, no: no, uno: u0, n: n, brut: true), u0 + r * (n - no), tol: 1e-12, quoi: "arithmétique")
    }
  }
  for (q, u0) in ((2, 1), (0.5, 1024), (-3, 1), (1.05, 1000)) {
    for n in range(0, 30) {
      proche(calcul-terme-recurrence(x => q * x, uno: u0, n: n, brut: true), u0 * calc.pow(q, n), tol: 1e-12, quoi: "géométrique q = " + str(q))
    }
  }
  // u(n+1) = 0,5 u(n) + 3 : u(n) = 6 + (u0 - 6) 0,5^n
  for n in range(0, 60) {
    proche(calcul-terme-recurrence(x => 0.5 * x + 3, uno: 10, n: n, brut: true), 6 + 4 * calc.pow(0.5, n), tol: 1e-12, quoi: "arithmético-géométrique")
  }
  // g converge vers √2 - 1
  proche(calcul-terme-recurrence(g, uno: 50, n: 60, brut: true), calc.sqrt(2) - 1, tol: 1e-12, quoi: "limite")
  // u(no) = uno, et la fabrique coïncide avec la commande
  egal(calcul-terme-recurrence(g, no: 3, uno: 7, n: 3, brut: true), 7.0, quoi: "terme initial")
  let v = suite-recurrente(g, no: 0, uno: 50)
  for n in range(0, 25) {
    egal(v(n, brut: true), calcul-terme-recurrence(g, uno: 50, n: n, brut: true), quoi: "fabrique " + str(n))
    egal(texte(v(n, precision: 5)), texte(calcul-terme-recurrence(g, uno: 50, n: n, precision: 5)), quoi: "fabrique formatée " + str(n))
  }
  egal(_termes(x => x + 1, 2, 0, 6), (0.0, 1.0, 2.0, 3.0, 4.0), quoi: "_termes")

  // rang-seuil : premier rang qui vérifie, pour les quatre sens
  let w = x => x + 1 // w(n) = n avec no = 0, uno = 0
  egal(rang-seuil(w, 5, uno: 0), 6, quoi: "> 5")
  egal(rang-seuil(w, 5, uno: 0, sens: ">="), 5, quoi: ">= 5")
  egal(rang-seuil(x => x - 1, -5, uno: 0, sens: "<"), 6, quoi: "< -5")
  egal(rang-seuil(x => x - 1, -5, uno: 0, sens: "<="), 5, quoi: "<= -5")
  egal(rang-seuil(w, 5.5, no: 10, uno: 0), 16, quoi: "rang initial décalé")
  egal(rang-seuil(w, -1, uno: 0), 0, quoi: "déjà vérifié au départ")
  // contre la force brute, sur une suite géométrique
  for S in (1.5, 10, 1000, 1e6) {
    let N = rang-seuil(x => 1.1 * x, S, uno: 1)
    assert(calc.pow(1.1, N) > S and calc.pow(1.1, N - 1) <= S, message: "rang géométrique " + str(S))
  }
  // relations, contraires, conclusion
  egal(texte(solution-seuil(w, 5, uno: 0)), "{u_5≈5,000⩽5|u_6≈6,000>5|⟹n⩾6")
  egal(texte(solution-seuil(w, 5, uno: 0, sens: ">=")), "{u_4≈4,000<5|u_5≈5,000⩾5|⟹n⩾5")
  egal(texte(solution-seuil(x => x - 1, -5, uno: 0, sens: "<", precision: 0)), "{u_5≈−5⩾−5|u_6≈−6<−5|⟹n⩾6")
  egal(texte(solution-seuil(x => x - 1, -5, uno: 0, sens: "<=", precision: 1)), "{u_4≈−4,0>−5|u_5≈−5,0⩽−5|⟹n⩾5")
  // clés de présentation
  egal(texte(solution-seuil(w, 5, uno: 0, exact: true, precision: 0)), "{u_5=5⩽5|u_6≈6>5|⟹n⩾6")
  egal(texte(solution-seuil(w, 5, uno: 0, exact-b: true, precision: 0)), "{u_5≈5⩽5|u_6=6>5|⟹n⩾6")
  egal(texte(solution-seuil(w, 5, uno: 0, nom-suite: "v", precision: 0, simple: true)), "v_5≈5⩽5etv_6≈6>5")
  egal(texte(solution-seuil(w, 5, uno: 0, balayage: true, majuscule: false, precision: 0, conclusion: false)), "parbalayage,onobtient{u_5≈5⩽5|u_6≈6>5")
  egal(texte(solution-seuil(w, 2.5, uno: 0, precision: 1)), "{u_2≈2,0⩽2,5|u_3≈3,0>2,5|⟹n⩾3")
  egal(texte(solution-seuil(w, 12345, uno: 12000, precision: 0, simple: true)), "u_345≈12345⩽12345etu_346≈12346>12345")
  // stretch : plus d'espace entre les lignes
}
#context {
  let h(c) = measure(c).height
  let w = x => x + 1
  assert(h(solution-seuil(w, 5, uno: 0, stretch: 3)) > h(solution-seuil(w, 5, uno: 0)), message: "stretch sans effet")
}

suites : ok
