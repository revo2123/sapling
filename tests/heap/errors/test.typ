#set page(width: auto, height: auto, margin: 1em)
#import "/src/lib.typ": *

// 3 is smaller than its parent 5: 3 red; 4 and 9 are fine against 3
#heap((5, (3, 4, 9), 8))

// read as a max-heap: 4 and 9 (larger than 3) and 8 (larger than 5) red
#heap((5, (3, 4, 9), 8), order: "max")

// equal keys are fine: nothing red
#heap((2, 2, 3))

// show-errors: false: nothing red
#heap((5, (3, 4, 9), 8), show-errors: false)

// 3 is both marked and an error: red wins; 8 marked blue; with indices
#heap((5, (3, 4, 9), 8), marked: (3, 8), indices: 1)
