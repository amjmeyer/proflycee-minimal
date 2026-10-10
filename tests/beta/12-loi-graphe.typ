// Schémas de probabilités continues (§54 de la doc ProfLycee 4.00f) : exemples de la doc.
#import "../../src/lib.typ": *
#set page(width: 16cm, height: auto, margin: 1cm)

#loi-normale-graphe(100, 10, 90, 105) #h(2cm) #loi-expo-graphe(0.001, 500, 1500)

Avec l'axe des abscisses sur la ligne de base :
#loi-normale-graphe(
  1000, 100, 950, "*",
  affiche-m: false,
  couleur-courbe: blue,
  couleur-aire: aqua,
  baseline: "axe"
)

Avec quelques modifications :

#loi-normale-graphe(
  150, 12.5, 122, 160,
  largeur: 4,
  hauteur: 2
)

Avec centrage vertical :
#loi-normale-graphe(
  200, 5, 204, none,
  largeur: 5,
  hauteur: 2.5,
  baseline: 50%
)

Avec l'axe des abscisses sur la ligne de base :
#loi-expo-graphe(
  0.05, none, 32,
  affiche-m: false,
  couleur-courbe: blue,
  couleur-aire: aqua,
  baseline: "axe"
)

#loi-expo-graphe(
  0.00025, 5000, none,
  largeur: 4,
  hauteur: 2
)

Sans cadre : #loi-normale-graphe(
  12.5, 2, none, 11,
  affiche-cadre: false,
  baseline: "axe"
) fin.
