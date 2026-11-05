#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

#graph(
  (("a", 0, 0), ("b", 1, 0), ("c", 0, 1), ("d", 2, 0), ("e", 3, 0), ("f", 2, 1), ("g", 3, 1)),
  (("a", "b"), ("b", "c"), ("c", "a"), ("b", "d"), ("d", "e"), ("e", "f"), ("f", "d"), ("f", "g")),
  directed: true,
  groups: (("a", "b", "c"), ("d", "e", "f"), ("g",)),
)
