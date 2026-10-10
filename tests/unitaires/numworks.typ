// Tests unitaires de src/analyse/numworks.typ.
#import "aide.typ": *
#import "/src/analyse/resolution-approchee.typ": resolution-approchee
#import "/src/analyse/numworks.typ": numworks-solveur, numworks-graphique, _nombre-ecran, _pas, _pas-passant-par

#{
  // nombres comme sur la calculatrice : point, chiffres significatifs, tiret
  for (x, c, t) in (
    (2.7572789214024596, 10, "2.757278921"), (1.4068791423272273, 7, "1.406879"),
    (0.6939632194151528, 7, "0.6939632"), (4.377668331627433, 7, "4.377668"),
    (0, 10, "0"), (4, 7, "4"), (-439, 10, "-439"), (-2.5, 10, "-2.5"), (1234567.891, 7, "1234568"),
    (0.000123456789, 4, "0.0001235"), (100, 3, "100"), (99.99, 3, "100"),
  ) { egal(_nombre-ecran(x, c), t, quoi: "_nombre-ecran(" + repr(x) + ", " + str(c) + ")") }

  // pas des graduations : 1, 2 ou 5 × 10^p, environ 4 graduations
  for (e, p) in ((10, 5), (4, 1), (8, 2), (1, 0.5), (0.3, 0.1), (100, 50), (18, 5), (7, 2)) {
    proche(_pas(e), p, quoi: "_pas(" + str(e) + ")")
  }
  // pas passant par k : k en est un multiple, entre 2 et 6 graduations ;
  // none quand k est trop petit devant la fenêtre
  proche(_pas-passant-par(9, 4), 4, quoi: "fenêtre -1..8, k = 4")
  proche(_pas-passant-par(2, 4), 4 / 6, quoi: "petite fenêtre, k = 4 : pas k / 6 (3 graduations)")
  egal(_pas-passant-par(1100, 50), none, quoi: "k petit devant la fenêtre")
  egal(_pas-passant-par(30, 4), none, quoi: "k = 4, hauteur 30 : 7,5 graduations")
  for (e, k) in ((9, 4), (10, 2), (3, 0.5), (100, 30), (9, -4), (2, 7), (14, 1)) {
    let p = _pas-passant-par(e, k)
    if p == none { continue }
    let m = calc.abs(k) / p
    proche(m, calc.round(m), tol: 1e-9, quoi: "k multiple du pas, e = " + str(e) + ", k = " + str(k))
    assert(2 <= e / p and e / p <= 6, message: "graduations lisibles, e = " + str(e) + ", k = " + str(k))
  }
  for e in (0.01, 0.37, 1, 3.3, 12, 77, 1000, 123456) {
    let n = e / _pas(e)
    assert(2 <= n and n <= 4.0001, message: "nombre de graduations pour " + str(e))
  }
}

// taille : proportions 320 × 240 de l'écran réel
#let s = resolution-approchee(x => calc.pow(x, 3) - 2 * x * x - x - 1, k: 2, intervalle: (0, 10))
#context {
  for L in (3cm, 6cm, 10cm) {
    for e in (numworks-solveur(s, largeur: L), numworks-graphique(s, largeur: L)) {
      let m = measure(e)
      proche(m.width / L, 1, tol: 0.01, quoi: "largeur")
      proche(m.height / m.width, 0.75, tol: 0.01, quoi: "proportions")
    }
  }
}

// textes affichés (relevés pendant le rendu du canvas)
#releve-textes("solveur", numworks-solveur(s))
#releve-textes("lignes", numworks-solveur(s, lignes: (("Δ", "-439"), ("x2", "7"))))
#releve-textes("variable", numworks-solveur(resolution-approchee(t => t, k: 1, intervalle: (0, 2), variable: "t")))
#releve-textes("graphique", numworks-graphique(s))
#releve-textes("antecedent", numworks-graphique(
  resolution-approchee(t => 3 * t * calc.exp(-0.5 * t + 1), k: 4, intervalle: (-1, 2), variable: "t"),
  fenetre: (-4, 14, -1, 8),
))
#releve-textes("grand-k", numworks-graphique(resolution-approchee(x => 1000 * x * x, k: 50, intervalle: (0, 1))))
#releve-textes("zeros", numworks-graphique(resolution-approchee(x => x * x - 2, intervalle: (0, 2))))
#context {
  let t = textes("solveur")
  for m in ("SOLVEUR", "Équations", "Solution", "x1", "2.757278921", "rad") {
    assert(t.contains(m), message: "solveur : « " + m + " » absent de " + repr(t))
  }
  assert(textes("lignes").contains("Δ-439") and textes("lignes").contains("x27"), message: "solveur : lignes ajoutées")
  assert(textes("variable").contains("t1"), message: "solveur : variable")
  let t = textes("graphique")
  for m in ("FONCTIONS", "Expressions", "Graphique", "Tableau", "Antécédent", "x=2.757279", "f(x)=2") {
    assert(t.contains(m), message: "graphique : « " + m + " » absent de " + repr(t))
  }
  // l'étiquette « 4 » est un texte à part entière (graduation de l'axe)
  assert("4" in state("antecedent", ()).final(), message: "graphique : pas de graduation 4 en ordonnée")
  // k à part : la graduation 50 est là, sans une forêt d'étiquettes
  let g = state("grand-k", ()).final()
  assert("50" in g, message: "graphique : graduation k = 50 absente")
  assert(g.filter(t => t.match(regex("^-?[0-9.]+$")) != none).len() <= 10, message: "graphique : trop d'étiquettes " + repr(g))
  assert(textes("zeros").contains("Zéros") and textes("zeros").contains("f(x)=0"), message: "graphique : Zéros si k = 0")
}

// fenêtres variées : auto, imposée, solution hors fenêtre, courbe qui sort
#numworks-graphique(s, fenetre: (-1, 4, -4, 6))
#numworks-graphique(s, fenetre: (5, 9, -1, 1))
#numworks-graphique(resolution-approchee(x => 1 / x, k: 2, intervalle: (0.1, 3)))
#numworks-graphique(resolution-approchee(x => calc.tan(x), k: 1, intervalle: (0, 1.5)), fenetre: (-3, 3, -5, 5), couleur: blue)
#numworks-graphique(resolution-approchee(x => 1e6 * x, k: 3e5, intervalle: (0, 1)))
#numworks-graphique(resolution-approchee(x => x, k: 0, intervalle: (-1e-3, 1e-3)))


numworks : ok
