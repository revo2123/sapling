#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// only ∅
#avl-tree-from(none)
#avl-tree-from(())

// one circle with 1, note 0
#avl-tree-from((1,))

// spec example: 2; left 1; right 3 (right 4); 3 and 4 marked; 2 +, 3 +
#avl-tree-from((1, 2, 3, 4), marked: (3, 4))

// each case of rotation gives 2; left 1; right 3, all 0
#avl-tree-from((1, 2, 3)) // left
#avl-tree-from((3, 2, 1)) // right
#avl-tree-from((3, 1, 2)) // left-right
#avl-tree-from((1, 3, 2)) // right-left

// sorted keys 1 to 7 give the perfect tree 4; 2 (1, 3); 6 (5, 7)
#avl-tree-from(range(1, 8))

// duplicates left out: 5; left 3; right 8
#avl-tree-from((5, 3, 5, 3, 8))

// show-bf: false: no notes
#avl-tree-from((1, 2, 3, 4), show-bf: false)

// string keys: "b"; left "a"; right "c"
#avl-tree-from(("a", "b", "c"))
