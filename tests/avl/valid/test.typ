#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// Balance factor = height(right) − height(left), shown as 0, +, ++, −, −−.
// Nodes with ++ or −− are red.

// 20 +, 10 0, 30 +, 35 +, all others 0; nothing red
#avl-tree(bst-from((20, 10, 30, 5, 15, 25, 35, 40)))

// 20 −, 10 −, 5 0, 30 0; nothing red
#avl-tree(bst-from((20, 10, 30, 5)))

// convention left − right: signs flip (20 +, 10 +)
#avl-tree(bst-from((20, 10, 30, 5)), bf: "lr")

// only node 30 red
#avl-tree(bst-from((20, 10, 30, 5)), marked: (30,))

// circle 1 with 0
#avl-tree(1)

// only ∅
#avl-tree(none)
