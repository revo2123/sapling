#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// order 3: the root (10, 20, 30) has too many keys: red; leaves are fine
#b-tree(((10, 20, 30), (5,), (15,), (25,), (40,)), 3)

// root with 2 keys but 2 children: red root
#b-tree(((20, 40), (5, 10), (25, 30)), 4)

// leaf (10, 5) not ascending: red; (3, 9) is too big for the left of 8: red
#b-tree(((8,), (10, 5), (3, 9)), 4)

// leaves on different levels: the shallow leaf (7) is red
#b-tree(((5,), ((2,), (1,), (3,)), (7,)), 3)

// order 5: a non-root page needs at least 2 keys: leaf (1) red
#b-tree(((5,), (1,), (7, 8)), 5)

// inner page without children: red
#b-tree(((5,),), 3)

// show-errors: false: nothing red
#b-tree(((10, 20, 30), (5,), (15,), (25,), (40,)), 3, show-errors: false)

// 20 is marked and in a red page: red wins; 5 marked blue
#b-tree(((20, 40), (5, 10), (25, 30)), 4, marked: (20, 5))
