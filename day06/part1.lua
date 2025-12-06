function getTotalHomeworkCount(strs)
    local lineArrs = {}
    for idx, str in ipairs(strs) do
        local els = {}
        for s in string.gmatch(str, "%S+") do
            table.insert(els, s)
        end
        table.insert(lineArrs, els)
    end
    local nRows = #lineArrs
    local nCols = 1
    while lineArrs[1][nCols] ~= nil do
        nCols = nCols + 1
    end
    nCols = nCols - 1
    local sum = 0
    for col = 1, nCols do
        local op = lineArrs[nRows][col]
        if (op == "*") then
            local colProd = 1
            for row = 1, nRows - 1 do
                colProd = colProd * tonumber(lineArrs[row][col])
            end
            sum = sum + colProd
        elseif (op == "+") then
            local colSum = 0
            for row = 1, nRows - 1 do
                colSum = colSum + tonumber(lineArrs[row][col])
            end
            sum = sum + colSum
        end
    end
    return sum
end

testStrs = {
"123 328  51 64 ",
" 45 64  387 23 ",
"  6 98  215 314",
"*   +   *   +  "
}
if (getTotalHomeworkCount(testStrs) ~= 4277556) then
    print("Unexpected total homework count")
    return
else
    print("Test homework count passed")
end

if (arg[1] == nil) then
    print("Usage: part1.lua <infile>")
    return
end

inFile = io.open(arg[1], "r")
inputStrs = {}
for line in inFile:lines() do
    table.insert(inputStrs, line)
end
print("Homework total:",getTotalHomeworkCount(inputStrs))

