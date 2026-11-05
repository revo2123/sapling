#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

#graph(
  (("A", 0, 1), ("B", 1, 0), ("C", 1, 2), ("D", 2, 1)),
  (("A", "B", 1), ("A", "C", 2), ("B", "C", 3), ("B", "D", 4), ("C", "D", 5)),
  marked: ("D",),
  visited: ("A", "B"),
  marked-edges: (("B", "D"),),
  visited-edges: (("A", "B"),),
  faded-edges: (("B", "C"),),
  extra: (A: "start", D: $d = 5$),
  labels: (D: $t$),
)
