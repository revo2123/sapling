// B-trees.
//
// Accepted notations:
//   (10, 20)                           leaf with the keys 10 and 20
//   ((20, 40), child1, child2, child3) inner node: key array, then n + 1 children
//   Example: b-tree(((20,), (5, 10), (25, 30)), slots: 4)
//
// Only the structure is checked (n keys -> n + 1 children, keys fit into slots);
// the key order and fill levels are NOT validated, so invalid B-trees can be drawn on purpose.

#import "colors.typ": colors

#let _normalize-b(t) = {
  assert(
    type(t) == array,
    message: "b-tree: a node must be an array, e.g. (10, 20) or ((20,), (5, 10), (25, 30))",
  )
  if t.len() > 0 and type(t.at(0)) == array {
    let keys = t.at(0)
    let children = t.slice(1).map(_normalize-b)
    assert(keys.len() > 0, message: "b-tree: inner node without keys")
    assert(
      children.len() == keys.len() + 1,
      message: "b-tree: a node with " + str(keys.len()) + " keys needs "
        + str(keys.len() + 1) + " children, but has " + str(children.len()),
    )
    (keys: keys, children: children)
  } else {
    (keys: t, children: ())
  }
}

// Layout in centimetres (plain numbers). Returns:
//   width: width of the subtree, x: centre of the root, nodes, edges
//   edges: (x-start, level-start, x-end, level-end)
// Child i hangs from the i-th cell boundary of its parent (0 = far left, n = far right).
#let _layout-b(t, depth, cfg) = {
  let n = t.keys.len()
  let cells = if cfg.slots == none { calc.max(n, 1) } else { cfg.slots }
  assert(
    n <= cells,
    message: "b-tree: a node with " + str(n) + " keys does not fit into slots: " + str(cells),
  )
  let node-width = cells * cfg.cell
  if t.children.len() == 0 {
    return (
      width: node-width,
      left: 0.0,
      x: node-width / 2,
      nodes: ((keys: t.keys, cells: cells, x: node-width / 2, depth: depth),),
      edges: (),
    )
  }
  let subs = t.children.map(c => _layout-b(c, depth + 1, cfg))
  // place the subtrees side by side
  let offsets = ()
  let off = 0.0
  for sub in subs {
    offsets.push(off)
    off += sub.width + cfg.gap
  }
  let total = off - cfg.gap
  // the parent is centred above its first and last child
  let mid = (offsets.first() + subs.first().x + offsets.last() + subs.last().x) / 2
  let left = calc.min(0.0, mid - node-width / 2)
  let right = calc.max(total, mid + node-width / 2)
  let shift = -left
  let parent-x = mid + shift
  let parent-left = parent-x - node-width / 2
  let nodes = ()
  let edges = ()
  for (i, sub) in subs.enumerate() {
    let o = offsets.at(i) + shift
    nodes += sub.nodes.map(m => (keys: m.keys, cells: m.cells, x: m.x + o, depth: m.depth))
    edges += sub.edges.map(e => (e.at(0) + o, e.at(1), e.at(2) + o, e.at(3)))
    // the edge ends at the top-left corner of the child ("left") or at its centre ("center")
    let end-x = o + if cfg.anchor == "left" { sub.left } else { sub.x }
    edges.push((parent-left + i * cfg.cell, depth, end-x, depth + 1))
  }
  (
    width: right - left,
    left: parent-left,
    x: parent-x,
    nodes: ((keys: t.keys, cells: cells, x: parent-x, depth: depth),) + nodes,
    edges: edges,
  )
}

/// Draws a B-tree.
/// Leaf: (10, 20). Inner node: ((20, 40), child1, child2, child3) with n + 1 children.
/// slots: none -> node width = number of keys, number -> fixed number of cells per node.
/// anchor: "left" -> edges end at the top-left corner of the child (default),
///         "center" -> edges end at the top centre of the child.
#let b-tree(
  tree,
  slots: none,
  marked: (),
  anchor: "left",
  cell: 0.62cm,
  dy: 1.4cm,
  gap: 0.4cm,
  font-size: 8.5pt,
) = {
  assert(anchor in ("left", "center"), message: "b-tree: anchor must be \"left\" or \"center\"")
  let cf = cell / 1cm
  let dyf = dy / 1cm
  let t = _normalize-b(tree)
  let l = _layout-b(t, 0, (cell: cf, gap: gap / 1cm, slots: slots, anchor: anchor))
  let pad = 0.3
  let max-depth = l.nodes.map(n => n.depth).fold(0, calc.max)
  align(center, block(
    width: (l.width + 2 * pad) * 1cm,
    height: (max-depth * dyf + cf + 2 * pad) * 1cm,
    breakable: false,
    {
      for e in l.edges {
        place(top + left, line(
          start: ((pad + e.at(0)) * 1cm, (pad + e.at(1) * dyf + cf) * 1cm),
          end: ((pad + e.at(2)) * 1cm, (pad + e.at(3) * dyf) * 1cm),
          stroke: 0.6pt + colors.border,
        ))
      }
      for nd in l.nodes {
        let x0 = pad + nd.x - nd.cells * cf / 2
        let y0 = pad + nd.depth * dyf
        for i in range(nd.cells) {
          let filled = i < nd.keys.len()
          let key = if filled { nd.keys.at(i) } else { none }
          let highlighted = filled and (key in marked)
          place(top + left, dx: (x0 + i * cf) * 1cm, dy: y0 * 1cm, rect(
            width: cf * 1cm, height: cf * 1cm, inset: 0pt,
            fill: if highlighted { colors.warn-fill } else { colors.fill },
            stroke: 0.6pt + colors.border,
            align(center + horizon, text(
              size: font-size,
              fill: if highlighted { colors.warn } else { black },
              weight: if highlighted { "bold" } else { "regular" },
            )[#key]),
          ))
        }
      }
    },
  ))
}
