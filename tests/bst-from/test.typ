#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

#assert.eq(bst-from(()), none)
#assert.eq(bst-from((5,)), (5, none, none))
#assert.eq(bst-from((5, 3, 8)), (5, (3, none, none), (8, none, none)))

// duplicates are ignored
#assert.eq(bst-from((5, 3, 5, 3)), (5, (3, none, none), none))
