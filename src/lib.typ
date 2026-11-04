// sapling: draw computer science trees in pure Typst (no external packages).
//
//   binary-tree(tree)        arbitrary binary tree (BST, ...)
//   bst-from(values)         BST built by inserting the values (pass the result to binary-tree/avl-tree)
//   avl-tree(tree)           like binary-tree, plus balance factors (red if |bf| > 1)
//   heap(values)             heap from an array (level order)
//   treap(tree)              treap, node = (key, priority, left, right), shown as "key,priority"
//   b-tree(tree)             B-tree
//   node(label, l, r)        binary node with extra options (extra:, mark:)
//   snapshot(title, content) one labelled state of a tree
//   walkthrough(..snapshots) several snapshots side by side, e.g. the steps of a solution
//
// Common options:
//   marked: (...)   keys / labels that are highlighted in red
//   binary trees:   dx, dy, r, font-size  (heap/treap/avl-tree accept them too)
//   treap:          parens (show "(key,priority)"), pill-width
//   B-tree:         slots, anchor ("left" | "center"), cell (cell size), dy, gap, font-size
//   Lengths must be absolute (cm, mm, pt), not em.

#import "binary.typ": node, binary-tree, bst-from
#import "avl.typ": avl-tree
#import "heap.typ": heap
#import "treap.typ": treap
#import "b-tree.typ": b-tree
#import "walkthrough.typ": snapshot, walkthrough
