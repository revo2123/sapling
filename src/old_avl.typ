// AVL trees: binary trees annotated with balance factors.

#import "binary.typ": normalize, draw-binary

// Returns (tree: tree annotated with balance factors, height: height).
#let _annotate-avl(t, convention) = {
  if t == none { return (tree: none, height: 0) }
  let a = _annotate-avl(t.l, convention)
  let b = _annotate-avl(t.r, convention)
  let bal = if convention == "lr" { a.height - b.height } else { b.height - a.height }
  let label = if bal >= 2 { "++" } else if bal == 1 { "+" } else if bal == 0 { "0" } else if bal == -1 { "−" } else { "−−" }
  (
    tree: (label: t.label, l: a.tree, r: b.tree, extra: label, mark: t.mark or calc.abs(bal) > 1),
    height: 1 + calc.max(a.height, b.height),
  )
}

/// Binary tree with balance factors shown as 0, +, ++, −, −− (|bf| >= 2 is red).
/// bf: "rl" -> height(right) - height(left) (default), "lr" -> left - right, none -> no display
#let avl-tree(tree, bf: "rl", marked: (), ..style) = {
  let t = normalize(tree)
  if bf != none { t = _annotate-avl(t, bf).tree }
  draw-binary(t, marked: marked, ..style)
}
