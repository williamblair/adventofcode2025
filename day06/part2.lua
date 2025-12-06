function strIdx(strs, row, col)
    return strs[row]:sub(col,col)
end

function getTotalHomeworkCount(strs)
    local totalSum = 0
    local nRows = #strs
    local nCols = strs[1]:len()

    local curCol = nCols
    while (strIdx(strs, nRows, curCol) == " ") do
        curCol = curCol - 1
    end

    local tmpCol = nCols
    while (curCol >= 1) do
        nums = {}
        while (tmpCol >= curCol) do
            local multiplier = 1
            local val = 0
            local hasVal = false
            local row = nRows - 1
            while (row >= 1 and strIdx(strs, row, tmpCol) == " ") do
                row = row - 1
            end
            for row = row, 1, -1 do
                if (strIdx(strs, row, tmpCol) == " ") then
                    break
                end
                val = val + tonumber(strIdx(strs, row, tmpCol)) * multiplier
                multiplier = multiplier * 10
                hasVal = true
            end
            if (hasVal) then
                table.insert(nums, val)
            end
            tmpCol = tmpCol - 1
        end
        if (strIdx(strs, nRows, curCol) == "+") then
            local sum = 0
            for idx, val in ipairs(nums) do
                sum = sum + val
            end
            totalSum = totalSum + sum
        elseif (strIdx(strs, nRows, curCol) == "*") then
            local prod = 1
            for idx, val in ipairs(nums) do
                prod = prod * val
            end
            totalSum = totalSum + prod
        else
            print("Unexpected operator!")
            return 0
        end

        curCol = curCol - 1
        while (strIdx(strs, nRows, curCol) == " ") do
            curCol = curCol - 1
        end
    end
    return totalSum
end

testStrs = {
"123 328  51 64 ",
" 45 64  387 23 ",
"  6 98  215 314",
"*   +   *   +  "
}
if (getTotalHomeworkCount(testStrs) ~= 3263827) then
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

