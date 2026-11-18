#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// default colors: 4 blue, 7 red (it is right of 3 but left of 5)
#bst((5, (3, none, (4, none, 7)), 9), marked: (4,))

// content block: marked green, errors orange, borders and edges dark red
#set-colors(
  marked: rgb("#2e7d32"),
  marked-fill: rgb("#c8e6c9"),
  error: rgb("#ef6c00"),
  error-fill: rgb("#ffe0b2"),
  border: rgb("#6d1b1b"),
)[
  #bst((5, (3, none, (4, none, 7)), 9), marked: (4,))

  // nested: only the priority and index change, the colors above stay
  #set-colors(priority: rgb("#7b1fa2"), index: rgb("#2e7d32"))[
    #treap(((5, 1), ((3, 2), none, none), none), marked: (3,))
    #heap-from((3, 1, 2), indices: 0)
  ]
]

// after the blocks: default colors again
#bst((5, (3, none, (4, none, 7)), 9), marked: (4,))

// show rule: everything after it in this scope
#show: set-colors.with(marked: rgb("#7b1fa2"), marked-fill: rgb("#e1bee7"))
#treap(((5, 1), ((3, 2), none, none), none), marked: (3,))
#heap-from((3, 1, 2), indices: 0)
#avl-tree((1, none, (2, none, 3)), marked: (3,))
#b-tree(((20, 40), (5, 10), (25, 30, 35), (45,)), 4, marked: (30,))
