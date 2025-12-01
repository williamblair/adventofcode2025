-- day02.lua

function calcPassword(seqArr)
    local dialPos = 50
    local totalNumPos = 100
    local hitZeroCount = 0
    for idx, str in ipairs(seqArr) do
        --print(str)
        local dir = str:sub(1,1)
        --print(dir)
        local amnt = tonumber(str:sub(2))
        --print(amnt)
        if (dir == "L") then
            for i = 1, amnt, 1 do
                dialPos = dialPos - 1
                if (dialPos < 0) then
                    dialPos = totalNumPos - 1
                end
                if (dialPos == 0) then
                    hitZeroCount = hitZeroCount + 1
                end
            end
        else -- "R"
            for i = 1, amnt, 1 do
                dialPos = dialPos + 1
                if (dialPos >= totalNumPos) then
                    dialPos = 0
                end
                if (dialPos == 0) then
                    hitZeroCount = hitZeroCount + 1
                end
            end
        end
    end
    return hitZeroCount
end

testSeq = {
"L68",
"L30",
"R48",
"L5",
"R60",
"L55",
"L1",
"L99",
"R14",
"L82"
}

testSeqRes = calcPassword(testSeq)
if (testSeqRes ~= 6) then
    print("Test seq failed, result:", testSeqRes)
    return
end

if (arg[1] == nil) then
    print("Usage: day01.lua <infile>")
    return
end

inFile = io.open(arg[1], "r")
inputStrs = {}
for line in inFile:lines() do
    table.insert(inputStrs, line)
end
passwordRes = calcPassword(inputStrs)
print("Password res:", passwordRes)
