#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// only ∅
#heap-from(none)
#heap-from(())

// spec example: 1; left 2 (4); right 3; 3 and 4 marked blue
#heap-from((1, 2, 3, 4), marked: (3, 4))

// min-heap: 1; left 3 (5, 9); right 2 (8)
#heap-from((5, 3, 8, 1, 9, 2))

// max-heap: 9; left 8 (1, 3); right 5 (2)
#heap-from((5, 3, 8, 1, 9, 2), order: "max")

// duplicates are left out: same as the min-heap above
#heap-from((5, 3, 8, 3, 1, 9, 5, 2))

// with indices from 1
#heap-from((5, 3, 8, 1, 9, 2), indices: 1)

// string keys: "a"; left "b" ("d"); right "c"
#heap-from(("d", "c", "b", "a"))
