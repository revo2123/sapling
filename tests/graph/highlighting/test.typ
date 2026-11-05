#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

#let V = (("A", 0, 1), ("B", 1, 0), ("C", 1, 2), ("D", 2, 1))
#let E = (("A", "B", 1), ("A", "C", 2), ("B", "C", 3), ("B", "D", 4), ("C", "D", 5))

// A red, B and C blue, the others plain; A–B red, A–C blue, B–C dashed grey (with grey weight)
#graph(
  V,
  E,
  marked: ("A",),
  visited: ("B", "C"),
  marked-edges: (("A", "B"),),
  visited-edges: (("A", "C"),),
  faded-edges: (("B", "C"),),
)

// undirected: an edge matches in both directions, so A–B and C–D are highlighted
#graph(V, E, marked-edges: (("B", "A"), ("D", "C")))

// directed: only the exact direction matches. Red arrow from A to B, not the one back
#graph(("A", "B"), (("A", "B"), ("B", "A")), directed: true, marked-edges: (("A", "B"),))

// path-edges: the red path A–B–D
#graph(V, E, marked-edges: path-edges("A", "B", "D"))

// a list of edges with weights can be used as well; only A–C
#graph(V, E, visited-edges: (("A", "C", 2),))

// parallel edges: the weight tells them apart. Only the edge with weight 2 is red
#graph(("A", "B"), (("A", "B", 1), ("A", "B", 2)), marked-edges: (("A", "B", 2),))

// marked wins over visited: A has a red border, A–B is red
#graph(("A", "B"), (("A", "B"),), marked: ("A",), visited: ("A",), marked-edges: (("A", "B"),), visited-edges: (("A", "B"),))

// groups: {A, B} orange, {C} green; D stays plain; group fill stays under a red border
#graph(V, E, groups: (("A", "B"), ("C",)), marked: ("A",))

// seven groups: the palette repeats, the seventh has the colour of the first
#graph((1, 2, 3, 4, 5, 6, 7), (), groups: ((1,), (2,), (3,), (4,), (5,), (6,), (7,)))
