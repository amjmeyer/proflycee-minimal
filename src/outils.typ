// Copyright (c) 2026 Arthur Meyer
// SPDX-License-Identifier: MIT
// Voir le fichier LICENSE à la racine du paquet.

// Outils communs (non exportés).

// Écriture française d'un entier : espace fine tous les 3 chiffres à partir
// de 10 000 (2500 reste 2500, 13500 devient 13 500), signe moins typographique.
#let _nombre(n) = {
  let s = str(calc.abs(n))
  if s.len() > 4 {
    let groupes = ()
    while s.len() > 3 {
      groupes.insert(0, s.slice(s.len() - 3))
      s = s.slice(0, s.len() - 3)
    }
    groupes.insert(0, s)
    s = groupes.join(sym.space.thin)
  }
  if n < 0 { $-#s$ } else { $#s$ }
}

// Même chose, entre parenthèses si l'entier est négatif (7 × (–6)).
#let _facteur(n) = if n < 0 { $(#_nombre(n))$ } else { _nombre(n) }
