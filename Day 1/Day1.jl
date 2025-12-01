using FileIO

data = readlines("input.txt")

moves = map(d -> d[1] == 'R' ? 1 : -1, data) .* map(d -> tryparse(Int,d[2:end]),data)

global cnt = 0
global pos = 50
for move in moves
    global pos = mod(move+pos,100)
    global cnt += pos == 0 ? 1 : 0
end
cnt

cnt = 0
pos = 50

for move in moves
    abs_pos = move + pos
    cnt += ((sign(abs_pos) > 0 || pos == 0) ? 0 : 1) + abs(div(abs_pos,100))
    pos = mod(abs_pos,100)
end
cnt