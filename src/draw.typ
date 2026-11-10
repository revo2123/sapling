// Drawing of binary-shaped trees (binary trees, BSTs, AVL trees, heaps, treaps).

#import "colors.typ": colors

#let radius = 0.3cm // node radius
#let dx = 0.55cm // horizontal distance between in-order neighbours
#let dy = 1cm // vertical distance between levels
#let pad = 0.1cm // space around the drawing, so strokes are not clipped
#let font-size = 9pt
#let note-width = 0.35cm // room right of the rightmost node for its note

// In-order layout: x = position in the in-order sequence, depth = level.
// A parent always lies between its children and nothing overlaps.
// Returns the number of nodes, the placed nodes (with their subtree), the edges
// and the root's x.
#let layout(tree, depth, x0) = {
  if tree == none { return (count: 0, nodes: (), edges: (), x: none) }
  let (key, left, right) = tree
  let l = layout(left, depth + 1, x0)
  let x = x0 + l.count
  let r = layout(right, depth + 1, x + 1)
  let edges = l.edges + r.edges
  if left != none { edges.push(((x, depth), (l.x, depth + 1))) }
  if right != none { edges.push(((x, depth), (r.x, depth + 1))) }
  (
    count: l.count + 1 + r.count,
    nodes: l.nodes + ((key: key, tree: tree, x: x, depth: depth),) + r.nodes,
    edges: edges,
    x: x,
  )
}

// Draws a binary tree in long form. Keys in `marked` get the marked colour,
// keys in `errors` the error colour (which wins over `marked`).
// `note`, if given, maps a node's subtree to content shown right of the node,
// always in the marked colour.
#let draw(tree, marked: (), errors: (), note: none) = {
  if tree == none { return text(size: font-size)[∅] }

  let l = layout(tree, 0, 0)
  let max-x = calc.max(..l.nodes.map(n => n.x))
  let max-depth = calc.max(..l.nodes.map(n => n.depth))
  let pos((x, depth)) = (pad + radius + x * dx, pad + radius + depth * dy)

  block(
    width: 2 * (pad + radius) + max-x * dx + if note != none { note-width } else { 0pt },
    height: 2 * (pad + radius) + max-depth * dy,
    breakable: false,
    {
      // edges first, so the nodes cover their ends
      for (from, to) in l.edges {
        place(top + left, line(start: pos(from), end: pos(to), stroke: 0.6pt + colors.border))
      }
      for n in l.nodes {
        let (stroke, fill) = if n.key in errors {
          (1.3pt + colors.error, colors.error-fill)
        } else if n.key in marked {
          (1.3pt + colors.marked, colors.marked-fill)
        } else {
          (0.7pt + colors.border, colors.fill)
        }
        let (x, y) = pos((n.x, n.depth))
        place(top + left, dx: x - radius, dy: y - radius, circle(
          radius: radius,
          inset: 0pt,
          fill: fill,
          stroke: stroke,
          align(center + horizon, text(size: font-size)[#n.key]),
        ))
        if note != none {
          // vertically centred: the edges leave the node diagonally
          place(top + left, dx: x + radius + 1.5pt, dy: y - 5pt, text(size: 8pt, fill: colors.marked)[#note(n.tree)])
        }
      }
    },
  )
}
