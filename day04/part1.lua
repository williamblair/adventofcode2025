function gridElem(grid, row, col)
    return grid[row]:sub(col, col)
end

function isRollAccessible(rollGrid, row, col)
    local nRows = #rollGrid
    local nCols = rollGrid[1]:len()
    local neighborCount = 0
    for curRow = row - 1, row + 1, 1 do
        if (curRow >= 1 and curRow <= nRows) then
            for curCol = col - 1, col + 1, 1 do
                if (curCol >= 1 and curCol <= nCols) then
                    if (curCol ~= col or curRow ~= row) then
                        if (gridElem(rollGrid, curRow, curCol) == "@") then
                            neighborCount = neighborCount + 1
                        end
                    end
                end
            end
        end
    end
    return (neighborCount < 4)
end

function getTotalRollCount(rollGrid)
    local sum = 0
    local nRows = #rollGrid
    local nCols = rollGrid[1]:len()
    for row = 1, nRows, 1 do
        for col = 1, nCols, 1 do
            if (gridElem(rollGrid, row, col) == "@") then
                if (isRollAccessible(rollGrid, row, col)) then
                    sum = sum + 1
                end
            end
        end
    end
    return sum
end

testRolls = {
    "..@@.@@@@.",
    "@@@.@.@.@@",
    "@@@@@.@.@@",
    "@.@@@@..@.",
    "@@.@@@@.@@",
    ".@@@@@@@.@",
    ".@.@.@.@@@",
    "@.@@@.@@@@",
    ".@@@@@@@@.",
    "@.@.@@@.@."
}
if (getTotalRollCount(testRolls) ~= 13) then
    print("Unexpected roll count")
else
    print("Roll count passed")
end

if (arg[1] == nil) then
    print("Usage: part1.lua <infile>")
    return
end

inFile = io.open(arg[1], "r")
inGrid = {}
for line in inFile:lines() do
    table.insert(inGrid, line)
end
rollCount = getTotalRollCount(inGrid)
print("roll count:", rollCount)

