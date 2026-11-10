#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// 4 and 14 marked blue, notes all 0
#avl-tree((8, (4, 2, 6), (12, 10, 14)), marked: (4, 14))

// 1 is marked and ++: red wins; 3 marked blue
#avl-tree((1, none, (2, none, 3)), marked: (1, 3))

// show-bf: false: 1 marked blue
#avl-tree((1, none, (2, none, 3)), marked: (1,), show-bf: false)

// marked key not in tree: ignored
#avl-tree((8, 4, 12), marked: (99,))
