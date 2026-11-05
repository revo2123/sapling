#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// arrows follow the listed direction: A → B → C → A; the arrow tips touch the circles
#graph(("A", "B", "C"), (("A", "B"), ("B", "C"), ("C", "A")), directed: true)

// a pair of opposite edges curves apart instead of overlapping
#graph(("A", "B"), (("A", "B"), ("B", "A")), directed: true)

// opposite edges with their weights: each weight sits on its own curve
#graph(("A", "B"), (("A", "B", 1), ("B", "A", 2)), directed: true)

// mixed graph: only A → B is an arrow
#graph(("A", "B", "C"), (edge("A", "B", directed: true), ("B", "C"), ("C", "A")))

// mixed graph: only C – A has no arrow
#graph(("A", "B", "C"), (("A", "B"), ("B", "C"), edge("C", "A", directed: false)), directed: true)
