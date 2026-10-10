// Outils des tests unitaires : conversion d'un contenu en texte brut, pour
// comparer les sorties des commandes à une chaîne attendue.
//
//   texte($2^3 times 5$)  →  "2^3×5"
//
// Conventions : espaces supprimés (y compris fines et h()), exposant noté
// ^, indice _, fraction (a)/(b), cancel ~a~, boîtes et couleurs transparentes,
// cellules de grille séparées par « | ».

#let texte(c) = {
  if c == none { return "" }
  if type(c) == str { return c.replace(" ", "").replace(sym.space.thin, "") }
  if type(c) in (int, float) { return str(c) }
  if type(c) == symbol { return str(c) }
  if type(c) == array { return c.map(texte).join("") }
  if type(c) != content { return repr(c) }
  let f = c.func()
  let champs = c.fields()
  if f == text { texte(c.text) }
  else if f == [ ].func() or f == h or f == linebreak or f == parbreak { "" }
  else if "children" in champs and f != grid { c.children.map(texte).join("") }
  else if f == math.equation { texte(c.body) }
  else if f == math.attach {
    texte(c.base) + (if "b" in champs { "_" + texte(c.b) } else { "" }) + (if "t" in champs { "^" + texte(c.t) } else { "" })
  }
  else if f == math.frac { "(" + texte(c.num) + ")/(" + texte(c.denom) + ")" }
  else if f == math.cancel { "~" + texte(c.body) + "~" }
  else if f == math.lr { texte(c.body) }
  else if f == grid { c.children.map(x => texte(x.body)).join("|") }
  else if "body" in champs { texte(c.body) }
  else if "child" in champs { texte(c.child) }
  else if "text" in champs { texte(c.text) }
  else { "" }
}

// Égalité avec message lisible.
#let egal(obtenu, attendu, quoi: "") = assert(
  obtenu == attendu,
  message: quoi + " : obtenu " + repr(obtenu) + ", attendu " + repr(attendu),
)

// Égalité de flottants à `tol` près (relative au-dessus de 1).
#let proche(obtenu, attendu, tol: 1e-12, quoi: "") = assert(
  calc.abs(obtenu - attendu) <= tol * calc.max(1, calc.abs(attendu)),
  message: quoi + " : obtenu " + repr(obtenu) + ", attendu " + repr(attendu),
)

// Couleurs de texte réellement employées par un contenu (les styles
// n'apparaissent pas dans repr) : on place le contenu avec releve(clé, c),
// puis, dans un context, couleurs(clé) donne les couleurs autres que noir.
#let releve(cle, c) = {
  show text: it => context {
    let f = text.fill
    state(cle, ()).update(l => l + (f,))
    it
  }
  c
}
#let couleurs(cle) = state(cle, ()).final().dedup().filter(f => f != black)
