#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// only ∅
#binary-tree(none)

// one circle with 5
#binary-tree(5)

// 8; left 4 (2, 6); right 12 (10, 14)
#binary-tree((8, (4, 2, 6), (12, 10, 14)))

// 4 has only a left child, 12 only a right child
#binary-tree((8, (4, 2), (12, none, 14)))

// only ∅
#binary-tree(bst-from(()))

// 5 (3, 8); duplicates ignored
#binary-tree(bst-from((5, 3, 5, 3, 8)))
