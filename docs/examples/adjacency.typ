#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

#let V = ("A", "B", "C")
#let E = (("A", "B", 3), ("A", "C", 8), ("B", "C", 1))

#adjacency-matrix(V, E, directed: true, empty: $infinity$)
#adjacency-list(V, E, directed: true)
