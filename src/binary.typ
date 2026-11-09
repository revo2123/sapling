// Binary trees (and, later, binary search trees).

#import "tree.typ": as-list, check-keys, from-level-order, keys, normalize
#import "draw.typ": draw

// Draws a binary tree exactly as given.
#let binary-tree(tree, marked: none) = {
  let tree = normalize(tree)
  let marked = as-list(marked, "marked")
  check-keys(keys(tree) + marked)
  draw(tree, marked: marked)
}

// Draws a binary tree filled with the keys in level order
// (top to bottom, left to right), so it is always a complete tree.
// Duplicates after the first occurrence are left out.
#let binary-tree-from(keys, marked: none) = {
  let keys = as-list(keys, "keys").dedup()
  binary-tree(from-level-order(keys), marked: marked)
}
