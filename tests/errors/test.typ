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

// treap, treap-from
#assert-panic(() => treap(((1, 2), none)))
#assert-panic(() => treap((1, none, none)))
#assert-panic(() => treap(((1, 2, 3), none, none)))
#assert-panic(() => treap((((1, 2), "a"), none, none)))
#assert-panic(() => treap(((1, "ab"), none, none)))
#assert-panic(() => treap(((1, 2), ((0, "a"), none, none), none)))
#assert-panic(() => treap(((1, 2), ((0, 1), none, none), none), marked: ("a",)))
#assert-panic(() => treap(((1, 2), none, none), order: "foo"))
#assert-panic(() => treap(((1, 2), none, none), show-errors: "yes"))
#assert-panic(() => treap(((1, 2), none, none), parens: 1))
#assert-panic(() => treap-from((1, 2)))
#assert-panic(() => treap-from(((1, 2), ("a", 3))))
#assert-panic(() => treap-from(((1, 2),), order: "max-heap"))
#assert-panic(() => treap-from((1, 2), marked: 1))

// heap, heap-from, up-heap, down-heap
#assert-panic(() => heap((1, 2)))
#assert-panic(() => heap((1, "a", none)))
#assert-panic(() => heap(5, order: "foo"))
#assert-panic(() => heap(5, show-errors: "yes"))
#assert-panic(() => heap(5, indices: 2))
#assert-panic(() => heap(5, indices: true))
#assert-panic(() => heap(5, indices: 1.0))
#assert-panic(() => heap(5, marked: ("a",)))
#assert-panic(() => heap-from((1, "a")))
#assert-panic(() => heap-from(5))
#assert-panic(() => heap-from((1, 2), order: "max-heap"))
#assert-panic(() => up-heap((1, 2, 3), "a"))
#assert-panic(() => up-heap((1, 2, 3), 2, order: "foo"))
#assert-panic(() => down-heap((1, 2), 1))

// b-tree, b-tree-from
#assert-panic(() => b-tree((1, 2), 2))
#assert-panic(() => b-tree((1, 2), "3"))
#assert-panic(() => b-tree-from((1, 2), 1))
#assert-panic(() => b-tree(5, 3))
#assert-panic(() => b-tree(((5,), none, (7,)), 3))
#assert-panic(() => b-tree(((5,), (), (7,)), 3))
#assert-panic(() => b-tree((1, "a"), 3))
#assert-panic(() => b-tree((1, 2.5), 3))
#assert-panic(() => b-tree((1, 2), 3, marked: ("a",)))
#assert-panic(() => b-tree((1, 2), 3, show-errors: "yes"))
#assert-panic(() => b-tree-from(5, 3))
#assert-panic(() => b-tree-from((1, "a"), 3))

// walkthrough, step
#assert-panic(() => walkthrough(columns: 0))
#assert-panic(() => walkthrough(columns: "2"))
#assert-panic(() => walkthrough(arrows: 1))
#assert-panic(() => walkthrough(gutter: 5))
#assert-panic(() => step(5, [x]))

// set-colors: needs content, only named colours, known names, colour values
#assert-panic(() => set-colors(error: red))
#assert-panic(() => set-colors(red)[x])
#assert-panic(() => set-colors(foo: red)[x])
#assert-panic(() => set-colors(error: "red")[x])
