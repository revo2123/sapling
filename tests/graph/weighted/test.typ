#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// weights interrupt the middle of each edge
#graph(("A", "B", "C", "D"), (("A", "B", 3), ("B", "C", 1), ("C", "D", -7), ("D", "A", 0)))

// any label works: strings and math
#graph(("A", "B", "C"), (("A", "B", "2/5"), ("B", "C", $infinity$), ("C", "A", 1.5)), directed: true)

// the diagonals cross in the middle: pos moves their weights apart
#graph(
  (("A", 0, 0), ("B", 1, 0), ("C", 0, 1), ("D", 1, 1)),
  (edge("A", "D", 5, pos: 0.25), edge("B", "C", 6, pos: 0.25)),
)
