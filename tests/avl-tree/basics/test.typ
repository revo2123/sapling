#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// only ∅
#avl-tree(none)
#avl-tree(())

// one circle with 5, note 0
#avl-tree(5)

// balanced: all 0
#avl-tree((8, (4, 2, 6), (12, 10, 14)))

// 8: −, 4: −, rest 0; nothing red
#avl-tree((8, (4, 2, none), 12))

// 8: +, 12: +, rest 0
#avl-tree((8, 4, (12, none, 14)))

// chain 1 → 2 → 3: 1 is ++ (red), 2 is +, 3 is 0
#avl-tree((1, none, (2, none, 3)))

// chain 3 ← 2 ← 1: 3 is −− (red), 2 is −, 1 is 0
#avl-tree((3, (2, 1, none), none))

// 1 is +++ (red), 2 is ++ (red), 3 is +, 4 is 0
#avl-tree((1, none, (2, none, (3, none, 4))))

// show-bf: false: no notes, nothing red
#avl-tree((1, none, (2, none, 3)), show-bf: false)

// string keys: "m" −, "c" +, "e" 0, "x" 0
#avl-tree(("m", ("c", none, "e"), "x"))
