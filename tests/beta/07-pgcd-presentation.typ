// presentation-pgcd : exemples de la doc ProfLycee (p. 183-184).
#import "../../src/lib.typ": *
#set page(width: 16cm, height: auto, margin: 1cm)
#presentation-pgcd(150, 27)

#presentation-pgcd(150, 27, couleur-resultat: true)

#presentation-pgcd(1250, 450, couleur-resultat: true, couleur: green)

#presentation-pgcd(13500, 2500, couleur-resultat: true, couleur: blue)

#presentation-pgcd(420, 540, rectangle: false)

D'après l'algorithme d'Euclide, on a #presentation-pgcd(150, 27, aff-conclusion: false). Suite du texte.

$ [ #presentation-pgcd(1234, 5, aff-conclusion: false, aff-delimiteurs: false) ] $
