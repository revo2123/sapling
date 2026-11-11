#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// only ∅
#heap(none)
#heap(())

// one circle with 5
#heap(5)

// valid min-heap, nothing red: 1; left 3 (5, 9); right 2 (8)
#heap((1, (3, 5, 9), (2, 8, none)))

// valid max-heap, nothing red: 9; left 8 (1, 3); right 5 (2)
#heap((9, (8, 1, 3), (5, 2, none)), order: "max")

// indices from 0: 1:0, 3:1, 2:2, 5:3, 9:4, 8:5
#heap((1, (3, 5, 9), (2, 8, none)), indices: 0)

// indices from 1: 1:1, 3:2, 2:3, 5:4, 9:5, 8:6
#heap((1, (3, 5, 9), (2, 8, none)), indices: 1)

// not complete, drawn as given, nothing red; indices follow the position: 1:0, 4:2, 6:6
#heap((1, none, (4, none, 6)), indices: 0)

// string keys, nothing red
#heap(("a", ("c", "d", none), "b"))

// 3 and 8 marked blue
#heap((1, (3, 5, 9), (2, 8, none)), marked: (3, 8))

// marked key not in tree: ignored
#heap((1, 2, 3), marked: (99,))
