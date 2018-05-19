# Sudoku


[![Build Status](https://travis-ci.org/scheinerman/Sudoku.jl.svg?branch=master)](https://travis-ci.org/scheinerman/Sudoku.jl)

[![Coverage Status](https://coveralls.io/repos/scheinerman/Sudoku.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/scheinerman/Sudoku.jl?branch=master)

[![codecov.io](http://codecov.io/github/scheinerman/Sudoku.jl/coverage.svg?branch=master)](http://codecov.io/github/scheinerman/Sudoku.jl?branch=master)

This module solves Sudoku puzzles using integer programming.

## Usage

The main function in this module is `sudoku` which takes as input a
9-by-9 integer matrix. The entries of this matrix give the Sudoku puzzle
with 0s representing blanks. The output is the solved Sudoku puzzle.

For testing purposes, we provide three sample puzzles named `Sudoku.puzz1`,
`Sudoku.puzz2`, and `Sudoku.puzz3`.

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

## Comments

* This version only handles 9x9 Sudoku puzzles. It would probably not be
too much work to generalize.
* We provide the function `sudoku_check` that verifies if the output of
`sudoku` is a valid grid.
* We use the CBC solver because it is open source. It would be easy to change
to other solvers.
* Note that the first time `sudoku` is invoked it can be a
bit slow (presumably because of initialization of the integer programming code).
Subsequent calls go faster.
* If a puzzle is given with more than one solution, we only report one answer.
* If a puzzle is given with no solutions, warnings are generated and an all
zero matrix is returned.
