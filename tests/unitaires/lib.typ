// Tests unitaires de src/lib.typ : chaque fonction publique est exportée,
// et seulement elles (pas les outils internes en _…).
#import "aide.typ": *
#import "/src/lib.typ"

#{
  let publiques = (
    "cercle-trigo", "cercle-trigo-dessin",
    "presentation-pgcd", "remontee-euclide",
    "reste-mod", "quo-mod", "modulo",
    "conversion-entre-bases", "conversion",
    "division-eucl", "div-eucl",
    "liste-div", "arbre-div", "arbre-div-dessin", "dpfp", "prespfp", "simpfrac",
    "loi-binomiale", "loi-poisson", "loi-geometrique", "loi-hypergeometrique", "loi-normale", "loi-exponentielle",
    "calc-binom-p", "calc-binom-c", "calc-poiss-p", "calc-poiss-c", "calc-geom-p", "calc-geom-c",
    "calc-hypergeom-p", "calc-hypergeom-c", "calc-norm-c", "calc-expo-c",
    "binom-p", "binom-c", "poisson-p", "poisson-c", "geom-p", "geom-c",
    "hypergeom-p", "hypergeom-c", "normale-c", "expo-c",
    "arbre-probas", "arbre-probas-dessin",
    "loi-normale-graphe", "loi-normale-graphe-dessin", "loi-expo-graphe", "loi-expo-graphe-dessin",
  )
  let exportes = dictionary(lib).keys()
  for nom in publiques {
    assert(nom in exportes, message: "lib.typ n'exporte pas " + nom)
    egal(type(dictionary(lib).at(nom)), function, quoi: nom + " est une fonction")
  }
  for nom in exportes {
    assert(nom in publiques, message: "lib.typ exporte en trop : " + nom)
  }
  egal(exportes.len(), publiques.len(), quoi: "nombre d'exports")
}

lib : ok
