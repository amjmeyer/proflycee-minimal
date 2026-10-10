// Diviseurs et facteurs premiers (§60 de ProfLycee) : exemples de la doc.
#import "../../src/lib.typ": *
#set page(width: 18cm, height: auto, margin: 1cm)

#liste-div(150) \

#liste-div(300, scr: true) \

#liste-div(60, aff-nom: false) \

#liste-div(36) \

#liste-div(1)

#dpfp(2781240) \

#dpfp(2781240, puissance-un: true) \

#dpfp(2781240, longue: true) \

#dpfp(97)

#prespfp(2781240)

#prespfp(
  360,
  epaisseur-trait: 0.8pt,
  encadre-fin: true
)

#simpfrac(1320, 1248) \

#simpfrac(1320, 1248, aff-couleur: true) \

#simpfrac(
  1320, 1248,
  d: true,
  barrer: true
) \

#simpfrac(
  1320, 1248,
  d: true,
  barrer: true,
  aff-couleur: true
) \

#simpfrac(84, 12, aff-couleur: true) \

#simpfrac(7, 15) \

#simpfrac(
  2 * 2 * 3 * 3 * 5 * 7 * 11, 2 * 3 * 3 * 5 * 7 * 13,
  d: true,
  barrer: true,
  aff-couleur: true
) \

#simpfrac(
  1320, 1248,
  d: true,
  barrer: true,
  aff-couleur: true,
  couleurs-barres: (purple, teal)
)
