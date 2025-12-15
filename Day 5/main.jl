using FileIO

data = readlines("input.txt")
splitting_index = findfirst(x -> x == "", data)
ranges = map(y -> range(y[1], y[2]), map(x -> tryparse.(Int, x), split.(data[1:(splitting_index-1)], "-")))
values = tryparse.(Int, data[(splitting_index+1:end)])


# part 1
sum(map(val -> any(val .∈ ranges), values))

# part 2

sorted_ranges = sort(ranges, by=x -> x[1])

function range_changer(r1, r2)
    if (r1 ⊆ r2)
        return [r2]
    elseif (r2 ⊆ r1)
        return [r1]
    elseif (r1[end] >= r2[1])
        return [range(r1[1], r2[1] - 1), r2]
    else
        return [r1, r2]
    end
end


function range_reducer(rs)
    reduced_ranges = []
    current = range_changer(rs[1], rs[2])
    for i in 3:length(rs)
        println(current)
        if (length(current) == 2)
            push!(reduced_ranges, current[1])
        end
        current = range_changer(current[end], rs[i])
    end
    push!(reduced_ranges,current[1])
    if (length(current)==2)
        push!(reduced_ranges,current[2])
    end
    return reduced_ranges
end


println(range_reducer(sorted_ranges))