// Exact checks for the rotations (no drawing).
#import "/src/lib.typ": *

// spec examples
#assert.eq(rotate-left((1, none, (2, none, 3)), 1), (2, (1, none, none), (3, none, none)))
#assert.eq(rotate-right((2, 1, none), 2), (1, none, (2, none, none)))
#assert.eq(rotate-left-right((3, (1, none, 2), none), 3), (2, (1, none, none), (3, none, none)))
#assert.eq(rotate-right-left((1, none, (3, 2, none)), 1), (2, (1, none, none), (3, none, none)))

// subtrees A, B, C move as in the diagram
#assert.eq(
  rotate-left(("x", "a", ("y", "b", "c")), "x"),
  ("y", ("x", ("a", none, none), ("b", none, none)), ("c", none, none)),
)
#assert.eq(
  rotate-right(("x", ("y", "a", "b"), "c"), "x"),
  ("y", ("a", none, none), ("x", ("b", none, none), ("c", none, none))),
)

// rotation deeper in the tree, the rest stays
#assert.eq(
  rotate-right((5, (3, 2, none), 8), 3),
  (5, (2, none, (3, none, none)), (8, none, none)),
)

// key not in tree: unchanged (in long form)
#assert.eq(rotate-left((1, none, 2), 9), (1, none, (2, none, none)))
#assert.eq(rotate-left(none, 1), none)

// required child missing: unchanged
#assert.eq(rotate-left((1, 2, none), 1), (1, (2, none, none), none))
#assert.eq(rotate-right((1, none, 2), 1), (1, none, (2, none, none)))
#assert.eq(rotate-left-right((3, (1, 0, none), none), 3), (3, (1, (0, none, none), none), none))
#assert.eq(rotate-left-right((3, none, 4), 3), (3, none, (4, none, none)))
#assert.eq(rotate-right-left((1, none, (3, none, 4)), 1), (1, none, (3, none, (4, none, none))))
#assert.eq(rotate-right-left((1, 0, none), 1), (1, (0, none, none), none))

// treaps: the node is found by its key, the priority moves with it
#assert.eq(
  rotate-left(((1, 5), none, ((2, 3), none, none)), 1),
  ((2, 3), ((1, 5), none, none), none),
)
#assert.eq(
  rotate-right-left(((1, 5), none, ((3, 4), ((2, 1), none, none), none)), 1),
  ((2, 1), ((1, 5), none, none), ((3, 4), none, none)),
)
