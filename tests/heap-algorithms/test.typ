// Exact checks for up-heap and down-heap (no drawing).
#import "/src/lib.typ": *

// spec examples
#assert.eq(up-heap((4, (2, 6, 5), 7), 2), (2, (4, (6, none, none), (5, none, none)), (7, none, none)))
#assert.eq(
  down-heap((8, (3, 6, 5), (2, 9, none)), 8),
  (2, (3, (6, none, none), (5, none, none)), (8, (9, none, none), none)),
)

// up-heap moves over several levels, and stops when the parent is fine
#assert.eq(up-heap((2, (4, 1, 5), 3), 1), (1, (2, (4, none, none), (5, none, none)), (3, none, none)))
#assert.eq(up-heap((1, (4, 2, 5), 3), 2), (1, (2, (4, none, none), (5, none, none)), (3, none, none)))

// max-heaps
#assert.eq(up-heap((5, (3, 9, none), 4), 9, order: "max"), (9, (5, (3, none, none), none), (4, none, none)))
#assert.eq(
  down-heap((1, (8, 6, 7), 5), 1, order: "max"),
  (8, (7, (6, none, none), (1, none, none)), (5, none, none)),
)

// down-heap picks the better child; with only one child it compares against that one
#assert.eq(down-heap((9, 3, 2), 9), (2, (3, none, none), (9, none, none)))
#assert.eq(down-heap((9, 3, none), 9), (3, (9, none, none), none))

// string keys
#assert.eq(up-heap(("b", "c", "a"), "a"), ("a", ("c", none, none), ("b", none, none)))

// unchanged (in long form): key not in tree, key is the root, parent already fine,
// key is a leaf, tree not complete, empty tree
#assert.eq(up-heap((1, 2, 3), 9), (1, (2, none, none), (3, none, none)))
#assert.eq(up-heap((1, 2, 3), 1), (1, (2, none, none), (3, none, none)))
#assert.eq(up-heap((1, 2, 3), 3), (1, (2, none, none), (3, none, none)))
#assert.eq(down-heap((1, 2, 3), 2), (1, (2, none, none), (3, none, none)))
#assert.eq(down-heap((9, none, 3), 9), (9, none, (3, none, none)))
#assert.eq(up-heap((9, none, 3), 3), (9, none, (3, none, none)))
#assert.eq(up-heap(none, 1), none)
