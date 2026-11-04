<!-- ADD BADGES HERE -->

# sapling
A small and simple Typst library for creating **computer science tree structures**.

## Features
- **Binary (Search) Trees**
- **AVL Trees** (with balance factors)
- **Heaps** (with optional indices)
- **Treaps** (with or without parenthesis)
- **B-Trees** (with anchor modes)
- Marking and annotating nodes

## Usage
```typ
#import "@preview/sapling:0.1.0": *

#binary-tree((8, (4, 2, 6), (12, none, 14)))
#avl-tree(bst-from((5, 3, 8, 1, 4)))
#heap((9, 7, 8, 3, 4))
#b-tree(((20,), (5, 10), (25, 30)), slots: 4)
```

## Examples
<!-- ADD EXAMPLES HERE -->

## License
MIT, see [LICENSE](LICENSE).
