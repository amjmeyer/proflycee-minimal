// Tests unitaires de src/arithmetique/modulo.typ.
#import "aide.typ": *
#import "/src/arithmetique/modulo.typ": _puissance-mod, modulo, reste-mod, quo-mod

#{
  let lire(c) = int(texte(c).replace("−", "-"))

  // exemples de la doc
  egal(lire(reste-mod(1234, 26)), 12, quoi: "1234 mod 26")
  egal(lire(reste-mod(1234, 26, negatif: true)), -14, quoi: "1234 mod 26 négatif")
  egal(lire(reste-mod(98, 9)), 8, quoi: "98 mod 9")
  egal(lire(reste-mod(98, 9, negatif: true)), -1, quoi: "98 mod 9 négatif")
  egal(lire(reste-mod(7, 8, puissance: 50)), 1, quoi: "7^50 mod 8")
  egal(lire(quo-mod(1234, 26)), 47, quoi: "quo 1234 26")

  // propriétés, sur une grande grille de (a, n), n de signe quelconque
  for a in range(-150, 151) {
    for n in range(-17, 18) {
      if n == 0 { continue }
      let r = lire(reste-mod(a, n))
      let rn = lire(reste-mod(a, n, negatif: true))
      let q = lire(quo-mod(a, n))
      let m = calc.abs(n)
      assert(0 <= r and r < m, message: "reste hors de [0 ; |n|[ : " + str(a) + " mod " + str(n))
      assert(calc.rem(a - r, m) == 0, message: "a ≢ r : " + str(a) + " mod " + str(n))
      assert(-m < rn and rn <= 0, message: "reste négatif hors de ]-|n| ; 0] : " + str(a) + " mod " + str(n))
      assert(calc.rem(a - rn, m) == 0, message: "a ≢ r négatif : " + str(a) + " mod " + str(n))
      assert(rn == r or rn == r - m, message: "restes incohérents : " + str(a) + " mod " + str(n))
      egal(n * q + r, a, quoi: "a = n q + r pour " + str(a) + ", " + str(n))
      egal(lire(modulo(n)(a)), r, quoi: "modulo(n)(a)")
      egal(lire(modulo(n)(a, negatif: true)), rn, quoi: "modulo(n)(a, negatif)")
    }
  }

  // exponentiation modulaire contre le calcul direct (petits nombres)
  for a in range(-12, 13) {
    for e in range(0, 15) {
      for n in (1, 2, 3, 5, 7, 8, 10, 12, 26, -9) {
        if a == 0 and e == 0 { continue } // 0^0 : refusé par calc.pow, voir plus bas
        let direct = calc.rem-euclid(calc.pow(a, e), n)
        egal(_puissance-mod(a, e, n), direct, quoi: str(a) + "^" + str(e) + " mod " + str(n))
        egal(lire(reste-mod(a, n, puissance: e)), direct, quoi: "reste-mod puissance")
      }
    }
  }
  // grands exposants : petit théorème de Fermat, et cycles connus
  for p in (3, 5, 7, 11, 13, 101, 997, 7919) {
    for a in (2, 3, 10, 12345) {
      if calc.rem(a, p) != 0 { egal(_puissance-mod(a, p - 1, p), 1, quoi: "Fermat " + str(a) + " " + str(p)) }
    }
  }
  egal(_puissance-mod(2, 1000000, 1000000007), 235042059, quoi: "2^10^6 mod 10^9+7")
  egal(_puissance-mod(3, 100, 26), 3, quoi: "3^100 mod 26")
  egal(lire(reste-mod(7, 8, puissance: 50, negatif: true)), -7, quoi: "7^50 mod 8 négatif")

  // convention 0^0 = 1 (comme a^0 = 1)
  egal(_puissance-mod(0, 0, 7), 1, quoi: "0^0 mod 7")
  egal(_puissance-mod(0, 0, 1), 0, quoi: "0^0 mod 1")

  // n = ±1 : tout est nul
  egal(lire(reste-mod(12345, 1)), 0, quoi: "mod 1")
  egal(lire(reste-mod(12345, 1, negatif: true)), 0, quoi: "mod 1 négatif")
  // grands entiers : groupement des chiffres
  egal(texte(reste-mod(123456789, 1000000)), "456789", quoi: "groupement")
}

modulo : ok
