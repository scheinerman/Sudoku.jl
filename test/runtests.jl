using Sudoku
@static if VERSION < v"0.7.0-DEV.2005"
    using Base.Test
else
    using Test
end

A = sudoku(Sudoku.puzz1)
@test sudoku_check(A)

A = sudoku(Sudoku.puzz2)
@test sudoku_check(A)

A = sudoku(Sudoku.puzz3)
@test sudoku_check(A)

sudoku_print(A)
x = sudoku_strings(A)
@test length(A)==13
