export sudoku_print

"""
`sudoku_print(A)` prints the Sudoku board `A` in an attractive manner.
"""
function sudoku_print(A::Matrix)
    A = replace(i -> i == 0 ? "." : string(i), Matrix{Any}(A))
    nn = size(A)[1]
    n = Int(sqrt(nn))

    digitsLength = length(string(nn))
    A = lpad.(A, digitsLength, " ") # for working properly with n > 4


    header = "+" * prod(["-"^(digitsLength * n + n + 1) * "+" for _ ∈ 1:n])
    println(header)

    # print every line 
    for i ∈ 1:nn
        to_print = "" 
        for j ∈ 1:nn
            if j == 1
                to_print *= "| " * A[i, j] * " "
            else
                to_print *= A[i, j] * " "
            end
            if j % n == 0
                to_print *= "| "
            end
        end
        println(to_print)
        if i % n == 0
            println(header)
        end
    end
    nothing
end
