using FileIO
using Primes

data = split.(split(readline("input.txt"),","),"-")
ranges = map(d -> collect(range(tryparse(Int,d[1]),tryparse(Int,d[2]))),data)
vals = vcat(ranges...)
# Part 1

function filt(x)
    amount_of_digits = length(string(x))
    if (amount_of_digits % 2 == 1)
        return 0
    elseif (mod(x,10^(Int(amount_of_digits/2))) == div(x,10^(Int(amount_of_digits/2))))
        return x
    end
    return 0
end
sums = sum(filt.(vals))

# Part 2, stupid edition
function filt_2(x)
    if (occursin(r"^(.+)\1+$",string(x)))
        return x
    else
        return 0
    end
end

sums = sum(filt_2.(vals))