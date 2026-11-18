![Version](https://img.shields.io/badge/version-0.1.0-green)
[![Repo](https://img.shields.io/badge/GitHub-repo-444)](https://github.com/revo2123/sapling)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue)](LICENSE)

# sapling
A small and simple Typst library for creating **computer science trees**.

## Features
- **Binary trees, binary search trees, AVL trees, heaps, treaps and B-trees**
- Build a tree from a list of keys, or draw a tree exactly as you give it
- Invalid nodes are marked in red, so you can show *wrong* trees too
- Mark nodes, e.g. the key you just inserted
- Rotations and heap algorithms that return trees you can draw
- Walkthroughs that show how a tree changes, step by step

## Getting started
```typ
#import "@preview/sapling:0.1.0": *
```

### Build a tree from keys
Every tree type has a `-from` function. It inserts the keys one after another and draws the result.
```typ
#bst-from((5, 3, 8, 1, 4))
#avl-tree-from((1, 2, 3, 4, 5))
#heap-from((7, 3, 5, 1))
#heap-from((7, 3, 5, 1), order: "max")
#treap-from(((5, 3), (2, 8), (7, 1)))      // (key, priority) pairs
#b-tree-from(range(1, 11), 4)              // keys, order
```
Keys are all `int` or all `string`. Repeated keys are only inserted once.

### Draw a tree you specify
Without `-from`, the tree is drawn exactly as you write it. A node is `(key, left, right)`. A leaf can be just its key, and `none` is an empty subtree.
```typ
#binary-tree((1, 2, (3, (4, 5, 6), 7)))
#bst((5, (3, 1, 4), 8))
```
Treap nodes use a `(key, priority)` pair as the key, and a B-tree page is `(keys)` for a leaf or `((keys), child, ...)` for an inner page:
```typ
#treap(((5, 3), ((2, 8), none, none), none))
#b-tree(((20, 40), (5, 10), (25, 30), (45, 50)), 4)
```

### Show mistakes
`bst`, `avl-tree`, `heap`, `treap` and `b-tree` mark the nodes that break the rules of their tree in red. This is useful for exercises.
```typ
#bst((5, 8, 3))                          // 8 and 3 are on the wrong sides
#bst((5, 8, 3), show-errors: false)      // draw it without red nodes
```

### Mark nodes
Pass the keys to colour in `marked`. Keys that are not in the tree are ignored.
```typ
#bst-from((5, 3, 8, 1, 4), marked: (4,))
```
A single key needs a trailing comma: `(4,)`.

### Show more detail
```typ
#avl-tree-from((3, 2, 1), show-bf: false)   // hide the balance factors
#heap-from((7, 3, 5, 1), indices: 0)        // show the array index of each node
#treap-from(((5, 3), (2, 8)), parens: true) // write nodes as (key,prio)
```

## Algorithms
Algorithms take a tree and a key and return a new tree, which you can draw with the function of the tree type.
```typ
#let t = (1, none, (2, none, 3))
#bst(rotate-left(t, 1))
```
Available: `rotate-left`, `rotate-right`, `rotate-left-right`, `rotate-right-left` (for binary trees, BSTs, AVL trees and treaps) and `up-heap`, `down-heap` (for heaps, with `order: "min"` or `"max"`).

## Walkthroughs
`walkthrough` puts several pictures next to each other. Wrap a picture in `step` to give it a caption.
```typ
#let t = (1, none, (2, none, 3))
#walkthrough(
  step("before", bst(t)),
  step("rotate-left at 1", bst(rotate-left(t, 1))),
  arrows: true,
)
```
Use `columns: 3` to start a new row after three pictures.

## More
This README covers the basics. All functions, arguments and edge cases are described in [SPECIFICATION.md](SPECIFICATION.md).

## License
MIT, see [LICENSE](LICENSE).
