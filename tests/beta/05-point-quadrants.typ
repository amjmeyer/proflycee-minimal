// Point M avec cos et sin, dans les quatre quadrants (les clés cos/sin
// masquent les opérateurs : vérifier qu'on lit bien cos(θ) et sin(θ)).
#import "../../src/lib.typ": *
#set page(width: auto, height: auto, margin: 1cm)
#for a in (50, 140, 220, 320) { cercle-trigo(rayon: 2, aff-valeurs: false, aff-traits: false, point: a) }
