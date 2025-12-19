using Memoize
data = permutedims(mapreduce(permutedims, vcat, collect.(readlines("input.txt"))), (2, 1))

# part 1
function propogate(col::Vector{T}, next_col::Vector{T}, cnt::Int)::Tuple{Vector{Char},Int} where T<:Char
    if !(isempty(findall(x -> x == 'S', col)))
        next_col[findfirst(x -> x == 'S', col)] = '|'
        return next_col, cnt
    end
    beams = findall(x -> x == '|', col)
    for beam in beams
        if (next_col[beam] == '^')
            next_col[beam+1] = '|'
            next_col[beam-1] = '|'
            cnt += 1
        else
            next_col[beam] = '|'
        end
    end
    return (next_col, cnt)
end

propped = deepcopy(data)
cnt_1 = 0
for i in 1:(size(data)[2]-1)
    tmp = propogate(propped[:, i], propped[:, i+1], cnt_1)
    propped[:, i+1] = tmp[1]
    global cnt_1 = tmp[2]
end

println(cnt_1)

# part 2
@time begin
    @memoize function explore(beam, data, index, max_depth)
        if (index == max_depth)
            return 1
        end
        cnt = 0
        index += 1
        if (data[beam, index] == '^')
            cnt += explore(beam + 1, data, index, max_depth)
            cnt += explore(beam - 1, data, index, max_depth)
        else
            cnt += explore(beam, data, index, max_depth)
        end
        return cnt
    end

    start_beam = findfirst(x -> x == 'S', data[:, 1])
    println(explore(start_beam, data, 1, 142))

end