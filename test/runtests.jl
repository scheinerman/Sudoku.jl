using Sudoku, Test 

A = sudoku(Sudoku.puzz1)
@test sudoku_check(A)

A = sudoku(Sudoku.puzz2)
@test sudoku_check(A)

A = sudoku(Sudoku.puzz3)
@test sudoku_check(A)

sudoku_print(A)
x = sudoku_strings(A)
@test length(x)==13
