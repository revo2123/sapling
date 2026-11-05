#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// "key,priority" in pills; priority grey
#treap((50, 90, (30, 70, (20, 40), (40, 55)), (70, 80, (60, 10), (80, 5))))

// tuple notation "(key,priority)", pills wide enough
#treap((50, 90, (30, 70), (70, 80, (60, 10), (80, 5))), parens: true)

// only 40,55 in red
#treap((50, 90, (30, 70, (20, 40), (40, 55)), (70, 80, (60, 10), (80, 5))), marked: (40,))

// chain to the right; pills do not overlap
#treap((1, 90, none, (2, 80, none, (3, 70))))

// single pill 5,1
#treap((5, 1))

// only ∅
#treap(none)
