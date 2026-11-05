#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// node: at most two children
#assert-panic(() => node(1, 2, 3, 4))

// binary tree: a node is (label, left, right)
#assert-panic(() => binary-tree((1, 2, 3, 4)))
#assert-panic(() => binary-tree(()))

// treap: a node is (key, priority, left, right)
#assert-panic(() => treap(5))
#assert-panic(() => treap((1,)))
#assert-panic(() => treap((1, 2, none, none, none)))

// b-tree: a node must be an array
#assert-panic(() => b-tree(5))

// b-tree: inner node without keys
#assert-panic(() => b-tree(((), (1,))))

// b-tree: n keys need n + 1 children
#assert-panic(() => b-tree(((10,), (5,))))

// b-tree: keys must fit into the slots
#assert-panic(() => b-tree((1, 2, 3), slots: 2))

// b-tree: anchor must be "left" or "center"
#assert-panic(() => b-tree((1, 2), anchor: "top"))
