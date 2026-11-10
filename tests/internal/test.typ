// Exact checks for the internal tree helpers (no drawing).
#import "/src/tree.typ": from-level-order, keys, normalize

// normalize: user notation -> long form
#assert.eq(normalize(none), none)
#assert.eq(normalize(()), none)
#assert.eq(normalize(5), (5, none, none))
#assert.eq(normalize((1, 2, none)), (1, (2, none, none), none))
#assert.eq(
  normalize((1, 2, (3, (4, 5, 6), 7))),
  (1, (2, none, none), (3, (4, (5, none, none), (6, none, none)), (7, none, none))),
)

// keys: in-order
#assert.eq(keys(none), ())
#assert.eq(keys(normalize((8, (4, 2, 6), 12))), (2, 4, 6, 8, 12))

// from-level-order: index i has children 2i+1 and 2i+2
#assert.eq(from-level-order(()), none)
#assert.eq(
  from-level-order((1, 2, 3, 4)),
  (1, (2, (4, none, none), none), (3, none, none)),
)

// bst-insert: duplicates are left out
#import "/src/binary.typ": bst-errors, bst-insert
#assert.eq((5, 3, 8, 3, 5).fold(none, bst-insert), (5, (3, none, none), (8, none, none)))
#assert.eq((1, 2, 3).fold(none, bst-insert), (1, none, (2, none, (3, none, none))))

// bst-errors: nodes that break the rule against their valid ancestors
#assert.eq(bst-errors(none), ())
#assert.eq(bst-errors(normalize((8, (4, 2, 6), (12, 10, 14)))), ())
#assert.eq(bst-errors(normalize((1, 2, (3, (4, 5, 6), 7)))), (2, 4, 5, 6))
#assert.eq(bst-errors(normalize((5, (3, none, 7), 8))), (7,))
#assert.eq(bst-errors(normalize((5, (8, 1, 4), 9))), (8,))
#assert.eq(bst-errors(normalize((5, 5, none))), (5,))
#assert.eq(bst-errors(normalize(("m", "z", "x"))), ("z",))
