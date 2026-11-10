#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// only ∅
#bst-from(none)
#bst-from(())

// one circle with 1
#bst-from((1,))

// spec example: chain 1 → 2 → 3 → 4 going right; 3 and 4 marked
#bst-from((1, 2, 3, 4), marked: (3, 4))

// 8; left 4 (2, 6); right 12 (10, 14)
#bst-from((8, 4, 12, 2, 6, 10, 14))

// duplicates left out: same as (5, 3, 8)
#bst-from((5, 3, 5, 3, 8))

// string keys: "m"; left "c" (right "e"); right "x"
#bst-from(("m", "c", "x", "e"))
