# sapling

Typst library for drawing computer science trees (binary trees, BSTs, AVL trees, heaps, treaps, B-trees), plus tree algorithms and walkthroughs. The API is defined in `SPECIFICATION.md`; that file is the source of truth.

## Top priority: simplicity
Keep the API and the code as simple as possible. No style knobs (`dx`, `r`, `font-size`, ...), no speculative features or abstractions. If the spec seems overcomplicated or inconsistent, raise it instead of adding options.

## Code conventions
- Use plain `//` comments, not `///` doc comments or tidy markup (`- arg (type):`, `-> type`).
- Internally every binary tree uses one form: `none` or `(key, left, right)` (long form). Each public function normalizes its input once at the start.
- `X-from(keys)` builds a tree, then calls `X(tree)`, so each type has only one drawing path.
- Reuse the algorithms when building trees: AVL and treap insertion use the rotations, `heap-from` uses `up-heap`.
- Raise errors with `assert(..., message: "sapling: ...")`.
- Old code in `src/old_*.typ` may be reused if it matches the spec. Delete those files once the new files replace them.

## File structure (`src/`)
| File | Purpose | Status |
|---|---|---|
| `lib.typ` | only re-exports the public functions | done (binary, BST, rotations, AVL, treap, heap) |
| `tree.typ` | `normalize`, `key-of`, `keys`, `check-keys`, `as-list`, `height`, `from-level-order`, `positions`, `to-level-order`; heap order for heaps and treaps: `check-order`, `above`, `order-errors` | done |
| `colors.typ` | palette: border/fill, marked (blue), error (red), treap priority, heap index | done |
| `draw.typ` | shared layout and renderer for binary-shaped trees; `draw(tree, marked:, errors:, note:, label:)`; `note` maps a placed node (`n.tree`, `n.index` = level-order index) to content shown right of the node, by default in the marked colour; `label` maps a node's value to its content and turns the nodes into pills as wide as the widest label | done |
| `binary.typ` | `binary-tree`, `binary-tree-from`, `bst`, `bst-from` (+ `bst-insert`, `bst-errors`) | done |
| `rotate.typ` | the four rotations; node-level `left`, `right`, `left-right`, `right-left` are reused by insertion | done |
| `avl.typ` | `avl-tree`, `avl-tree-from` (+ `balance`, `symbol`, `unbalanced`, `rebalance`, `avl-insert`) | done |
| `treap.typ` | `treap`, `treap-from` (+ `check-pairs`, `treap-insert`) | done |
| `heap.typ` | `heap`, `heap-from`, `up-heap`, `down-heap` (+ `sift-up`, `sift-down` on the level-order array) | done |
| `b-tree.typ` | own layout, since nodes hold several keys | todo |
| `walkthrough.typ` | `walkthrough`, `step` | todo |

## Decisions made
- `binary-tree-from` fills the tree level by level (a complete tree).
- Nodes must have exactly 3 elements `(key, left, right)`. `()` and `none` both mean an empty tree.
- `binary-tree` draws duplicate keys as given; only the `-from` functions drop repeated keys.
- When a node is both marked and an error, the error colour wins.
- `bst` error rule: a node is an error if it breaks the bounds set by its *valid* ancestors; a wrong node does not tighten the bounds for its subtrees, so only the offending nodes are red, not everything below them.
- Balance factors use the minus sign `−` (U+2212). Beyond ±2 the sign is repeated (`+++`); every node with |bf| ≥ 2 gets the error colour.
- `height` counts edges, as formally defined: empty tree −1, leaf 0.
- `avl-tree` only checks balance (as the spec says), not the BST order.
- Rotations search the whole tree for `key` (binary trees have no order), so they also work on `binary-tree` input.
- Errors are passed to `draw` as keys, so in a tree with duplicate keys every node with that key gets the colour.
- Treap nodes keep the `(key, prio)` pair in the key slot of the long form. `normalize` only checks the shape; each public function checks the values. `key-of` gives the key of a value, so rotations, `bst-errors` and marking work on treaps unchanged.
- Treaps have no leaf shorthand (as in the spec): a bare `(5, 3)` would be ambiguous with a broken node.
- Treap priorities are compared with their parent only. A node is an error if it breaks the BST order (same rule as `bst`) or its priority belongs above its parent's. Equal priorities are fine, and insertion does not rotate on a tie.
- In treap nodes the priority uses `colors.priority`, for now the same as the key text (a grey one was hard to read).
- Heap errors use the same parent-only rule as treap priorities (`order-errors`). `heap` only checks the order, not the shape: a tree that is not complete is drawn as given without errors.
- Heap indices are shown like balance factors (a note right of the node) in `colors.index`, for now the same as the marked colour. A node's index follows from its position (children of `i` at `2i + 1`, `2i + 2`), so it also works for trees that are not complete.
- `up-heap`/`down-heap` work on the level-order array and rebuild the tree with `from-level-order`. `heap-from` drops duplicate keys, as the spec says, since the algorithms find nodes by key.

## Open spec questions (not decided yet)
- `order` means `"min"`/`"max"` for heaps and treaps but the Knuth order (an int) for B-trees; consider renaming the B-tree one.
- The spec rule "duplicates: ignore after first insertion" doesn't fit the functions that draw a given tree.
- Typst limits how deep function calls can nest, which may matter for degenerate trees (e.g. `bst-from` with sorted keys: works for 60 keys, fails at 100).

## Tests
Tytanic (`tt`) with Typst 0.15.1; see `tests/README.md`. Drawing tests are in `tests/<function>/<case>/test.typ`. Exact `assert`/`assert-panic` checks are in `tests/errors`, `tests/internal`, `tests/rotate` and `tests/heap-algorithms`; they render blank pages, which is expected.

## Next steps
1. `walkthrough`, `b-tree`.
2. README Usage/Examples, delete `src/old_*.typ`.
