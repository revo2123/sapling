#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// chain going down to the left
#binary-tree((5, (4, (3, (2, 1)))))

// chain going down to the right
#binary-tree((1, none, (2, none, (3, none, (4, none, 5)))))

// 1 → right 4 → left 2 → right 3
#binary-tree((1, none, (4, (2, none, 3))))

// deep left branch, single leaf 70 on the right; no overlap
#binary-tree(bst-from((50, 30, 20, 10, 5, 25, 40, 70)))
