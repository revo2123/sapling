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

// height
#import "/src/tree.typ": height
#assert.eq(height(none), -1)
#assert.eq(height(normalize(5)), 0)
#assert.eq(height(normalize((1, none, (2, none, 3)))), 2)
#assert.eq(height(normalize((8, (4, 2, 6), 12))), 2)

// avl: balance factors, unbalanced nodes, insertion
#import "/src/avl.typ": avl-insert, balance, symbol, unbalanced
#assert.eq(balance(normalize((1, none, (2, none, 3)))), 2)
#assert.eq(balance(normalize((8, (4, 2, none), 12))), -1)
#assert.eq((symbol(-2), symbol(-1), symbol(0), symbol(1), symbol(2)), ("−−", "−", "0", "+", "++"))
#assert.eq(unbalanced(normalize((8, (4, 2, 6), 12))), ())
#assert.eq(unbalanced(normalize((1, none, (2, none, (3, none, 4))))), (1, 2))
#assert.eq(range(1, 8).fold(none, avl-insert), normalize((4, (2, 1, 3), (6, 5, 7))))
#assert.eq((3, 1, 2).fold(none, avl-insert), normalize((2, 1, 3)))
#assert.eq((1, 3, 2).fold(none, avl-insert), normalize((2, 1, 3)))
#assert.eq((5, 3, 5, 3, 8).fold(none, avl-insert), normalize((5, 3, 8)))
// insertion that rotates below the root: 10; 5 (2, 7); 20 → insert 1, 0
#assert.eq((10, 5, 20, 2, 7, 1, 0).fold(none, avl-insert), normalize((5, (1, 0, 2), (10, 7, 20))))

// treap: insertion with rotations, priority errors
#import "/src/treap.typ": treap-insert
#let insert-all(pairs, order) = pairs.fold(none, (t, p) => treap-insert(t, p, order))
#assert.eq(
  insert-all(((5, 3), (2, 8), (7, 1)), "min"),
  normalize(((7, 1), ((5, 3), ((2, 8), none, none), none), none)),
)
#assert.eq(
  insert-all(((5, 3), (2, 8), (7, 1)), "max"),
  normalize(((2, 8), none, ((5, 3), none, ((7, 1), none, none)))),
)
#assert.eq(insert-all(((5, 3), (5, 0)), "min"), normalize(((5, 3), none, none)))
#import "/src/tree.typ": order-errors
#let by-prio = pair => pair.at(1)
#assert.eq(order-errors(normalize(((5, 3), ((2, 1), none, none), none)), "min", by: by-prio), (2,))
#assert.eq(order-errors(normalize(((5, 3), ((2, 1), none, none), none)), "max", by: by-prio), ())
#assert.eq(bst-errors(normalize(((5, 1), ((7, 2), none, none), none))), (7,))

// level order: positions, completeness
#import "/src/tree.typ": positions, to-level-order
#assert.eq(positions(normalize((1, 2, (3, none, 4)))), ((0, 1), (1, 2), (2, 3), (6, 4)))
#assert.eq(to-level-order(none), ())
#assert.eq(to-level-order(normalize((1, (2, 4, 5), 3))), (1, 2, 3, 4, 5))
#assert.eq(to-level-order(normalize((1, (2, none, 5), 3))), none)
#assert.eq(to-level-order(normalize((1, 2, (3, 6, none)))), none)
#assert.eq(to-level-order(from-level-order(range(10))), range(10))

// heap order: each node against its parent
#assert.eq(order-errors(normalize((1, (3, 5, 9), (2, 8, none))), "min"), ())
#assert.eq(order-errors(normalize((5, (3, 4, 9), 8)), "min"), (3,))
#assert.eq(order-errors(normalize((5, (3, 4, 9), 8)), "max"), (4, 9, 8))
#assert.eq(order-errors(normalize((2, 2, 3)), "min"), ())
