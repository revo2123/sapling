#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// single node, 3 of 4 cells filled
#b-tree((5, 10, 15), slots: 4)

// empty root: 4 empty cells
#b-tree((), slots: 4)

// empty root without slots: one empty cell
#b-tree(())

// root with 1 key (2-3 tree, only 2-nodes)
#b-tree(((10,), (5,), (15,)))
