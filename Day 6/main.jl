using FileIO

data = readlines("test_input.txt")
vals = hcat(map(z -> tryparse.(Int,z), map(x -> filter(y -> y != "",x),split.(data[1:end-1])))...)'
operators = filter(x -> x != "",split(data[end]," "))

# part 1

function apply(col,operator)
    if (operator == "+")
        return sum(col)
    else
        return prod(col)
    end
end
println(sum(map(i -> apply(vals[:,i],operators[i]),1:size(vals)[2])))

# part 2

