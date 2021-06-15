using Sudoku, Test 
#### n = 2 ####
A = sudoku(Sudoku.puzz21)
@test sudoku_check(A)

A = sudoku(Sudoku.puzz22)
@test sudoku_check(A)

A = sudoku(Sudoku.puzz23)
@test sudoku_check(A)

sudoku_print(A)

#### n = 3 ####
A = sudoku(Sudoku.puzz1)
@test sudoku_check(A)

A = sudoku(Sudoku.puzz2)
@test sudoku_check(A)

A = sudoku(Sudoku.puzz3)
@test sudoku_check(A)

sudoku_print(A)

#### n = 4 ####
A = sudoku(Sudoku.puzz41)
@test sudoku_check(A)
sudoku_print(A)