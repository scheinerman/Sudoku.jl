module Sudoku

# package code goes here

using JuMP
using MathProgBase
using Cbc

export sudoku

"""
`sudoku(A::Matrix)` solves the Sudoku puzzle given by the matrix `A`.
Here `A` is a 9-by-9 integer matrix whose nonzero entries are the
given values of a Sudoku puzzle and whose zero values are the blanks.
"""
function sudoku(A::Matrix{Int})::Matrix{Int}
    n = 9
    nn = 3
    # MOD = Model(solver=GurobiSolver())
    MOD = Model(solver=CbcSolver())

    # variable X[i,j,k] = 1 means there's a k in cell (i,j)
    @variable(MOD,X[1:n,1:n,1:n], Bin)

    # At most one entry in each cell
    for i=1:n
        for j=1:n
            @constraint(MOD, sum(X[i,j,k] for k=1:n) == 1)
        end
    end

    # There is exactly on k in every row
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

    # Each 3x3 sub square has exactly on k

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

    # now solve

    status = solve(MOD)
    XX = getvalue(X)
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


end # module
