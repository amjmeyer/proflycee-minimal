// Conversions entre bases (§53 de ProfLycee) : exemples de la doc.
#import "../../src/lib.typ": *
#set page(width: 16cm, height: auto, margin: 1cm)

#conversion-entre-bases("2->16", "11111110") \

#conversion-entre-bases("2->16", "11111110", aff-bases: true) \

#conversion-entre-bases("16->10", "ACDC") \

#conversion-entre-bases(
  "16->2", "ACDC",
  aff-bases: true,
  espace: none
) \

#conversion-entre-bases("16->5", "A47E", aff-bases: true) \

#conversion-entre-bases("8->7", 7777, aff-bases: true) \

#conversion-entre-bases("10->2", 2026, aff-bases: true)

#let binaire = conversion("10->2", aff-bases: true)

#binaire(5) \

#binaire(255) \

#binaire(1024)
