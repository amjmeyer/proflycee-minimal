// Tests unitaires de src/analyse/resolution-approchee.typ.
#import "aide.typ": *
#import "/src/analyse/resolution-approchee.typ": resolution-approchee

#{
  let r(s) = (texte(s.defaut), texte(s.exces), texte(s.approchee))

  // exemples de la doc (et valeur affichée par la calculatrice)
  let s = resolution-approchee(x => calc.pow(x, 3) - 2 * x * x - x - 1, k: 2, intervalle: (0, 10))
  egal(r(s), ("2,75", "2,76", "2,76"), quoi: "doc 1")
  proche(s.valeur, 2.757278921, tol: 1e-9, quoi: "doc 1 : valeur")
  egal(r(resolution-approchee(x => calc.exp(0.5 * x) + x * x - 4, intervalle: (0, 2), precision: 4)), ("1,4068", "1,4069", "1,4069"), quoi: "doc 2")
  egal(r(resolution-approchee(t => 3 * t * calc.exp(-0.5 * t + 1), k: 4, intervalle: (-1, 2))), ("0,69", "0,70", "0,69"), quoi: "doc 3")
  egal(r(resolution-approchee(t => 3 * t * calc.exp(-0.5 * t + 1), k: 4, intervalle: (2, 10), precision: 3)), ("4,377", "4,378", "4,378"), quoi: "doc 4")

  // racines connues : √2, π, e, ln 2, ∛10, racine négative, fonction décroissante
  for (f, k, ab, v) in (
    (x => x * x, 2, (0, 2), calc.sqrt(2)),
    (x => calc.sin(x), 0, (3, 4), calc.pi),
    (x => calc.ln(x), 1, (2, 3), calc.e),
    (x => calc.exp(x), 2, (0, 1), calc.ln(2)),
    (x => calc.pow(x, 3), 10, (0, 5), calc.root(10, 3)),
    (x => x * x * x + 8, 0, (-5, 0), -2),
    (x => -x, -0.3, (0, 1), 0.3),
    (x => 1 / x, 4, (0.1, 1), 0.25),
  ) {
    let s = resolution-approchee(f, k: k, intervalle: ab, precision: 6)
    proche(s.valeur, v, tol: 1e-11, quoi: "racine " + repr(v))
    // encadrement : défaut ⩽ racine < excès, d'amplitude 10^-6, arrondi le plus proche
    let lire(c) = float(texte(c).replace(",", ".").replace("−", "-"))
    let (d, e, a) = (lire(s.defaut), lire(s.exces), lire(s.approchee))
    assert(d <= v + 1e-12 and v <= e + 1e-12, message: "encadrement de " + repr(v))
    proche(e - d, 1e-6, tol: 1e-9, quoi: "amplitude " + repr(v))
    assert(calc.abs(a - v) <= 0.5e-6 + 1e-12, message: "arrondi de " + repr(v))
  }

  // toutes les précisions gardent leurs décimales (2,70 et non 2,7)
  for p in range(0, 8) {
    let s = resolution-approchee(x => x, k: 2.7, intervalle: (0, 5), precision: p)
    let t = texte(s.approchee)
    egal(if p == 0 { 0 } else { t.split(",").last().len() }, p, quoi: "décimales, précision " + str(p))
  }
  egal(texte(resolution-approchee(x => x, k: 2.7, intervalle: (0, 5)).approchee), "2,70", quoi: "zéro final gardé")

  // racine sur une borne, racine exactement au milieu
  proche(resolution-approchee(x => x - 1, intervalle: (1, 3)).valeur, 1, quoi: "racine en a")
  proche(resolution-approchee(x => x - 3, intervalle: (1, 3)).valeur, 3, quoi: "racine en b")
  proche(resolution-approchee(x => x - 2, intervalle: (1, 3)).valeur, 2, quoi: "racine au milieu")
  // grand intervalle, petite racine
  proche(resolution-approchee(x => x - 1e-3, intervalle: (-1e6, 1e6)).valeur, 1e-3, tol: 1e-9, quoi: "grand intervalle")

  // le dictionnaire transmet ce qu'il faut aux écrans NumWorks
  let s = resolution-approchee(t => t * t, k: 9, intervalle: (0, 5), precision: 3, variable: "t")
  egal((s.k, s.intervalle, s.precision, s.variable), (9, (0, 5), 3, "t"), quoi: "champs")
  egal((s.f)(3), 9, quoi: "fonction transmise")
}

resolution-approchee : ok
