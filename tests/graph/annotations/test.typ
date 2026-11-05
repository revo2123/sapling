#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// annotations sit outside the graph, away from its centre, without touching a vertex
#graph(
  ("A", "B", "C", "D", "E", "F"),
  (("A", "B"), ("B", "C"), ("C", "D"), ("D", "E"), ("E", "F"), ("F", "A"), ("A", "D")),
  extra: (A: "d=120", B: "d=120", C: "d=120", D: "d=120", E: "d=120", F: "d=120"),
)

// any content; not every vertex needs one; integer vertices use quoted keys
#graph((1, 2, 3), ((1, 2), (2, 3)), extra: ("1": $infinity$, "3": "1/6"))

// annotation and weight on a self-loop do not overlap
#graph(("A", "B"), (("A", "A", 5), ("A", "B")), extra: (A: "d=12"), directed: true)

// labels show something else than the id; ids are still used everywhere else
#graph(
  ("a", "b", "c"),
  (("a", "b"), ("b", "c")),
  labels: (a: $v_1$, b: $v_2$, c: "x"),
  marked: ("a",),
  extra: (b: $d_2$),
)

// graph.with fixes the structure, so that each call only gives the state
#let g = graph.with(("A", "B"), (("A", "B"),), directed: true)
#g()
#g(marked: ("A",), marked-edges: (("A", "B"),))
