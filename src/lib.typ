// sapling: draw computer science trees and graphs in pure Typst (no external packages).
//
//   binary-tree(tree)        arbitrary binary tree (BST, ...)
//   bst-from(values)         BST built by inserting the values (pass the result to binary-tree/avl-tree)
//   avl-tree(tree)           like binary-tree, plus balance factors (red if |bf| > 1)
//   heap(values)             heap from an array (level order)
//   treap(tree)              treap, node = (key, priority, left, right), shown as "key,priority"
//   b-tree(tree)             B-tree
//   node(label, l, r)        binary node with extra options (extra:, mark:)
//   graph(vertices, edges)   graph (undirected, directed, weighted, mixed), see graph.typ
//   edge(from, to, weight)   graph edge with extra options (directed:, bend:, pos:, angle:)
//   path-edges(..vertices)   the edges of a path, e.g. for marked-edges
//   adjacency-matrix(vertices, edges)  adjacency matrix of a graph
//   adjacency-list(vertices, edges)    adjacency list of a graph
//   snapshot(title, content) one labelled state of a tree or graph
//   walkthrough(..snapshots) several snapshots side by side, e.g. the steps of a solution
//
// Common options:
//   marked: (...)   keys / labels that are highlighted in red
//   binary trees:   dx, dy, r, font-size  (heap/treap/avl-tree accept them too)
//   treap:          parens (show "(key,priority)"), pill-width
//   B-tree:         slots, anchor ("left" | "center"), cell (cell size), dy, gap, font-size
//   graph:          directed, marked, visited, groups, marked-edges, visited-edges,
//                   faded-edges, extra, labels, dx, dy, r, font-size
//   walkthrough:    columns (snapshots per row)
//   Lengths must be absolute (cm, mm, pt), not em.

#import "binary.typ": node, binary-tree, bst-from
#import "avl.typ": avl-tree
#import "heap.typ": heap
#import "treap.typ": treap
#import "b-tree.typ": b-tree
#import "graph.typ": graph, edge, path-edges, adjacency-matrix, adjacency-list
#import "walkthrough.typ": snapshot, walkthrough
