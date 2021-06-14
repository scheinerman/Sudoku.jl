module Sudoku

# package code goes here

using JuMP
using Cbc

export sudoku, sudoku_check

"""
`sudoku(A::Matrix)` solves the Sudoku puzzle given by the matrix `A`.
Here `A` is a 9-by-9 integer matrix whose nonzero entries are the
given values of a Sudoku puzzle and whose zero values are the blanks.
"""
function sudoku(A::Matrix{Int})::Matrix{Int}
    nn = size(A)[1] # number of items per row/column/block
    n = Int(sqrt(nn)) # size of the problem: normal sudoku n = 3
    MOD = Model(JuMP.optimizer_with_attributes(Cbc.Optimizer, "logLevel" => 0))

    # variable X[i,j,k] = 1 means there's a k in cell (i,j)
    @variable(MOD,X[1:nn,1:nn,1:nn], Bin)

    ########### model constraints ##################
    @constraints(MOD, begin
        oneKPerCell, sum(X[1:nn, 1:nn, k] for k ∈ 1:nn) .== 1
        oneKPerRow, sum(X[1:nn, j, 1:nn] for j ∈ 1:nn) .== 1
        oneKPerCol, sum(X[i, 1:nn, 1:nn] for i ∈ 1:nn) .== 1
        oneKPerBlock, sum.(X[i:i+n-1, j:j+n-1, k] for k ∈ 1:nn, i ∈ 1:n:nn, j ∈ 1:n:nn) .== 1
    end)

    # Process values in A
    nonZeroIndices = findall(i -> i != 0, A)
    for i in nonZeroIndices
        @constraint(MOD, X[i, A[i]] == 1)
    end

    # now solve and extract the solution
    optimize!(MOD)
    status = Int(termination_status(MOD))
    if status != 1
        error("No solution to this Sudoku puzzle")
    end

    return Int.(sum(value.(X[:,:,k]) * k for k in 1:nn))
end


"""
`sudoku_check(A)` checks if a 9x9 matrix is a valid solution to a Sudoku
puzzle. That is, we check that every row, column, and 3x3 submatrix contains
the values 1 through 9 exactly once each.
"""
function sudoku_check(A::Matrix{Int})::Bool
    nn = size(A)[1] # number of items per row/column/block
    n = Int(sqrt(nn)) # size of the problem: normal sudoku n = 3
    
    # All items in a row are 1:9
    if !all(mapslices(aux -> sort(aux) == 1:nn, A, dims = 1))
        return false
    end

    # All items in a column are 1:9
    if !all(mapslices(aux -> sort(aux) == 1:nn, A, dims = 2))
        return false
    end

    # Finally we check each block, if we get this far, the sucoku will be correct
    # or not decided by this condition
    return all(aux -> sort(aux) == 1:nn, vec.([A[i:i+n-1, j:j+n-1] for 
        i ∈ 1:n:nn, j ∈ 1:n:nn]))
end

include("sudoku_print.jl")
include("examples.jl")

end # module