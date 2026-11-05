#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// Child i hangs from the i-th cell boundary of its parent (0 = far left, n = right of the last key).

// edges end at the top-left corner of the child: middle edge starts between 20 and 40 and ends in front of 25
#b-tree(((20, 40), (5, 10), (25, 30), (45, 50)), slots: 4)

// without slots, nodes are as wide as their keys
#b-tree(((20, 40), (5, 10), (25, 30), (45, 50)))

// edges end at the top centre of each child
#b-tree(((20, 40), (5, 10), (25, 30), (45, 50)), anchor: "center")

// 2-3 tree: 30; 15 and 45; four leaves
#b-tree(((30,), ((15,), (5, 10), (20, 25)), ((45,), (35, 40), (50, 55))), slots: 2)
