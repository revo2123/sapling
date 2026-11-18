#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// nothing
#walkthrough()

// one item: no arrow
#walkthrough(bst-from((2, 1)), arrows: true)

// one row, arrows
#walkthrough(bst-from((2, 1)), bst-from((2, 1, 3)), bst-from((2, 1, 3, 4)), arrows: true)

// steps with captions, own arrow, mixed with a plain tree
#walkthrough(
  step("start", bst-from((5, 3))),
  step("insert 7", bst-from((5, 3, 7))),
  bst-from((5, 3, 7, 6)),
  arrows: $arrow.r.double$,
)

// 2 columns, 5 items: no arrow at the end of a row
#walkthrough(..range(1, 6).map(i => bst-from(range(1, i + 1))), columns: 2, arrows: true, gutter: 20pt)

// columns larger than the item count: same as auto
#walkthrough(binary-tree-from((1, 2)), binary-tree-from((1, 2, 3)), columns: 5)

// with algorithms
#walkthrough(bst((1, none, (2, none, 3))), bst(rotate-left((1, none, (2, none, 3)), 1)), arrows: true)

// step without caption: just the content
#step(none, bst-from((1,)))
