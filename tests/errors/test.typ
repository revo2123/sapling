#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// node: at most two children
#assert-panic(() => node(1, 2, 3, 4))

// binary tree: a node is (label, left, right)
#assert-panic(() => binary-tree((1, 2, 3, 4)))
#assert-panic(() => binary-tree(()))

// treap: a node is (key, priority, left, right)
#assert-panic(() => treap(5))
#assert-panic(() => treap((1,)))
#assert-panic(() => treap((1, 2, none, none, none)))

// b-tree: a node must be an array
#assert-panic(() => b-tree(5))

// b-tree: inner node without keys
#assert-panic(() => b-tree(((), (1,))))

// b-tree: n keys need n + 1 children
#assert-panic(() => b-tree(((10,), (5,))))

// b-tree: keys must fit into the slots
#assert-panic(() => b-tree((1, 2, 3), slots: 2))

// b-tree: anchor must be "left" or "center"
#assert-panic(() => b-tree((1, 2), anchor: "top"))

// edge: at most one weight
#assert-panic(() => edge("A", "B", 1, 2))

// graph: vertices and edges must be arrays
#assert-panic(() => graph("A", ()))
#assert-panic(() => graph(("A",), "A"))

// graph: a vertex must be a string or an integer
#assert-panic(() => graph(($a$,), ()))

// graph: a placed vertex is (id, column, row)
#assert-panic(() => graph((("A", 0),), ()))

// graph: duplicate vertex, also as integer and string
#assert-panic(() => graph(("A", "A"), ()))
#assert-panic(() => graph((1, "1"), ()))

// graph: place all vertices or none
#assert-panic(() => graph((("A", 0, 0), "B"), ()))

// graph: an edge is (from, to) or (from, to, weight)
#assert-panic(() => graph(("A", "B"), (("A",),)))
#assert-panic(() => graph(("A", "B"), (("A", "B", 1, 2),)))

// graph: a single edge without a trailing comma
#assert-panic(() => graph(("A", "B"), (("A", "B"))))

// graph: edge with unknown vertex
#assert-panic(() => graph(("A",), (("A", "B"),)))
#assert-panic(() => adjacency-matrix(("A",), (("A", "B"),)))
#assert-panic(() => adjacency-list(("A",), (("A", "B"),)))

// graph: unknown vertex in marked, visited, groups, extra, labels
#assert-panic(() => graph(("A",), (), marked: ("B",)))
#assert-panic(() => graph(("A",), (), visited: ("B",)))
#assert-panic(() => graph(("A",), (), groups: (("B",),)))
#assert-panic(() => graph(("A",), (), extra: (B: 1)))
#assert-panic(() => graph(("A",), (), labels: (B: 1)))

// graph: a single vertex without a trailing comma
#assert-panic(() => graph(("A",), (), marked: "A"))

// graph: unknown edge in marked-edges, visited-edges, faded-edges
#assert-panic(() => graph(("A", "B"), (), marked-edges: (("A", "B"),)))
#assert-panic(() => graph(("A", "B"), (), visited-edges: (("A", "B"),)))
#assert-panic(() => graph(("A", "B"), (), faded-edges: (("A", "B"),)))

// graph: directed edges only match in their direction
#assert-panic(() => graph(("A", "B"), (("A", "B"),), directed: true, marked-edges: (("B", "A"),)))

// graph: the weight must match, if given
#assert-panic(() => graph(("A", "B"), (("A", "B", 1),), marked-edges: (("A", "B", 2),)))
