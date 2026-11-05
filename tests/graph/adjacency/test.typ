#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

#let V = ("A", "B", "C")

// symmetric, 0 for missing edges
#adjacency-matrix(V, (("A", "B"), ("B", "C")))

// directed: not symmetric
#adjacency-matrix(V, (("A", "B"), ("B", "C")), directed: true)

// weights, and ∞ for missing edges
#adjacency-matrix(V, (("A", "B", 3), ("B", "C", 1)), empty: $infinity$, directed: true)

// a self-loop on A and mixed edges: A→B only one way, B–C both ways
#adjacency-matrix(V, (("A", "A"), edge("A", "B", directed: true), ("B", "C")))

// parallel edges: both weights in one cell
#adjacency-matrix(("A", "B"), (("A", "B", 1), ("A", "B", 2)))

// labels replace the headers; positions are ignored
#adjacency-matrix((("a", 0, 0), ("b", 1, 0)), (("a", "b"),), labels: (a: $v_1$, b: $v_2$))

// undirected: B has both neighbours, in the order of the edges
#adjacency-list(V, (("A", "B"), ("B", "C")))

// directed: C has no neighbours
#adjacency-list(V, (("A", "B"), ("A", "C"), ("B", "C")), directed: true)

// weights after the neighbour, a self-loop lists the vertex itself once
#adjacency-list(V, (("A", "B", 3), ("A", "C", 8), ("C", "C", 2)), directed: true)

// labels
#adjacency-list((("a", 0, 0), ("b", 1, 0)), (("a", "b"),), labels: (a: $v_1$, b: $v_2$))
