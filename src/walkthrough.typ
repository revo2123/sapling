// Show how a tree or graph changes, step by step, e.g. to go through an entire solution.
//
//   walkthrough(
//     snapshot("1) insert 7", b-tree((3, 5, 7), slots: 4)),
//     snapshot("2) insert 9", b-tree((3, 5, 7, 9), slots: 4)),
//   )

#import "colors.typ": colors

/// One state of a tree or graph: a labelled picture (title above the content).
#let snapshot(title, content) = block(breakable: false, {
  align(center, text(size: 9pt, fill: colors.snapshot, title))
  content
})

/// Several snapshots side by side.
/// columns: auto -> all in one row, number -> continue in a new row after that many snapshots
#let walkthrough(..items, columns: auto) = align(center, grid(
  columns: (auto,) * if columns == auto { items.pos().len() } else { columns },
  column-gutter: 8pt,
  row-gutter: 6pt,
  ..items.pos(),
))
