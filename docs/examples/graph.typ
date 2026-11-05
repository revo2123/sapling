#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

#graph(
  ("A", "B", "C", "D", "E"),
  (("A", "B"), ("B", "C"), ("C", "D"), ("D", "E"), ("E", "A"), ("A", "C")),
)
