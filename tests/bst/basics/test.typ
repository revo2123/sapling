#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// only ∅
#bst(none)
#bst(())

// one circle with 5
#bst(5)

// valid BST, nothing red: 8; left 4 (2, 6); right 12 (10, 14)
#bst((8, (4, 2, 6), (12, 10, 14)))

// valid BST with string keys, nothing red
#bst(("m", ("c", "a", "e"), ("x", none, "z")))

// 4 and 14 marked blue
#bst((8, (4, 2, 6), (12, 10, 14)), marked: (4, 14))

// marked key not in tree: ignored
#bst((8, 4, 12), marked: (99,))
