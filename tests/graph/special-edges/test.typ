#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// self-loops point away from the centre of the graph
#graph(("A", "B", "C"), (("A", "A"), ("B", "B", 5), ("C", "C"), ("A", "B"), ("B", "C")), directed: true)

// the only vertex: the loop points up
#graph(("A",), (("A", "A"),))

// several self-loops fan out; `angle` sets the third one to the bottom
#graph(("A",), (("A", "A"), ("A", "A", 3), edge("A", "A", angle: 90deg)), directed: true)

// three parallel edges: a straight one in the middle and one curve on each side
#graph(("A", "B"), (("A", "B", 1), ("A", "B", 2), ("B", "A", 3)))

// bend: positive to the left of the direction. A → B curves up, C → D curves down
#graph(
  (("A", 0, 0), ("B", 2, 0), ("C", 0, 1), ("D", 2, 1)),
  (edge("A", "B", bend: 0.5cm), edge("C", "D", bend: -0.5cm)),
  directed: true,
)

// bend avoids the vertex B on the straight line from A to C; an explicit 0cm stays straight
#graph(
  (("A", 0, 0), ("B", 1, 0), ("C", 2, 0)),
  (("A", "B"), ("B", "C"), edge("A", "C", bend: 1cm)),
)
#graph(("A", "B"), (edge("A", "B", bend: 0cm), edge("B", "A", bend: 0cm)))
