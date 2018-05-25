export sudoku_print, sudoku_strings

_blank = "."  # this is the character used for 0s in a Sudoku puzzle

_form1(a::Int) =  a > 0 ? "$a" : _blank

function _form3(r::Vector)
    result = " "
    for k=1:3
        a = r[k]
        result *=  _form1(a) * " "
    end
    result *= "|"
    return result
end

_format_line(r::Vector) = "|" * _form3(r[1:3]) * _form3(r[4:6]) * _form3(r[7:9])


"""
`sudoku_strings(A)` is a helper function for `sudoku_print`. It creates an
array of 13 `String` objects containing the separator rows and formatted
matrix rows. Perhaps useful for writing a Sudoku board to a file.
"""
function sudoku_strings(A::Matrix)
    horiz_piece = "-------+"
    sep_line = "+" * (horiz_piece)^3

    result = Vector{String}()
    push!(result, sep_line)

    for i=1:9
        push!(result, _format_line(A[i,:]))
        if mod(i,3) == 0
            push!(result,sep_line)
        end
    end
    return result
end


"""
`sudoku_print(A)` prints the Sudoku board `A` in an attractive manner.
"""
function sudoku_print(A::Matrix)
    for t in sudoku_strings(A)
        println(t)
    end
    nothing
end
