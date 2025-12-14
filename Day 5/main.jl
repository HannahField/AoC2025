using FileIO

data = readlines("input.txt")
splitting_index = findfirst(x -> x == "",data)
ranges = map(y -> range(y[1],y[2]),map(x -> tryparse.(Int,x),split.(data[1:(splitting_index-1)],"-")))
values = tryparse.(Int,data[(splitting_index+1:end)])


# part 1
sum(map(val -> any(val .∈ ranges),values))

# part 2

sorted_ranges = sort(ranges, by = x-> x[1])

