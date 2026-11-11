#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// only ∅
#treap(none)
#treap(())

// spec example, valid min-treap: 1,2 with right child 3,4
#treap(((1, 2), none, ((3, 4), none, none)))

// valid min-treap: 5,1; left 2,4 (1,6), right 8,3 (none, 9,5)
#treap(((5, 1), ((2, 4), ((1, 6), none, none), none), ((8, 3), none, ((9, 5), none, none))))

// parens: nodes as (5,1)
#treap(((5, 1), ((2, 4), none, none), ((8, 3), none, none)), parens: true)

// valid max-treap: 5,9; left 2,4; right 8,7
#treap(((5, 9), ((2, 4), none, none), ((8, 7), none, none)), order: "max")

// string keys, character priorities, float priorities: nothing red
#treap((("m", "a"), (("c", "b"), none, none), (("x", "c"), none, none)))
#treap(((5, 0.5), ((2, 1.5), none, none), none))

// equal priorities are fine: nothing red
#treap(((5, 2), ((2, 2), none, none), none))

// 2 and 8 marked blue
#treap(((5, 1), ((2, 4), none, none), ((8, 3), none, none)), marked: (2, 8))

// marked key not in tree: ignored
#treap(((5, 1), none, none), marked: (99,))
