// Division euclidienne (§54 de ProfLycee) : exemples de la doc.
#import "../../src/lib.typ": *
#set page(width: 16cm, height: auto, margin: 1cm)

#let a = 145 
#let b = 7

$#a = #division-eucl(a, b)$  \


$#division-eucl(7,-6)$  \

#div-eucl(145, 7) \

#div-eucl(
  145, 7, 
  aff-verif: true
) \


#div-eucl(
  -145, 7, 
  aff-verif: true, 
  quotient: false
) \


#div-eucl(145, -7, reste: false) \

#div-eucl(-145, -7, vide: true) \

#div-eucl(123456789, 8547, aff-verif: true) 

#div-eucl(
  123456789, 8547, 
  vide: true, 
  pointilles: box(width: 1cm, repeat[.])
)
