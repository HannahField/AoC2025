using FileIO

data = readlines("input.txt")
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

operator_locations = findall(x -> x == '*' || x == '+',data[end])

col_indeces = map(i -> range(operator_locations[i],operator_locations[i+1]-2),1:(length(operator_locations)-1));
push!(col_indeces,range(operator_locations[end],length(data[1])));
matrix_chars = mapreduce(permutedims, vcat, map(d -> collect(d),data[1:end-1]));
matrix_cols = map(r -> matrix_chars[:,r],col_indeces);
shuffled_vals = map(col -> tryparse.(Int,map(i -> string(col[:,i]...),1:size(col)[2])),matrix_cols);

println(sum(apply.(shuffled_vals,operators)))