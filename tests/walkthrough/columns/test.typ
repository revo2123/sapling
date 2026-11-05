#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

#let g = graph.with(("A", "B", "C"), (("A", "B"), ("B", "C")))

// two rows: A and B above, C below on the left
#walkthrough(
  columns: 2,
  snapshot("A", g(marked: ("A",))),
  snapshot("B", g(marked: ("B",))),
  snapshot("C", g(marked: ("C",))),
)

// without columns: all in one row
#walkthrough(
  snapshot("A", g(marked: ("A",))),
  snapshot("B", g(marked: ("B",))),
  snapshot("C", g(marked: ("C",))),
)

// trees and graphs together
#walkthrough(
  snapshot("tree", binary-tree((2, 1, 3))),
  snapshot("graph", g()),
)
