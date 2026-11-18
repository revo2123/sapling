#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// only ∅
#b-tree-from((), 3)
#b-tree-from(none, 3)

// spec example: (2) over (1) and (3, 4)
#b-tree-from((1, 2, 3, 4), 3)

// order 4, 10 keys, 2 marked
#b-tree-from(range(1, 11), 4, marked: (3, 8))

// order 5, descending, duplicates left out
#b-tree-from((9, 8, 7, 6, 5, 4, 3, 2, 1, 5, 9), 5)

// string keys
#b-tree-from(("d", "a", "c", "b", "e"), 3)

// marked key not in keys: ignored
#b-tree-from((1, 2), 3, marked: (99,))
