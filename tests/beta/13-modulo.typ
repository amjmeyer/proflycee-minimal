// Réduction modulo (§52 de ProfLycee) : exemples de la doc.
#import "../../src/lib.typ": *
#set page(width: 16cm, height: auto, margin: 1cm)

$1234 equiv #reste-mod(1234, 26) space [26] equiv #reste-mod(1234, 26, negatif: true) space [26]$ \

$98 equiv #reste-mod(98, 9) space [9]$ \

$98 equiv #reste-mod(98, 9, negatif: true) space [9]$ \

$7^50 equiv #reste-mod(7, 8, puissance: 50) space [8]$ \

$-17 equiv #reste-mod(-17, 5) space [5]$ \

$-17 = 5 times #quo-mod(-17, 5) + 3$ \

$1234 = 26 times #quo-mod(1234, 26) + 12$ \

$9 equiv #reste-mod(9, 9, negatif: true) space [9]$

#let m26 = modulo(26)

$1234 equiv #m26(1234) space [26]$ \

$-1 equiv #m26(-1) space [26]$ \

$3^100 equiv #m26(3, puissance: 100) space [26]$
