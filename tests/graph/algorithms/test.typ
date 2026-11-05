#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// BFS from A: distances, BFS tree in blue, unused edges dashed
#graph(
  ("A", "B", "C", "D", "E", "F"),
  (("A", "B"), ("A", "C"), ("B", "D"), ("C", "D"), ("D", "E"), ("E", "B"), ("C", "F")),
  directed: true,
  visited: ("A", "B", "C", "D", "E", "F"),
  visited-edges: (("A", "B"), ("A", "C"), ("B", "D"), ("D", "E"), ("C", "F")),
  faded-edges: (("C", "D"), ("E", "B")),
  extra: (A: 0, B: 1, C: 1, D: 2, E: 3, F: 2),
)

// Kruskal: minimum spanning tree in blue (total weight 10), rejected edges dashed
#graph(
  (("A", 0, 1), ("B", 1, 0), ("C", 1, 2), ("D", 2, 0), ("E", 3, 1)),
  (("A", "B", 4), ("A", "C", 2), ("B", "C", 1), ("B", "D", 5), ("C", "D", 8), ("C", "E", 10), ("D", "E", 2)),
  visited-edges: (("B", "C"), ("A", "C"), ("D", "E"), ("B", "D")),
  faded-edges: (("A", "B"), ("C", "D"), ("C", "E")),
)

// maximum flow 5, with flow/capacity on each edge; the saturated cut is marked
#graph(
  (("s", 0, 1), ("a", 1, 0), ("b", 1, 2), ("t", 2, 1)),
  (("s", "a", "3/3"), ("s", "b", "2/4"), ("a", "b", "1/2"), ("a", "t", "2/2"), ("b", "t", "3/3")),
  directed: true,
  marked-edges: (("a", "t"), ("b", "t")),
)

// strongly connected components: {a, b, c}, {d, e, f}, {g, h}
#graph(
  (("a", 0, 0), ("b", 1, 0), ("c", 0, 1), ("d", 2, 0), ("e", 3, 0), ("f", 2, 1), ("g", 1, 1.6), ("h", 2, 2)),
  (("a", "b"), ("b", "c"), ("c", "a"), ("b", "d"), ("d", "e"), ("e", "f"), ("f", "d"), ("g", "f"), ("g", "h"), ("h", "g")),
  directed: true,
  groups: (("a", "b", "c"), ("d", "e", "f"), ("g", "h")),
)

// bipartite: two colour classes and a matching in red
#graph(
  (("1", 0, 0), ("2", 0, 1), ("3", 0, 2), ("x", 2, 0), ("y", 2, 1), ("z", 2, 2)),
  (("1", "x"), ("1", "y"), ("2", "y"), ("3", "y"), ("3", "z")),
  groups: (("1", "2", "3"), ("x", "y", "z")),
  marked-edges: (("1", "x"), ("2", "y"), ("3", "z")),
)
