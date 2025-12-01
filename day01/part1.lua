-- day01.lua

function calcPassword(seqArr)
    local dialPos = 50
    local totalNumPos = 100
    local zeroCount = 0
    for idx, str in ipairs(seqArr) do
        --print(str)
        local dir = str:sub(1,1)
        --print(dir)
        local amnt = tonumber(str:sub(2))
        --print(amnt)
        if (dir == "L") then
            dialPos = dialPos - amnt
            while dialPos < 0 do
                dialPos = dialPos + totalNumPos
            end
        else -- "R"
            dialPos = dialPos + amnt
            while dialPos >= totalNumPos do
                dialPos = dialPos - totalNumPos
            end
        end
        if (dialPos == 0) then
            zeroCount = zeroCount + 1
        end
    end
    return zeroCount
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
if (testSeqRes ~= 3) then
    print("Test seq failed, result: ", testSeqRes)
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
