using FileIO

data = map(x -> tryparse.(Int,x), split.(readlines("input.txt"),""))

function part_1(bank)
    first_index = argmax(bank[1:end-1])
    second_index = argmax(bank[(first_index+1):end])
    return 10*bank[first_index] + bank[second_index+first_index]
end

bank_sum = sum(part_1.(data))

function part_2(bank,n::Int)
    indeces = zeros(Int,n)
    indeces[1] = argmax(bank[1:end-n+1])
    for index in 2:n
        indeces[index] = argmax(bank[(indeces[index-1]+1):end-n+index])+indeces[index-1]
    end
    vals = bank[indeces]
    return sum(10 .^((n-1):-1:0) .* vals)
end

bank_sum = sum(part_2.(data,12))
