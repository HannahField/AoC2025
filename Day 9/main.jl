tiles = map(x -> parse.(Int, x), split.(readlines("test_input.txt"), ","))

area(c1, c2) = abs((c1[1] - c2[1] + 1) * (c1[2] - c2[2] + 1))

# part 1

struct rect
    i::Int
    j::Int
    A::Int
end

rects = vcat(map(i -> map(j -> rect(i, j, area(tiles[i], tiles[j])), eachindex(tiles)), eachindex(tiles))...)

max_rect = argmax(x -> x.A, rects)

# part 2

