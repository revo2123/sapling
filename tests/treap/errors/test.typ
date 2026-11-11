#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// priority 1 below priority 3 in a min-treap: 2 red
#treap(((5, 3), ((2, 1), none, none), ((8, 4), none, none)))

// key 7 left of 5: 7 red
#treap(((5, 1), ((7, 2), none, none), none))

// a valid min-treap read as a max-treap: 2 and 8 red
#treap(((5, 1), ((2, 4), none, none), ((8, 3), none, none)), order: "max")

// only the offending node is red: 2 (prio 0 < 3) is red, 1 (prio 6 > 0) is fine
#treap(((5, 3), ((2, 0), ((1, 6), none, none), none), none))

// show-errors: false: nothing red
#treap(((5, 3), ((2, 1), none, none), none), show-errors: false)

// 2 is both marked and an error: red wins; 8 marked blue
#treap(((5, 3), ((2, 1), none, none), ((8, 4), none, none)), marked: (2, 8))
