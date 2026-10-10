// Tests unitaires de src/probas/calculs-lois.typ.
#import "aide.typ": *
#import "/src/probas/calculs-lois.typ": *
#import "/src/probas/calculs-lois.typ": _grouper, _decimal, _ln-fact, _ln-binom, _phi

#{
  // --- outils numériques ---------------------------------------------------
  // ln(n!) : exact jusqu'à 20, Lancers au-delà, raccord continu
  for n in range(0, 21) { proche(_ln-fact(n), calc.ln(calc.fact(n)), tol: 1e-14, quoi: "ln " + str(n) + "!") }
  for n in range(21, 200) { proche(_ln-fact(n), _ln-fact(n - 1) + calc.ln(n), tol: 1e-13, quoi: "ln n! = ln (n-1)! + ln n, n = " + str(n)) }
  proche(_ln-fact(100), 363.73937555556347, tol: 1e-13, quoi: "ln 100!")
  for n in range(0, 60) {
    for k in range(0, n + 1) {
      proche(calc.exp(_ln-binom(n, k)), float(calc.binom(n, k)), tol: 1e-11, quoi: "C(" + str(n) + ", " + str(k) + ")")
    }
  }

  // Φ : valeurs de référence, symétrie, monotonie, raccord série / fraction en 3
  for (z, v) in (
    (0, 0.5), (1, 0.8413447460685429), (1.96, 0.9750021048517795), (-1.96, 0.024997895148220435),
    (2, 0.9772498680518208), (3, 0.9986501019683699), (-3, 0.0013498980316301035),
    (4, 0.9999683287581669), (-5, 2.866515718791939e-7), (6, 0.9999999990134123), (-8, 6.22096057427178e-16),
  ) { proche(_phi(z), v, tol: 1e-13, quoi: "Φ(" + str(z) + ")") }
  for i in range(-800, 801, step: 7) {
    let z = i / 100
    proche(_phi(z) + _phi(-z), 1, tol: 1e-14, quoi: "Φ(z) + Φ(-z) = 1, z = " + str(z))
    assert(_phi(z) <= _phi(z + 0.07) + 1e-16, message: "Φ décroissante en " + str(z))
  }
  proche(_phi(2.999999), _phi(3.000001), tol: 1e-6, quoi: "raccord en 3")
  proche(_phi(-2.999999), _phi(-3.000001), tol: 1e-6, quoi: "raccord en -3")

  // --- formatage -------------------------------------------------------------
  egal(_grouper("1234"), "1234")
  egal(_grouper("12345"), "12" + sym.space.thin + "345")
  egal(_grouper("1234", depuis-gauche: true), "123" + sym.space.thin + "4")
  egal(_grouper("123", depuis-gauche: true), "123")
  egal(_grouper("0000288", depuis-gauche: true), "000" + sym.space.thin + "028" + sym.space.thin + "8")
  let f(x, a, s: false) = texte(_decimal(x, a, s))
  for (x, a, s, t) in (
    (0.0477903522728147, 4, false, "0,0478"), (0.9044192954543706, 4, false, "0,9044"),
    (2.877077765846743e-5, 7, false, "0,0000288"), (2.877077765846743e-5, 7, true, "2,88×10^−5"),
    (1.670210428685021e-9, 10, false, "0,0000000017"), (1.670210428685021e-9, 10, true, "1,7×10^−9"),
    (0.67032, 3, false, "0,670"), (0.5, 0, false, "1"), (0.4, 0, false, "0"), (0.9996, 3, false, "1,000"),
    (0.00049, 3, false, "0,000"), (0.00049, 3, true, "0,000"), (0.0005, 3, false, "0,001"), (1, 3, false, "1,000"),
    (12345.678, 2, false, "12345,68"), (-0.25, 2, false, "−0,25"), (-0.001, 2, false, "0,00"),
    (0.123456, 3, true, "1,23×10^−1"), (1, 2, true, "1,00"), (12.5, 1, true, "1,25×10^1"),
  ) { egal(f(x, a, s: s), t, quoi: "_decimal(" + repr(x) + ", " + str(a) + ", " + repr(s) + ")") }

  // --- lois discrètes : masses positives, somme 1, cumul = somme ------------
  let p(X, k) = X(k, brut: true)
  let c(X, a, b) = X(a, b, brut: true)
  let lois = (
    ("B(10 ; 0,3)", loi-binomiale(10, 0.3), 0, 10),
    ("B(1 ; 0,5)", loi-binomiale(1, 0.5), 0, 1),
    ("B(50 ; 0,02)", loi-binomiale(50, 0.02), 0, 50),
    ("B(200 ; 0,5)", loi-binomiale(200, 0.5), 0, 200),
    ("B(1000 ; 0,001)", loi-binomiale(1000, 0.001), 0, 1000),
    ("B(7 ; 0)", loi-binomiale(7, 0), 0, 7),
    ("B(7 ; 1)", loi-binomiale(7, 1), 0, 7),
    ("H(50 ; 10 ; 5)", loi-hypergeometrique(50, 10, 5), 0, 5),
    ("H(20 ; 15 ; 10)", loi-hypergeometrique(20, 15, 10), 5, 10),
    ("H(10 ; 10 ; 3)", loi-hypergeometrique(10, 10, 3), 3, 3),
  )
  for (nom, X, mini, maxi) in lois {
    let total = range(mini, maxi + 1).map(k => p(X, k)).sum()
    proche(total, 1, tol: 1e-12, quoi: "somme des masses " + nom)
    for k in range(mini, maxi + 1) { assert(p(X, k) >= 0, message: "masse négative " + nom) }
    egal(p(X, mini - 1), 0.0, quoi: "hors support à gauche " + nom)
    egal(p(X, maxi + 1), 0.0, quoi: "hors support à droite " + nom)
    proche(c(X, none, none), 1, tol: 1e-12, quoi: "P(Ω) " + nom)
    proche(c(X, "*", "*"), 1, tol: 1e-12, quoi: "P(Ω) avec * " + nom)
    // toutes les paires de bornes sur les petits supports, un échantillon
    // sur les grands (sinon des millions de cumuls)
    let bornes = if maxi - mini <= 12 { range(mini - 1, maxi + 2) } else {
      (mini - 1, mini, mini + 1, mini + 2, calc.quo(mini + maxi, 2), maxi - 1, maxi, maxi + 1)
    }
    for a in bornes {
      for b in bornes.filter(x => x >= a) {
        let somme = range(calc.max(a, mini), calc.min(b, maxi) + 1).map(k => p(X, k)).sum(default: 0)
        proche(c(X, a, b), somme, tol: 1e-12, quoi: "cumul " + nom + " [" + str(a) + " ; " + str(b) + "]")
      }
      proche(c(X, a, none) + c(X, none, a - 1), 1, tol: 1e-12, quoi: "complémentaire " + nom)
    }
    egal(c(X, maxi, mini - 1), 0, quoi: "a > b " + nom)
  }
  // lois à support infini
  for (nom, X, mini) in (
    ("P(5)", loi-poisson(5), 0), ("P(0,1)", loi-poisson(0.1), 0), ("P(80)", loi-poisson(80), 0),
    ("G(0,5)", loi-geometrique(0.5), 1), ("G(0,05)", loi-geometrique(0.05), 1), ("G(1)", loi-geometrique(1), 1),
  ) {
    proche(range(mini, mini + 1500).map(k => p(X, k)).sum(), 1, tol: 1e-10, quoi: "somme des masses " + nom)
    egal(p(X, mini - 1), 0.0, quoi: "hors support " + nom)
    for a in range(mini, mini + 30) {
      proche(c(X, a, none), 1 - range(mini, a).map(k => p(X, k)).sum(default: 0), tol: 1e-10, quoi: "P(X ⩾ a) " + nom)
      proche(c(X, none, a), range(mini, a + 1).map(k => p(X, k)).sum(), tol: 1e-12, quoi: "P(X ⩽ a) " + nom)
    }
  }
  // valeurs de référence
  proche(p(loi-binomiale(5, 0.4), 3), 0.2304, quoi: "B(5;0,4) = 3")
  proche(c(loi-binomiale(5, 0.4), none, 1), 0.33696, quoi: "B(5;0,4) ⩽ 1")
  proche(p(loi-binomiale(100, 0.02), 10), 2.877077765846743e-5, tol: 1e-12, quoi: "B(100;0,02) = 10")
  proche(p(loi-poisson(5), 3), 0.1403738958142806, quoi: "P(5) = 3")
  proche(p(loi-geometrique(0.5), 3), 0.125, quoi: "G(0,5) = 3")
  proche(p(loi-hypergeometrique(50, 10, 5), 4), 0.003964583058015065, tol: 1e-12, quoi: "H = 4")
  // espérances : n p, λ, 1/p, m n/N
  proche(range(0, 201).map(k => k * p(loi-binomiale(200, 0.3), k)).sum(), 60, tol: 1e-10, quoi: "E binomiale")
  proche(range(0, 300).map(k => k * p(loi-poisson(7.5), k)).sum(), 7.5, tol: 1e-10, quoi: "E Poisson")
  proche(range(1, 2000).map(k => k * p(loi-geometrique(0.1), k)).sum(), 10, tol: 1e-8, quoi: "E géométrique")
  proche(range(0, 11).map(k => k * p(loi-hypergeometrique(50, 10, 5), k)).sum(), 1, tol: 1e-12, quoi: "E hypergéométrique")
  // bornes non entières : arrondies vers l'intérieur
  proche(c(loi-binomiale(10, 0.5), 2.5, 4.9), c(loi-binomiale(10, 0.5), 3, 4), quoi: "bornes non entières")

  // --- lois continues --------------------------------------------------------
  let N = loi-normale(550, 30)
  proche(c(N, 600, none), 0.0477903522728147, tol: 1e-13, quoi: "N(550;30) ⩾ 600")
  proche(c(N, 500, 600), 0.9044192954543706, tol: 1e-13, quoi: "N(550;30) [500;600]")
  proche(c(N, none, none), 1, quoi: "N Ω")
  proche(c(N, 550, none), 0.5, quoi: "N ⩾ m")
  egal(c(N, 600, 500), 0.0, quoi: "N a > b")
  proche(c(N, 400, 400), 0, quoi: "N intervalle réduit à un point")
  for i in range(-40, 41) {
    let x = 550 + i * 3.7
    proche(c(N, none, x) + c(N, x, none), 1, tol: 1e-14, quoi: "N complémentaire en " + str(x))
    proche(c(N, none, x), c(N, 1100 - x, none), tol: 1e-14, quoi: "N symétrie en " + str(x))
  }
  proche(c(loi-normale(0, 1), -1.96, 1.96), 0.9500042097035591, tol: 1e-13, quoi: "intervalle à 95 %")
  proche(c(loi-normale(0, 1), 8, none), 6.22096057427178e-16, tol: 1e-12, quoi: "queue lointaine, précision relative")
  let E = loi-exponentielle(0.001)
  proche(c(E, 400, none), 0.6703200460356393, tol: 1e-14, quoi: "E ⩾ 400")
  proche(c(E, 300, 750), 0.2684516679407032, tol: 1e-14, quoi: "E [300;750]")
  proche(c(E, none, 0), 0, quoi: "E ⩽ 0")
  proche(c(E, -5, none), 1, quoi: "E ⩾ -5")
  proche(c(E, none, 1000), 1 - calc.exp(-1), tol: 1e-14, quoi: "E ⩽ 1/λ")
  // absence de mémoire
  for (s, t) in ((100, 200), (0, 50), (1000, 1)) {
    proche(c(E, s + t, none) / c(E, s, none), c(E, t, none), tol: 1e-12, quoi: "sans mémoire")
  }

  // --- commandes ProfLycee = lois -------------------------------------------
  proche(calc-binom-p(10, 0.3, 4), p(loi-binomiale(10, 0.3), 4), quoi: "calc-binom-p")
  proche(calc-binom-c(10, 0.3, 2, 5), c(loi-binomiale(10, 0.3), 2, 5), quoi: "calc-binom-c")
  proche(calc-poiss-p(3, 2), p(loi-poisson(3), 2), quoi: "calc-poiss-p")
  proche(calc-poiss-c(3, "*", 2), c(loi-poisson(3), none, 2), quoi: "calc-poiss-c")
  proche(calc-geom-p(0.2, 4), p(loi-geometrique(0.2), 4), quoi: "calc-geom-p")
  proche(calc-geom-c(0.2, 2, "*"), c(loi-geometrique(0.2), 2, none), quoi: "calc-geom-c")
  proche(calc-hypergeom-p(20, 7, 5, 2), p(loi-hypergeometrique(20, 7, 5), 2), quoi: "calc-hypergeom-p")
  proche(calc-hypergeom-c(20, 7, 5, 1, 3), c(loi-hypergeometrique(20, 7, 5), 1, 3), quoi: "calc-hypergeom-c")
  proche(calc-norm-c(0, 1, none, 1), _phi(1), quoi: "calc-norm-c")
  proche(calc-expo-c(2, 1, none), calc.exp(-2), quoi: "calc-expo-c")
  egal(texte(binom-p(100, 0.02, 10, arrondi: 7)), "0,0000288", quoi: "binom-p")
  egal(texte(binom-p(100, 0.02, 10, arrondi: 7, scientifique: true)), "2,88×10^−5", quoi: "binom-p *")
  egal(texte(binom-c(100, 0.02, 15, 25, arrondi: 10, scientifique: true)), "1,7×10^−9", quoi: "binom-c *")
  egal(texte(poisson-p(5, 3)), "0,140", quoi: "poisson-p")
  egal(texte(poisson-c(5, 2, none, arrondi: 4)), "0,9596", quoi: "poisson-c")
  egal(texte(geom-p(0.5, 3)), "0,125", quoi: "geom-p")
  egal(texte(geom-c(0.5, none, 5, arrondi: 5)), "0,96875", quoi: "geom-c")
  egal(texte(hypergeom-p(50, 10, 5, 4, arrondi: 5)), "0,00396", quoi: "hypergeom-p")
  egal(texte(hypergeom-c(50, 10, 5, 1, 3, arrondi: 4)), "0,6854", quoi: "hypergeom-c")
  egal(texte(normale-c(550, 30, 600, none, arrondi: 4)), "0,0478", quoi: "normale-c")
  egal(texte(expo-c(0.001, 400, none)), "0,670", quoi: "expo-c")
  // la loi fabriquée : formatage par défaut 3 décimales, brut = flottant
  let X = loi-binomiale(5, 0.4)
  egal(texte(X(3)), "0,230", quoi: "X(3)")
  egal(texte(X(2, none, arrondi: 5)), "0,66304", quoi: "X(2, none)")
  egal(type(X(3, brut: true)), float, quoi: "brut : flottant")
  egal(type(X(3)), content, quoi: "formaté : contenu")
}

probas : ok
