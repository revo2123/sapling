#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// Before a rotation: valid BSTs that are not yet AVL trees.

// right-right case: 10 ++ (red), 20 +, 30 0
#avl-tree(bst-from((10, 20, 30)))

// left-left case: 30 −− (red), 20 −, 10 0
#avl-tree(bst-from((30, 20, 10)))

// right-left case: 10 ++ (red), 20 −, 15 +, others 0
#avl-tree(bst-from((10, 5, 20, 15, 30, 17)))

// bf: none hides the factors; plain chain 10 → 20 → 30
#avl-tree(bst-from((10, 20, 30)), bf: none)
