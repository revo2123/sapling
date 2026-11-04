// Treaps: binary trees whose nodes show "key,priority" in a pill.

#import "colors.typ": colors
#import "binary.typ": node, normalize, draw-binary

#let _treap-spec(t, marked, parens) = {
  if t == none { return none }
  assert(
    type(t) == array and t.len() >= 2 and t.len() <= 4,
    message: "treap: a node is (key, priority, left, right)",
  )
  let key = t.at(0)
  let prio = t.at(1)
  let pair = [#key#text(fill: colors.priority)[,#prio]]
  node(
    if parens { [(#pair)] } else { pair },
    _treap-spec(t.at(2, default: none), marked, parens),
    _treap-spec(t.at(3, default: none), marked, parens),
    mark: key in marked,
  )
}

/// Draws a treap; node = (key, priority, left, right), displayed as "key,priority".
/// parens: true -> "(key,priority)". `marked` compares against the keys.
#let treap(tree, marked: (), parens: false, pill-width: auto, ..style) = {
  let pw = if pill-width == auto { if parens { 1.45cm } else { 1.15cm } } else { pill-width }
  draw-binary(normalize(_treap-spec(tree, marked, parens)), pill: true, pill-width: pw, ..style)
}
