// Heaps: an array drawn as a binary tree in level order.

#import "binary.typ": node, normalize, draw-binary

#let _heap-spec(a, i, first-index) = {
  if i >= a.len() { return none }
  node(
    a.at(i),
    _heap-spec(a, 2 * i + 1, first-index),
    _heap-spec(a, 2 * i + 2, first-index),
    extra: if first-index != none { str(i + first-index) } else { none },
  )
}

/// Draws an array as a heap (level order).
/// indices: none -> no display, 0 or 1 -> show the array index (starting at 0 or 1) at each node
#let heap(values, indices: none, marked: (), ..style) = {
  draw-binary(normalize(_heap-spec(values, 0, indices)), marked: marked, ..style)
}
