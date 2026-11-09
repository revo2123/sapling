#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// only ∅
#binary-tree-from(none)
#binary-tree-from(())

// one circle with 1
#binary-tree-from((1,))

// spec example, level order: 1; left 2 (4); right 3; 3 and 4 marked
#binary-tree-from((1, 2, 3, 4), marked: (3, 4))

// complete tree with 7 nodes: 1; 2 (4, 5); 3 (6, 7)
#binary-tree-from((1, 2, 3, 4, 5, 6, 7))

// duplicates left out: same as (5, 3, 8)
#binary-tree-from((5, 3, 5, 3, 8))

// string keys
#binary-tree-from(("a", "b", "c"))
