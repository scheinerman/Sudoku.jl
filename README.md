# Sudoku


[![Build Status](https://travis-ci.com/scheinerman/Sudoku.jl.svg?branch=master)](https://travis-ci.com/scheinerman/Sudoku.jl)


[![codecov.io](http://codecov.io/github/scheinerman/Sudoku.jl/coverage.svg?branch=master)](http://codecov.io/github/scheinerman/Sudoku.jl?branch=master)

This module solves Sudoku puzzles using integer programming.

## Usage

The main function in this module is `sudoku` which takes as input a
9-by-9 integer matrix. The entries of this matrix give the Sudoku puzzle
with 0s representing blanks. The output is the solved Sudoku puzzle.

The `sudoku` function also solves puzzles of other sizes (such as 4-by-4 or 16-by-16).

For testing purposes, we provide sample puzzles as follows: 
* `Sudoku.puzz1`, `Sudoku.puzz2`, and `Sudoku.puzz3` are 9-by-9 puzzles.
* `Sudoku.puzz21`, `Sudoku.puzz22`, and `Sudoku.puzz23` are 4-by-4 puzzles.
* `Sudoku.puzz41` is a 16-by-16 puzzle.

```julia
julia> using Sudoku

julia> A = Sudoku.puzz1
9×9 Array{Int64,2}:
 9  3  0  0  0  0  0  4  0
 0  0  0  0  4  2  0  9  0
 8  0  0  1  9  6  7  0  0
 0  0  0  4  7  0  0  0  0
 0  2  0  0  0  0  0  6  0
 0  0  0  0  2  3  0  0  0
 0  0  8  5  3  1  0  0  2
 0  9  0  2  8  0  0  0  0
 0  7  0  0  0  0  0  5  3

julia> sudoku(A)
9×9 Array{Int64,2}:
 9  3  6  7  5  8  2  4  1
 1  5  7  3  4  2  6  9  8
 8  4  2  1  9  6  7  3  5
 6  8  3  4  7  5  1  2  9
 5  2  4  8  1  9  3  6  7
 7  1  9  6  2  3  5  8  4
 4  6  8  5  3  1  9  7  2
 3  9  5  2  8  7  4  1  6
 2  7  1  9  6  4  8  5  3
```

If there is no solution to the puzzle, an error is thrown.

## Nice Printing

The function `sudoku_print` prints a Sudoku matrix in an attractive manner.
```julia
julia> sudoku_print(A)
+-------+-------+-------+
| 9 3 . | . . . | . 4 . |
| . . . | . 4 2 | . 9 . |
| 8 . . | 1 9 6 | 7 . . |
+-------+-------+-------+
| . . . | 4 7 . | . . . |
| . 2 . | . . . | . 6 . |
| . . . | . 2 3 | . . . |
+-------+-------+-------+
| . . 8 | 5 3 1 | . . 2 |
| . 9 . | 2 8 . | . . . |
| . 7 . | . . . | . 5 3 |
+-------+-------+-------+

julia> sudoku_print(sudoku(A))
+-------+-------+-------+
| 9 3 6 | 7 5 8 | 2 4 1 |
| 1 5 7 | 3 4 2 | 6 9 8 |
| 8 4 2 | 1 9 6 | 7 3 5 |
+-------+-------+-------+
| 6 8 3 | 4 7 5 | 1 2 9 |
| 5 2 4 | 8 1 9 | 3 6 7 |
| 7 1 9 | 6 2 3 | 5 8 4 |
+-------+-------+-------+
| 4 6 8 | 5 3 1 | 9 7 2 |
| 3 9 5 | 2 8 7 | 4 1 6 |
| 2 7 1 | 9 6 4 | 8 5 3 |
+-------+-------+-------+
```



## Comments

* We provide the function `sudoku_check` that verifies if the output of
`sudoku` is a valid grid.
* We use the CBC solver because it is open source. It would be easy to change
to other solvers.
* Note that the first time `sudoku` is invoked it can be a
bit slow (presumably because of initialization of the integer programming code).
Subsequent calls go faster.
* If a puzzle is given with more than one solution, we only report one answer.
* If a puzzle is given with no solutions, an error is thrown.

## Acknowledgement

Thanks to Diego Valcarce for code simplifications and improvements, including the ability to handle different size Sudoku puzzles. 


