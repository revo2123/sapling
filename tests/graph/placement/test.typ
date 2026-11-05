#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// columns grow to the right, rows grow downward: A top left, D bottom right
#graph(
  (("A", 0, 0), ("B", 1, 0), ("C", 0, 1), ("D", 1, 1)),
  (("A", "B"), ("A", "C"), ("B", "D"), ("C", "D")),
)

// negative and fractional positions: the picture still starts at its top-left corner
#graph(
  (("A", -1, -1.5), ("B", 0.5, 0), ("C", -2, 0.5)),
  (("A", "B"), ("B", "C")),
)

// dx and dy scale the grid: the same square, wide and flat
#graph(
  (("A", 0, 0), ("B", 1, 0), ("C", 0, 1), ("D", 1, 1)),
  (("A", "B"), ("A", "C"), ("B", "D"), ("C", "D")),
  dx: 3cm,
  dy: 1cm,
)

// a border is drawn around each picture: nothing may stick out of it
#let framed(body) = box(stroke: 0.3pt + gray, body)
#framed(graph(
  (("A", 0, 0), ("B", 1, 0)),
  (edge("A", "B", 7, bend: 1.5cm), edge("B", "A", 8, bend: 1.5cm), ("A", "A", 3), ("B", "B")),
  directed: true,
  extra: (A: "wide annotation", B: "x"),
))
#framed(graph(("A", "B", "C"), (("A", "A"), ("B", "B", 1), ("C", "C", 2)), extra: (A: "a", B: "b", C: "c")))
