// Shared input handling for binary-shaped trees.
//
// Internally every tree is in long form: `none` (empty) or `(key, left, right)`,
// where `left` and `right` are again trees in long form.

// Whether `value` can be used as a key.
#let is-key(value) = type(value) == int or type(value) == str

// Checks that all keys are valid and of one type (all `int` or all `string`).
#let check-keys(keys) = {
  for k in keys {
    assert(is-key(k), message: "sapling: keys must be int or string, got " + repr(k))
  }
  assert(
    keys.map(type).dedup().len() <= 1,
    message: "sapling: keys must be all int or all string, not mixed",
  )
}

// Turns an optional list argument (`keys`, `marked`) into an array.
// `name` is the argument's name, used in the error message.
#let as-list(value, name) = {
  if value == none { return () }
  assert(
    type(value) == array,
    message: "sapling: " + name + " must be an array or none, got " + repr(value)
      + " (a single key needs a trailing comma: (3,))",
  )
  value
}

// Converts a tree from user notation to long form.
// Accepts `none`, `()`, a key (leaf) or `(key, left, right)`.
#let normalize(tree) = {
  if tree == none or tree == () { return none }
  if type(tree) != array {
    assert(is-key(tree), message: "sapling: keys must be int or string, got " + repr(tree))
    return (tree, none, none)
  }
  assert(
    tree.len() == 3,
    message: "sapling: a node is (key, left, right), got " + repr(tree),
  )
  let (key, left, right) = tree
  assert(is-key(key), message: "sapling: keys must be int or string, got " + repr(key))
  (key, normalize(left), normalize(right))
}

// All keys of a tree in long form, in in-order.
#let keys(tree) = {
  if tree == none { return () }
  let (key, left, right) = tree
  keys(left) + (key,) + keys(right)
}

// Height of a tree in long form (counting edges): −1 for the empty tree, 0 for a leaf.
#let height(tree) = {
  if tree == none { return -1 }
  1 + calc.max(height(tree.at(1)), height(tree.at(2)))
}

// Builds a complete tree from keys in level order:
// index `i` has its children at `2i + 1` and `2i + 2`.
#let from-level-order(keys, i: 0) = {
  if i >= keys.len() { return none }
  (
    keys.at(i),
    from-level-order(keys, i: 2 * i + 1),
    from-level-order(keys, i: 2 * i + 2),
  )
}
