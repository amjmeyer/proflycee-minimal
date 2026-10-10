// cercle-trigo-dessin dans un canvas de l'utilisateur, complété à la main.
#import "../../src/lib.typ": *
#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 1cm)

#cetz.canvas({
  import cetz.draw: *
  cercle-trigo-dessin(
    rayon: 2,
    aff-valeurs: false
  )
  circle((1, 1), radius: 0.1, fill: red)
})
