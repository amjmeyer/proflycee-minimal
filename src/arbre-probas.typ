// Copyright (c) 2026 Arthur Meyer
// SPDX-License-Identifier: MIT
// Voir le fichier LICENSE à la racine du paquet.

// Arbres de probabilités « classiques » (homogènes, à deux niveaux), d'après
// \ArbreProbasTikz et l'environnement EnvArbreProbasTikz du paquet LaTeX
// ProfLycee (Cédric Pierquet, §53 de sa documentation).
//
// Deux commandes :
//
//   #arbre-probas(donnees, clés)        -> un canvas CeTZ autonome ;
//   arbre-probas-dessin(donnees, clés)  -> les éléments seuls, à placer dans
//                                          son propre #canvas({ ... }) pour
//                                          compléter la figure (comme
//                                          EnvArbreProbasTikz).
//
// `donnees` : tableau de (sommet, proba) ou (sommet, proba, position), lu de
// gauche à droite puis de haut en bas (chaque nœud du 1er niveau suivi de ses
// enfants), comme les <sommet>/<proba>/<position> de ProfLycee. La proba
// peut valoir `none` (rien d'affiché) ; la position vaut "dessus", "dessous"
// ou "sur" (défaut, sur la branche) ; "above" et "below" sont acceptés.
//
//   #arbre-probas((
//     ($A$, $0,5$),
//       ($B$, $0,4$),
//       ($overline(B)$, $...$),
//     ($overline(A)$, $...$),
//       ($B$, $...$),
//       ($overline(B)$, $1/3$),
//   ))
//
// Nœuds CeTZ créés (pour compléter la figure) : "R" (racine), "A11", "A12", …
// (1er niveau, de haut en bas), "A21", "A22", … (2e niveau).
//
// Clés (entre parenthèses : équivalent ProfLycee, puis défaut) :
//
//   unite            (Unite)           unité du canvas (arbre-probas seul) . 1cm
//   espace-niveau    (EspaceNiveau)    écart horizontal entre niveaux ..... 3.25
//   espace-feuille   (EspaceFeuille)   écart vertical entre feuilles ...... 1
//   type             (Type)            "2x2", "2x3", "3x2" ou "3x3" ....... "2x2"
//   police           (Police)          fonction appliquée aux nœuds ....... x => x
//   police-probas    (PoliceProbas)    fonction appliquée aux probas ...... text.with(size: 0.9em)
//   incline-probas   (InclineProbas)   probas inclinées selon la branche .. true
//   racine           (Racine)          étiquette de la racine ............. none
//   fleche           (Fleche)          flèche au bout des branches ........ false
//   style-trait      (StyleTrait)      pointillés (dash Typst : "dashed",
//                                      "densely-dashed", "dotted"…) ....... none
//   epaisseur-trait  (EpaisseurTrait)  épaisseur des branches ............. 0.6pt
//   position-probas  (PositionProbas)  position de toutes les probas :
//                                      "auto", "dessus", "dessous", "sur"
//                                      (none : celle de chaque donnée) .... none
//   couleur-traits   (CouleurTraits)   couleur des branches ............... black
//   couleur-noeuds   (CouleurNoeuds)   couleur des nœuds .................. black
//   couleur-probas   (CouleurProbas)   couleur des probas ................. black
//
// Le type peut être n'importe quel « pxq » (p branches puis q branches) :
// ProfLycee se limite à 2 ou 3.
#import "deps.typ": cetz

#let arbre-probas-dessin(
  donnees,
  espace-niveau: 3.25,
  espace-feuille: 1,
  type: "2x2",
  police: x => x,
  police-probas: text.with(size: 0.9em),
  incline-probas: true,
  racine: none,
  fleche: false,
  style-trait: none,
  epaisseur-trait: 0.6pt,
  position-probas: none,
  couleur-traits: black,
  couleur-noeuds: black,
  couleur-probas: black,
) = {
  import cetz.draw: *

  let (p, q) = type.split("x").map(int)
  assert(
    donnees.len() == p + p * q,
    message: "arbre-probas : " + str(p + p * q) + " données attendues pour le type " + type,
  )
  let trait = (paint: couleur-traits, thickness: epaisseur-trait, dash: style-trait)
  let noeud(x) = text(fill: couleur-noeuds, police(x))

  // Feuilles régulièrement espacées, centrées sur la racine ; chaque nœud du
  // 1er niveau à mi-hauteur de ses enfants.
  let y-feuille(j) = ((p * q - 1) / 2 - j) * espace-feuille
  let y-noeud(i) = (y-feuille(i * q) + y-feuille(i * q + q - 1)) / 2

  // Branche du nœud `depart` au nœud `arrivee`, entre les points (x0, y0) et
  // (x1, y1) (centres des nœuds), avec sa proba.
  let branche(depart, arrivee, (x0, y0), (x1, y1), proba, position) = {
    line(
      depart + ".east",
      arrivee + ".west",
      stroke: trait,
      mark: if fleche { (end: "stealth", fill: couleur-traits) },
    )
    if proba == none { return }
    let position = if position-probas == "auto" {
      if y1 >= y0 { "dessus" } else { "dessous" }
    } else if position-probas != none { position-probas } else if position == none { "sur" } else {
      (above: "dessus", below: "dessous").at(position, default: position)
    }
    let angle = if incline-probas { calc.atan2(x1 - x0, y1 - y0) } else { 0deg }
    let texte = text(fill: couleur-probas, police-probas(proba))
    let milieu = ((x0 + x1) / 2, (y0 + y1) / 2)
    if position == "dessus" {
      content(milieu, texte, angle: angle, anchor: "south", padding: 0.08)
    } else if position == "dessous" {
      content(milieu, texte, angle: angle, anchor: "north", padding: 0.08)
    } else {
      // sur la branche : fond blanc pour masquer le trait
      content(milieu, texte, angle: angle, padding: 0.05, frame: "rect", fill: white, stroke: none)
    }
  }

  let x1 = espace-niveau
  let x2 = 2 * espace-niveau
  content((0, 0), noeud(if racine == none { [] } else { racine }), name: "R", padding: 0.1)
  for i in range(p) {
    let (sommet, proba, ..reste) = donnees.at(i * (q + 1))
    let nom = "A1" + str(i + 1)
    content((x1, y-noeud(i)), noeud(sommet), name: nom, padding: 0.1)
    branche("R", nom, (0, 0), (x1, y-noeud(i)), proba, reste.at(0, default: none))
    for j in range(q) {
      let (feuille, proba, ..reste) = donnees.at(i * (q + 1) + 1 + j)
      let nom-feuille = "A2" + str(i * q + j + 1)
      content((x2, y-feuille(i * q + j)), noeud(feuille), name: nom-feuille, padding: 0.1)
      branche(nom, nom-feuille, (x1, y-noeud(i)), (x2, y-feuille(i * q + j)), proba, reste.at(0, default: none))
    }
  }
}

#let arbre-probas(donnees, unite: 1cm, ..cles) = cetz.canvas(length: unite, arbre-probas-dessin(donnees, ..cles))
