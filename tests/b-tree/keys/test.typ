#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// strings as keys
#b-tree((("M",), ("D", "G"), ("P", "T")))

// 15 and 28 highlighted
#b-tree(((10, 20, 30), (5, 7), (12, 15), (22, 28), (35, 40)), marked: (15, 28))

// wide cells, subtrees directly adjacent; edges still at the boundaries
#b-tree((("Bella", "Dora"), ("Anna", "Arno"), ("Bernd", "Chris"), ("Emil", "Fritz")), cell: 1.1cm, gap: 0cm)

// larger cells and font
#b-tree((("M",), ("D", "G"), ("P", "T")), cell: 0.9cm, font-size: 11pt)
