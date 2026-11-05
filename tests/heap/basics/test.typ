#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// level order 1 / 3 2 / 7 4 5 6 / 9 8; indices 0–8 at the nodes
#heap((1, 3, 2, 7, 4, 5, 6, 9, 8), indices: 0)

// same heap, indices 1–9
#heap((1, 3, 2, 7, 4, 5, 6, 9, 8), indices: 1)

// single circle
#heap((42,))

// only ∅
#heap(())

// root with a single left child
#heap((2, 9))

// 5 in red
#heap((1, 3, 2, 7, 4, 5, 6), marked: (5,))
