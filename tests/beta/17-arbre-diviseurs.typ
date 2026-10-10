// Arbre des diviseurs (§60 de ProfLycee) : exemples de la doc.
#import "../../src/lib.typ": *
#set page(width: auto, height: auto, margin: 1cm)

#arbre-div(60)

#arbre-div(
  60,
  espace-niveau: 4,
  espace-feuille: 1,
  details: false
)

#arbre-div(
  calc.pow(2, 2) * 3 * 5 * 7 * 11,
  espace-niveau: 2,
  echelle: 0.75,
  couleur-details: teal,
  fleches: false
)
