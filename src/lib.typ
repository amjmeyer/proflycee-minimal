// Copyright (c) 2026 Arthur Meyer
// SPDX-License-Identifier: MIT
// Voir le fichier LICENSE à la racine du paquet.

// Point d'entrée du paquet.
//
// proflycee-minimal : portage minimaliste, en Typst, de quelques commandes du
// paquet LaTeX ProfLycee (Cédric Pierquet). Point d'entrée déclaré dans
// typst.toml : seules les fonctions ci-dessous sont exportées.
//
// Organisation de src/ :
//   lib.typ                  ce fichier
//   deps.typ                 dépendances externes (cetz)
//   cercle-trigo.typ         une commande ProfLycee par fichier
//
// Correspondance avec ProfLycee :
//   \CercleTrigo  →  cercle-trigo (canvas autonome)
//                    cercle-trigo-dessin (éléments seuls, dans son propre canvas)

#import "cercle-trigo.typ": cercle-trigo, cercle-trigo-dessin
