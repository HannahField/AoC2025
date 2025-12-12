using FileIO
using DSP

data = stack(map(x -> tryparse.(Int,x),split.(replace.(replace.(readlines("input.txt"), "@" => "1"), "." => "0"),"")),dims=1)
conv_matrix = [1 1 1; 1 0 1; 1 1 1]


function remove_paper(x)
    neighbors = conv(x,conv_matrix)[2:end-1,2:end-1]
    to_remove = map(i -> x[i] == 0 ? 0 : (neighbors[i] < 4 ? 1 : 0),CartesianIndices(size(data)))
    return x - to_remove
end

# part 1

removed_cnt = sum(data) - sum(remove_paper(data))


# part 2

current_warehouse = data
while(true)
    next_warehouse = remove_paper(current_warehouse)
    if (next_warehouse == current_warehouse)
        break
    else
        global current_warehouse = next_warehouse
    end
end
removed_cnt = sum(data) - sum(current_warehouse)