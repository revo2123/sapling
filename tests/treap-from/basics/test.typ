#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// only ∅
#treap-from(none)
#treap-from(())

// spec example: 7,1 at the root, left 5,3, its left 2,8; 7 marked blue
#treap-from(((5, 3), (2, 8), (7, 1)), marked: (7,))

// same keys as max-treap: 2,8 at the root, right 5,3, its right 7,1
#treap-from(((5, 3), (2, 8), (7, 1)), order: "max")

// duplicate key 5 is left out (5 keeps priority 3): same as the spec example
#treap-from(((5, 3), (2, 8), (5, 0), (7, 1)))

// rotations below the root: 4,1; left 2,3 (1,5; 3,4); right 6,2 (5,7; 7,6)
#treap-from(((1, 5), (2, 3), (3, 4), (4, 1), (5, 7), (6, 2), (7, 6)))

// characters as priorities, parens
#treap-from((("d", "b"), ("b", "a"), ("f", "c")), parens: true)
