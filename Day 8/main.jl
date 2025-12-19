@time begin
    positions = map(r -> parse.(Int, r), split.(readlines("input.txt"), ","))

    # part 1
    sq_dist(r1, r2) = (r1 == r2) ? 2^31 : (sum((r1 - r2) .^ 2))

    N = 1000
    struct edge
        i::Int
        j::Int
        d::Int
    end


    function networking(networks, current_edge)

        ns = findall(n -> in(current_edge.i, n) || in(current_edge.j, n), networks)
        if (isempty(ns))
            push!(networks, [current_edge.i, current_edge.j])

        elseif (length(ns) == 1)
            append!(networks[ns[1]], [current_edge.i, current_edge.j])

        elseif (length(ns) == 2)
            append!(networks[ns[1]], [current_edge.i, current_edge.j])
            append!(networks[ns[1]], networks[ns[2]])
            deleteat!(networks, ns[2])

        else
            println(current_edge)
            println(ns)
            for n in ns
                println(networks[n])
            end
        end
        unique!.(networks)
    end


    all_edges = vcat(map(i -> map(j -> edge(i, j, sq_dist(positions[i], positions[j])), eachindex(positions)), eachindex(positions))...)

    # 2N because I'm double counting edges (should be unordered pairs, but I generate ordered pairs)
    min_edges = sort(sort(all_edges, by=x -> x.d)[1:2N], by=x -> x.i)

    n1 = []


    for current_edge in min_edges
        networking(n1, current_edge)
    end
    sorted_networks = sort.(reverse(sort(unique.(n1), by=x -> length(x))))

    println(prod(length.(sorted_networks[1:3])))

    # part 2


    n2 = []

    sorted_edges = sort(all_edges, by=x -> x.d)
    networking(n2, sorted_edges[1])
    i = 2
    while (length(n2[1]) < N)
        networking(n2, sorted_edges[i])
        global i += 1
    end
    edge1 = sorted_edges[i].i
    edge2 = sorted_edges[i].j
    println(positions[edge1][1] * positions[edge2][1])
end