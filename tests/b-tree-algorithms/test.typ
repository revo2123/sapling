// Exact checks for B-tree insertion (no drawing).
#import "/src/b-tree.typ": b-insert, to-notation

#let build(keys, order) = to-notation(keys.fold(none, (t, k) => b-insert(t, k, order)))

// order 3 (the spec example)
#assert.eq(build((1, 2, 3, 4), 3), ((2,), (1,), (3, 4)))
#assert.eq(build((1, 2, 3, 4, 5), 3), ((2, 4), (1,), (3,), (5,)))
// the split of a full inner page grows the tree
#assert.eq(build((1, 2, 3, 4, 5, 6, 7), 3), ((4,), ((2,), (1,), (3,)), ((6,), (5,), (7,))))
// order 4: upper median goes up
#assert.eq(build((1, 2, 3), 4), (1, 2, 3))
#assert.eq(build((1, 2, 3, 4), 4), ((3,), (1, 2), (4,)))
// order 5
#assert.eq(build((1, 2, 3, 4, 5), 5), ((3,), (1, 2), (4, 5)))
// unordered input, string keys, duplicates are ignored
#assert.eq(build((3, 1, 2, 2, 3), 4), (1, 2, 3))
#assert.eq(build(("b", "a", "c"), 3), (("b",), ("a",), ("c",)))
