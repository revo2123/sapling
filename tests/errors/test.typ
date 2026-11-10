#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// a node is (key, left, right)
#assert-panic(() => binary-tree((1, 2)))
#assert-panic(() => binary-tree((1, 2, 3, 4)))

// keys must be int or string
#assert-panic(() => binary-tree(1.5))
#assert-panic(() => binary-tree(((1,), none, none)))
#assert-panic(() => binary-tree-from((1, 2.5)))

// keys must not be mixed
#assert-panic(() => binary-tree((1, "a", none)))
#assert-panic(() => binary-tree-from((1, "a")))
#assert-panic(() => binary-tree((1, 2, 3), marked: ("a",)))

// keys and marked must be arrays or none
#assert-panic(() => binary-tree-from(5))
#assert-panic(() => binary-tree(5, marked: 5))

// bst, bst-from
#assert-panic(() => bst((1, 2)))
#assert-panic(() => bst((1, "a", none)))
#assert-panic(() => bst-from((1, "a")))
#assert-panic(() => bst-from(5))
#assert-panic(() => bst(5, show-errors: "yes"))

// avl-tree, avl-tree-from
#assert-panic(() => avl-tree((1, 2)))
#assert-panic(() => avl-tree((1, "a", none)))
#assert-panic(() => avl-tree-from((1, "a")))
#assert-panic(() => avl-tree-from(5))
#assert-panic(() => avl-tree(5, show-bf: "yes"))
#assert-panic(() => avl-tree(5, marked: ("a",)))

// rotations
#assert-panic(() => rotate-left((1, 2), 1))
#assert-panic(() => rotate-left((1, 2, 3), "a"))
#assert-panic(() => rotate-right((1, 2, 3), 1.5))
