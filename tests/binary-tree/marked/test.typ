#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// 4 and 14 marked
#binary-tree((8, (4, 2, 6), (12, 10, 14)), marked: (4, 14))

// marked key not in tree: ignored, nothing marked
#binary-tree((8, 4, 12), marked: (99,))

// marked: none and () mark nothing
#binary-tree((8, 4, 12), marked: none)
#binary-tree((8, 4, 12), marked: ())

// string keys, "c" marked
#binary-tree(("m", "c", "x"), marked: ("c",))
