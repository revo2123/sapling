#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// spec example: 2, 4, 5 and 6 red (each is larger than an ancestor
// it lies left of); 1, 3 and 7 fine
#bst((1, 2, (3, (4, 5, 6), 7)))

// 7 is in the left subtree of 5 but larger: 7 red
#bst((5, (3, none, 7), 8))

// the wrong node 8 is red, its children 1 and 4 fit under the root: not red
#bst((5, (8, 1, 4), 9))

// show-errors: false: nothing red
#bst((5, (3, none, 7), 8), show-errors: false)

// 7 is both marked and an error: red wins
#bst((5, (3, none, 7), 8), marked: (7, 3))

// string keys: "z" left of "m" is red
#bst(("m", "z", "x"))
