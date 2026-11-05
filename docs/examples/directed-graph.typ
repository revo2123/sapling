#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

#graph(
  ("A", "B", "C", "D"),
  (("A", "B"), ("B", "A"), ("B", "C"), ("C", "D"), ("D", "A"), ("C", "C")),
  directed: true,
)
