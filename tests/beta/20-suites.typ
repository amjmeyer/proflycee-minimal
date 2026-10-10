// Suites récurrentes simples (§9 de ProfLycee 4.02b) ; le tableau n | u_n
// de la doc est remplacé par l'écran NumWorks de l'application Suites.
#import "../../src/lib.typ": *
#set page(width: 16cm, height: auto, margin: 1cm)

#let g = x => 1 / (x + 2)

Avec $display(cases(u_0 = 50, u_(n+1) = display(1 / (u_n + 2))))$.

On obtient $u_10 approx #calcul-terme-recurrence(g, no: 0, uno: 50, n: 10)$. \

On obtient $u_15 approx #calcul-terme-recurrence(g, no: 0, uno: 50, n: 15, precision: 4)$. \

On obtient $u_20 approx #calcul-terme-recurrence(g, no: 0, uno: 50, n: 20, precision: 6)$.

#let f = x => 1 + (1 + x * x) / (1 + x)

Avec $display(cases(u_1 = 2, u_(n+1) = 1 + display((1 + u_n^2) / (1 + u_n))))$, on cherche $n$ tel que $u_n > 5$.

#solution-seuil(
  f, 5,
  balayage: true,
  no: 1,
  uno: 2
).
#h(1cm)
#solution-seuil(
  f, 5,
  calculatrice: true,
  precision: 4,
  no: 1,
  uno: 2,
  conclusion: false
).

Avec $display(cases(u_1 = 2, u_(n+1) = 1 + display((1 + u_n^2) / (1 + u_n))))$, on obtient le tableau de valeurs suivant :

#align(center, numworks-suite(f, no: 1, uno: 2))

#solution-seuil(
  f, 10,
  precision: 4,
  no: 1,
  uno: 2,
  simple: true
) (Ainsi $u_n > 10$ à partir de $n = #rang-seuil(f, 10, no: 1, uno: 2)$.)

Autour du seuil, à la calculatrice :

#let N = rang-seuil(f, 10, no: 1, uno: 2)

#align(center, numworks-suite(
  f,
  no: 1,
  uno: 2,
  debut: N - 4,
  surligne: (N - 1, N)
))

Avec une suite fabriquée une fois :

#let u = suite-recurrente(g, no: 0, uno: 50)

$u_1 approx #u(1)$, $u_2 approx #u(2)$, $u_10 approx #u(10, precision: 5)$.

Seuils décroissants : #solution-seuil(x => 0.9 * x, 0.5, no: 0, uno: 8, sens: "<", calculatrice: true, majuscule: false) ;
#solution-seuil(x => x / 2, 1, no: 0, uno: 100, sens: "<=", nom-suite: "v", exact: true, exact-b: true).
