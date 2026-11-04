#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

#walkthrough(
  snapshot("1) insert 7", b-tree((3, 5, 7), slots: 4)),
  snapshot("2) insert 9", b-tree((3, 5, 7, 9), slots: 4)),
  snapshot("3) insert 11 (split)", b-tree(((7,), (3, 5), (9, 11)), slots: 4)),
)
