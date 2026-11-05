#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// strings as keys
#binary-tree(("M", ("C", "A", "F"), ("T", "P", "Z")))

// negative and multi-digit numbers
#binary-tree((-10, (-25, -30, -20), (100, 50, 500)))

// expression tree a + (b · c) with math labels
#binary-tree(($+$, $a$, ($dot$, $b$, $c$)))

// 4 and 10 in red
#binary-tree((8, (4, 2, 6), (12, 10, 14)), marked: (4, 10))

// all four leaves in red
#binary-tree(bst-from((50, 30, 70, 20, 40, 60, 80)), marked: (20, 40, 60, 80))

// 3 in red; annotation "root" at 5
#binary-tree(node(5, node(3, mark: true), node(8), extra: "root"))
