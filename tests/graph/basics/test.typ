#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// five vertices on a circle, A on top, clockwise; a pentagon with one diagonal
#graph(("A", "B", "C", "D", "E"), (("A", "B"), ("B", "C"), ("C", "D"), ("D", "E"), ("E", "A"), ("A", "C")))

// integers as vertices; 1 and "1" are the same vertex, so this is a triangle
#graph((1, 2, 3), ((1, 2), ("2", 3), (3, "1")))

// isolated vertices: three circles without edges
#graph(("A", "B", "C"), ())

// single circle
#graph(("A",), ())

// two vertices above each other
#graph(("A", "B"), (("A", "B"),))

// only ∅
#graph((), ())

// wider spacing, bigger vertices and text
#graph(("A", "B", "C"), (("A", "B"), ("B", "C"), ("C", "A")), dx: 3cm, dy: 3cm, r: 0.5cm, font-size: 14pt)

// dx scales only the width: an ellipse, wider than high
#graph(("A", "B", "C", "D", "E"), (("A", "B"), ("B", "C")), dx: 3cm)
