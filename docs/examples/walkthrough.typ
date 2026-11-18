#import "/src/lib.typ": *
#set page(width: auto, height: auto, margin: 10pt, fill: white)
#let t = (3, (2, 1, none), none)
#walkthrough(
  step("unbalanced", avl-tree(t)),
  step("rotate-right at 3", avl-tree(rotate-right(t, 3))),
  arrows: true,
)
