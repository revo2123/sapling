// Binary trees. Also the shared drawing core for AVL trees, heaps and treaps.
//
// Accepted notations:
//   none                     empty tree
//   5                        leaf (number, string or content such as $x_1$)
//   (5, left, right)         node; left/right may be omitted or none
//   node(5, l, r, extra: "h=2", mark: true)
//                            same, with an annotation and a red highlight
//   Example: binary-tree((8, (4, 2, 6), (12, none, 14)))

#import "colors.typ": colors

/// Binary node with optional annotation (`extra`) and red highlight (`mark`).
/// Children are given positionally: node(label, left, right).
#let node(label, ..children, extra: none, mark: false) = {
  let c = children.pos()
  assert(c.len() <= 2, message: "node: at most two children (left, right)")
  (label: label, l: c.at(0, default: none), r: c.at(1, default: none), extra: extra, mark: mark)
}

// Converts the shorthand notations into dictionaries (label, l, r, extra, mark).
#let normalize(t) = {
  if t == none {
    none
  } else if type(t) == dictionary {
    (
      label: t.label,
      l: normalize(t.at("l", default: none)),
      r: normalize(t.at("r", default: none)),
      extra: t.at("extra", default: none),
      mark: t.at("mark", default: false),
    )
  } else if type(t) == array {
    assert(t.len() >= 1 and t.len() <= 3, message: "binary tree: a node is (label, left, right)")
    (
      label: t.at(0),
      l: normalize(t.at(1, default: none)),
      r: normalize(t.at(2, default: none)),
      extra: none,
      mark: false,
    )
  } else {
    (label: t, l: none, r: none, extra: none, mark: false)
  }
}

// In-order layout: x = position in the in-order sequence, y = depth.
// A parent always lies between its children and nothing overlaps.
#let _layout(t, depth, x0) = {
  if t == none { return (count: 0, nodes: (), edges: (), x: none) }
  let a = _layout(t.l, depth + 1, x0)
  let x = x0 + a.count
  let b = _layout(t.r, depth + 1, x + 1)
  let me = (label: t.label, extra: t.extra, mark: t.mark, x: x, depth: depth)
  let edges = a.edges + b.edges
  if t.l != none { edges.push((x, depth, a.x, depth + 1)) }
  if t.r != none { edges.push((x, depth, b.x, depth + 1)) }
  (count: a.count + 1 + b.count, nodes: a.nodes + (me,) + b.nodes, edges: edges, x: x)
}

#let draw-binary(
  t,
  marked: (),
  pill: false,
  dx: auto,
  dy: 1.0cm,
  r: 0.3cm,
  pill-width: 1.1cm,
  font-size: 9pt,
) = {
  if t == none { return align(center, text(size: font-size)[∅]) }
  // all internal measurements are plain numbers in cm
  let rf = r / 1cm
  let pwf = pill-width / 1cm
  let dyf = dy / 1cm
  let half-w = if pill { pwf / 2 } else { rf }
  let dxf = if dx == auto {
    if pill { half-w + 0.1 } else { half-w + 0.25 }
  } else { dx / 1cm }
  let l = _layout(t, 0, 0)
  let pad-x = 0.45
  let pad-top = 0.4
  let pad-bottom = 0.2
  let max-x = l.nodes.map(n => n.x).fold(0, calc.max)
  let max-depth = l.nodes.map(n => n.depth).fold(0, calc.max)
  let px(x) = (pad-x + half-w + x * dxf) * 1cm
  let py(d) = (pad-top + rf + d * dyf) * 1cm
  align(center, block(
    width: (2 * pad-x + 2 * half-w + max-x * dxf) * 1cm,
    height: (pad-top + pad-bottom + 2 * rf + max-depth * dyf) * 1cm,
    breakable: false,
    {
      for e in l.edges {
        place(top + left, line(
          start: (px(e.at(0)), py(e.at(1))),
          end: (px(e.at(2)), py(e.at(3))),
          stroke: 0.6pt + colors.border,
        ))
      }
      for n in l.nodes {
        let cx = px(n.x)
        let cy = py(n.depth)
        let highlighted = n.mark or (n.label in marked)
        let col = if highlighted { colors.warn } else { colors.border }
        let weight = if highlighted { 1.3pt } else { 0.7pt }
        let body = align(center + horizon, text(size: font-size)[#n.label])
        if pill {
          place(top + left, dx: cx - pill-width / 2, dy: cy - r, rect(
            width: pill-width, height: 2 * r, radius: r, inset: 0pt,
            fill: colors.fill, stroke: weight + col, body,
          ))
        } else {
          place(top + left, dx: cx - r, dy: cy - r, circle(
            radius: r, inset: 0pt,
            fill: colors.fill, stroke: weight + col, body,
          ))
        }
        if n.extra != none {
          // right of the node, vertically centred: incoming and outgoing edges run diagonally
          place(top + left, dx: cx + r + 1.5pt, dy: cy - 5pt,
            text(size: 8pt, weight: "bold", fill: colors.warn)[#n.extra])
        }
      }
    },
  ))
}

/// Draws an arbitrary binary tree.
#let binary-tree(tree, marked: (), ..style) = {
  draw-binary(normalize(tree), marked: marked, ..style)
}

// BST insertion on the tuple notation (duplicates are ignored).
#let _bst-insert(t, v) = {
  if t == none { return (v, none, none) }
  if v < t.at(0) {
    (t.at(0), _bst-insert(t.at(1), v), t.at(2))
  } else if v > t.at(0) {
    (t.at(0), t.at(1), _bst-insert(t.at(2), v))
  } else {
    t
  }
}

/// Builds a BST by inserting the values one after another.
#let bst-from(values) = values.fold(none, _bst-insert)
