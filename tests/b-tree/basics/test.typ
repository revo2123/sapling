#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// only ∅
#b-tree(none, 3)
#b-tree((), 3)

// one page with 5, 7
#b-tree((5, 7), 3)

// spec example: valid, nothing red; 30 marked blue
#b-tree(((20, 40), (5, 10), (25, 30), (45, 50)), 4, marked: (30,), show-errors: false)
#b-tree(((20, 40), (5, 10), (25, 30), (45, 50)), 4, marked: (30,))

// three levels, valid (order 3)
#b-tree(((30,), ((10,), (5,), (20,)), ((40, 50), (35,), (45,), (60,))), 3)

// string keys
#b-tree((("m",), ("c", "f"), ("t", "z")), 4)

// wide keys: all cells as wide as the widest key
#b-tree(((100,), (5,), (2000, 3000)), 3, marked: (5, 99))
