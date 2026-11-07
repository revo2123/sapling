# Blueprint
## function-name
Description of what it does.
```typ
#let function-name(argument1, argument2, argument3: default)
```
- `argument1` (int, required): further description of the argument
- `argument2` (string|int, required): further description of the argument
- `argument3` (int, optional): further description of the argument 

**Edge-Cases:**
- `condition`: description
 
**Example:** `function-name(1, "abc")`

# Binary Trees
## binary-tree-from
Generates a binary tree, as if the nodes were added to the tree in the given order.
```typ
#let binary-tree-from(keys, marked: none)
```
- `keys` (none|int[]|string[], required): list of all keys that end up in the tree
- `marked` (none|int[]|string[], optional): list of all keys whose nodes will be marked

**Edge-Cases:**
- `keys` is `none` or `()`: draw only ∅
- duplicate keys: ignore after first insertion
- key in `marked` is not in `keys`: ignore marked key

**Example:** `binary-tree-from((1, 2, 3, 4), (3, 4))`

## binary-tree
Generates a binary tree from the tree given.
```typ
#let binary-tree(tree, marked: none)
```
- `tree` (tree, required): `none`, a key (leaf), or `(key, left, right)`, where `left` and `right` are trees
- `marked` (none|int[]|string[], optional): list of all keys whose nodes will be marked

**Edge-Cases:**
- `tree` is `none` or `()`: draw only ∅
- duplicate keys: ignore after first insertion
- key in `marked` is not in `keys`: ignore marked key

**Example:** `binary-tree((1, 2, (3, (4, 5, 6), 7)))`


# Binary Search Trees
## bst-from
Generates a binary search tree, as if the nodes were added to the tree in the given order.
```typ
#let bst-from(keys, marked: none)
```
- `keys` (none|int[]|string[], required): list of all keys that end up in the tree
- `marked` (none|int[]|string[], optional): list of all keys whose nodes will be marked

**Edge-Cases:**
- `keys` is `none` or `()`: draw only ∅
- duplicate keys: ignore after first insertion
- key in `marked` is not in `keys`: ignore marked key

**Example:** `bst-from((1, 2, 3, 4), (3, 4))`

## bst
Generates a binary tree from the tree given. Does not have to be a valid binary search tree, will mark all nodes that do not conform if `showErrors` is true.
```typ
#let bst(tree, marked: none, showErrors: true)
```
- `tree` (tree, required): `none`, a key (leaf), or `(key, left, right)`, where `left` and `right` are trees
- `marked` (none|int[]|string[], optional): list of all keys whose nodes will be marked (different color from `showErrors` markings)
- `showErrors` (bool, optional): if `true` mark all nodes that do not conform to bst, if `false` ignore wrong nodes

**Edge-Cases:**
- `tree` is `none` or `()`: draw only ∅
- duplicate keys: ignore after first insertion
- key in `marked` is not in `keys`: ignore marked key

**Example:** `bst((1, 2, (3, (4, 5, 6), 7)))`

# AVL Trees
## avl-tree-from
Generates a AVL-Tree, as if the nodes were added to the tree in the given order. If `showBf` is true, show balance factors of all nodes with `--`, `-`, `0`, `+`, `++`. `-` means left-heavy, `+` means right-heavy.
```typ
#let avl-tree-from(keys, marked: none, showBf: true)
```
- `keys` (none|int[]|string[], required): list of all keys that end up in the tree
- `marked` (none|int[]|string[], optional): list of all keys whose nodes will be marked
- `showBf` (bool, optional): if `true` annotate all nodes with their balance factors using `--`, `-`, `0`, `+`, `++` and mark nodes with `--` or `++`, `false` ignore

**Edge-Cases:**
- `keys` is `none` or `()`: draw only ∅
- duplicate keys: ignore after first insertion
- key in `marked` is not in `keys`: ignore marked key

**Example:** `avl-tree-from((1, 2, 3, 4), (3, 4))`

## avl-tree
Generates a AVL-Tree from the tree given. If `showBf` is true, show balance factors of all nodes with `--`, `-`, `0`, `+`, `++`. `-` means left-heavy, `+` means right-heavy.
```typ
#let avl-tree(tree, marked: none, showBf: true)
```
- `tree` (tree, required): `none`, a key (leaf), or `(key, left, right)`, where `left` and `right` are trees
- `marked` (none|int[]|string[], optional): list of all keys whose nodes will be marked (different color from `showBf` markings)
- `showBf` (bool, optional): if `true` annotate all nodes with their balance factors using `--`, `-`, `0`, `+`, `++` and mark nodes with `--` or `++`, `false` ignore

**Edge-Cases:**
- `tree` is `none` or `()`: draw only ∅
- duplicate keys: ignore after first insertion
- key in `marked` is not in `keys`: ignore marked key

**Example:** `avl-tree((1, 2, (3, (4, 5, 6), 7)))`

# Heaps
## heap-from
Generates a heap, as if the nodes were added to the tree in the given order.
```typ
#let heap-from(keys, marked: none, showIndices: true)
```
- `keys` (none|int[]|string[], required): list of all keys that end up in the tree
- `marked` (none|int[]|string[], optional): list of all keys whose nodes will be marked
- `showIndices` (bool, optional): shows the array index at each node

**Edge-Cases:**
- `keys` is `none` or `()`: draw only ∅
- duplicate keys: ignore after first insertion
- key in `marked` is not in `keys`: ignore marked key

**Example:** `heap-from((1, 2, 3, 4), (3, 4))`

## heap
Generates a heap from the tree given. If `showIndices` is true, show the array index of each node.
```typ
#let heap(tree, marked: none, showIndices: true)
```
- `tree` (tree, required): `none`, a key (leaf), or `(key, left, right)`, where `left` and `right` are trees
- `marked` (none|int[]|string[], optional): list of all keys whose nodes will be marked
- `showIndices` (bool, optional): shows the array index at each node

**Edge-Cases:**
- `keys` is `none` or `()`: draw only ∅

**Example:** `heap((1, 2, (3, (4, 5, 6), 7)))`

# Treaps
## treap-from
Generates a treap, as if the nodes were added to the tree in the given order.
```typ
#let treap-from(keys, marked: none, parens: false)
```
- `keys` (none|(int,int)[]|(string,string)[], required): list of all `(key,prio)` pairs that end up in the tree
- `marked` (none|int[]|string[], optional): list of all keys whose nodes will be marked
- `parens` (bool, optional): if `true` show nodes as `(1,2)`, if `false` show `1,2` for the nodes

## treap
Generates a treap from the tree given. Does not have to be a valid treap, will mark all nodes that do not conform if `showErrors` is true.
```typ
#let treap(tree, marked: none, showErrors: true)
```
- `tree` (tree, required): `none`, a pair `(key,prio)`, or `((key, prio), left, right)`, where `left` and `right` are trees
- `marked` (none|int[]|string[], optional): list of all keys whose nodes will be marked (different color from `showError` markings)
- `showErrors` (bool, optional): if `true` mark all nodes that do not conform to treap, if `false` ignore wrong nodes

**Edge-Cases:**
- `tree` is `none` or `()`: draw only ∅
- key in `marked` is not in `keys`: ignore marked key

**Example:** `treap(((1,2), none, ((3,4), none, none)))`

# B Tree

# Walkthrough
