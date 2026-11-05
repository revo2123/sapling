#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// nodes with different fill levels (2, 2, 3, 4, 2 keys); edges at boundaries 0–4
#b-tree(
  ((10, 20, 30, 40), (5, 6), (12, 15), (22, 25, 28), (32, 35, 37, 39), (45, 50)),
  slots: 4,
)

// three levels: 50; (20 35) and (70 85); three leaves each
#b-tree(
  (
    (50,),
    ((20, 35), (5, 10), (22, 30), (40, 45)),
    ((70, 85), (55, 60), (72, 80), (90, 99)),
  ),
  slots: 4,
)

// four levels, 2-3 tree with only 2-nodes: 50; 25 and 75; eight leaves
#b-tree(
  (
    (50,),
    ((25,), ((10,), (5,), (15,)), ((35,), (30,), (40,))),
    ((75,), ((60,), (55,), (65,)), ((90,), (80,), (95,))),
  ),
)

// root with 5 keys centred above 6 leaves; edges at boundaries 0–5
#b-tree(((20, 40, 60, 80, 100), (5, 10), (25, 30), (45, 50), (65, 70), (85, 90), (105, 110)))
