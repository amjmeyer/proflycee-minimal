// remontee-euclide : cas courants et cas limites (1 seule division à reste non nul,
// b divise a, a < b) ; une assertion interne vérifie a × u + b × v = PGCD.
#import "../../src/lib.typ": *
#set page(width: 16cm, height: auto, margin: 1cm)
#remontee-euclide(150, 27)

#remontee-euclide(1250, 450)

#remontee-euclide(17, 5)

#remontee-euclide(420, 540)

#remontee-euclide(48, 12)

#remontee-euclide(240, 46, aff-conclusion: false)
