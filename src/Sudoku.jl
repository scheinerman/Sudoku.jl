module Sudoku

# package code goes here

using JuMP
# using MathProgBase
using Cbc

export sudoku, sudoku_check

"""
`sudoku(A::Matrix)` solves the Sudoku puzzle given by the matrix `A`.
Here `A` is a 9-by-9 integer matrix whose nonzero entries are the
given values of a Sudoku puzzle and whose zero values are the blanks.
"""
function sudoku(A::Matrix{Int})::Matrix{Int}
    n = 9
    nn = 3
    MOD = Model(with_optimizer(Cbc.Optimizer, logLevel = 0))

    # variable X[i,j,k] = 1 means there's a k in cell (i,j)
    @variable(MOD,X[1:n,1:n,1:n], Bin)

    # At most one entry in each cell
    for i=1:n
        for j=1:n
            @constraint(MOD, sum(X[i,j,k] for k=1:n) == 1)
        end
    end

    # There is exactly one k in every row
    for i=1:n
        for k=1:n
            @constraint(MOD, sum(X[i,j,k] for j=1:n)==1)
        end
    end

    # There is exactly one k in every column
    for j=1:n
        for k=1:n
            @constraint(MOD, sum(X[i,j,k] for i=1:n)==1)
        end
    end

    # Each 3x3 sub square has exactly one k

    for a=1:nn
        for b=1:nn
            for k=1:n
                @constraint(MOD, sum(X[i,j,k] for i=3a-2:3a for j=3b-2:3b) == 1)
            end
        end
    end

    # Process values in A
    for i=1:n
        for j=1:n
            if A[i,j] != 0
                @constraint(MOD, X[i,j,A[i,j]] == 1)
            end
        end
    end

    # now solve and extract the solution
    optimize!(MOD)
    status = Int(termination_status(MOD))
    if status != 1
        error("No solution to this Sudoku puzzle")
    end

    XX = value.(X)
    B = zeros(Int,n,n)
    for i=1:n
        for j=1:n
            for k=1:n
                if XX[i,j,k]>0
                    B[i,j] = k
                end
            end
        end
    end
    return B
end

"""
`sudoku_check(A)` checks if a 9x9 matrix is a valid solution to a Sudoku
puzzle. That is, we check that every row, column, and 3x3 submatrix contains
the values 1 through 9 exactly once each.
"""
function sudoku_check(A::Matrix{Int})::Bool
    vals = collect(1:9)
    n = 9
    nn = 3

    for i=1:n
        row = sort(A[i,:])
        if row != vals
            return false
        end
    end

    for j=1:n
        col = sort(A[:,j])
        if col != vals
            return false
        end
    end

    for a=0:nn-1
        for b=0:nn-1
            AA = A[nn*a+1:nn*(a+1), nn*b+1:nn*(b+1)]
            if sort(AA[:]) != vals
                return false
            end
        end
    end

    return true
end

include("sudoku_print.jl")
include("examples.jl")

end # module
