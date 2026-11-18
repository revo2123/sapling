#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// only ∅
#binary-tree(none)
#binary-tree(())

// one circle with 5
#binary-tree(5)

// 8; left 4 (2, 6); right 12 (10, 14)
#binary-tree((8, (4, 2, 6), (12, 10, 14)))

// 4 has only a left child, 12 only a right child
#binary-tree((8, (4, 2, none), (12, none, 14)))

// spec example: 1; left 2; right 3 (4 (5, 6), 7)
#binary-tree((1, 2, (3, (4, 5, 6), 7)))

// string keys
#binary-tree(("m", ("c", "a", "e"), ("x", none, "z")))

// degenerate chain going right: 1 → 2 → 3 → 4
#binary-tree((1, none, (2, none, (3, none, 4))))
