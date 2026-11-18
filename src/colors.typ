// Colour palette shared by all trees.

#let colors = (
  border: rgb("#1a2b4c"),
  fill: rgb("#f4f7f9"),
  // nodes the user passed in `marked`
  marked: rgb("#1f6fb2"),
  marked-fill: rgb("#d6e8f7"),
  // nodes that break the rules of their tree type (`show-errors`)
  error: rgb("#c0392b"),
  error-fill: rgb("#fdecea"),
  // priorities in treap nodes (same as the key text for now)
  priority: black,
  // array indices next to heap nodes (same as the balance factors for now)
  index: rgb("#1f6fb2"),
)

// Stroke and fill of a node or cell: errors win over marked nodes.
#let style(error: false, marked: false) = {
  if error {
    (1.3pt + colors.error, colors.error-fill)
  } else if marked {
    (1.3pt + colors.marked, colors.marked-fill)
  } else {
    (0.7pt + colors.border, colors.fill)
  }
}
