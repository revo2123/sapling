#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

#binary-tree(
  node(8, node(4, mark: true), node(12), extra: "root"),
  marked: (12,),
)
