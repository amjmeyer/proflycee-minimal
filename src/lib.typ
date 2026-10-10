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
//   pgcd.typ
//   probas.typ
//   arbre-probas.typ
//   loi-graphe.typ
//   modulo.typ
//   conversion-bases.typ
//   division-eucl.typ
//   outils.typ               outils communs (non exportés)
//
// Correspondance avec ProfLycee :
//   \CercleTrigo  →  cercle-trigo (canvas autonome)
//                    cercle-trigo-dessin (éléments seuls, dans son propre canvas)
//   \PresentationPGCD  →  presentation-pgcd
//   (pas d'équivalent) →  remontee-euclide (remontée de l'algorithme, Bézout)
//   \CalcBinomP, \CalcBinomC, …, \CalcNormC, \CalcExpoC
//                      →  calc-binom-p, calc-binom-c, …, calc-norm-c, calc-expo-c
//   \BinomP, \BinomC, …, \NormaleC, \ExpoC
//                      →  binom-p, binom-c, …, normale-c, expo-c
//   (pas d'équivalent) →  loi-binomiale, loi-poisson, loi-geometrique,
//                         loi-hypergeometrique, loi-normale, loi-exponentielle
//                         (une loi = une fonction : X(k), X(a, b))
//   \ArbreProbasTikz   →  arbre-probas
//   EnvArbreProbasTikz →  arbre-probas-dessin
//   \LoiNormaleGraphe  →  loi-normale-graphe (+ loi-normale-graphe-dessin)
//   \LoiExpoGraphe     →  loi-expo-graphe (+ loi-expo-graphe-dessin)
//   \ResteMod, \QuoMod →  reste-mod, quo-mod
//   (pas d'équivalent) →  modulo(n) (la fonction a => reste-mod(a, n))
//   \ConversionEntreBases → conversion-entre-bases
//   (pas d'équivalent) →  conversion(sens) (la fonction nb => …)
//   \DivisionEucl      →  division-eucl
//   \DivEucl           →  div-eucl

#import "cercle-trigo.typ": cercle-trigo, cercle-trigo-dessin
#import "pgcd.typ": presentation-pgcd, remontee-euclide
#import "probas.typ": (
  loi-binomiale, loi-poisson, loi-geometrique, loi-hypergeometrique, loi-normale, loi-exponentielle,
  calc-binom-p, calc-binom-c, calc-poiss-p, calc-poiss-c, calc-geom-p, calc-geom-c,
  calc-hypergeom-p, calc-hypergeom-c, calc-norm-c, calc-expo-c,
  binom-p, binom-c, poisson-p, poisson-c, geom-p, geom-c, hypergeom-p, hypergeom-c, normale-c, expo-c,
)
#import "arbre-probas.typ": arbre-probas, arbre-probas-dessin
#import "loi-graphe.typ": loi-normale-graphe, loi-normale-graphe-dessin, loi-expo-graphe, loi-expo-graphe-dessin
#import "modulo.typ": reste-mod, quo-mod, modulo
#import "conversion-bases.typ": conversion-entre-bases, conversion
#import "division-eucl.typ": division-eucl, div-eucl
