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

function getTotalRemoveCount(rollGrid)
    local sum = 0
    local nRows = #rollGrid
    local nCols = rollGrid[1]:len()
    local didRemove = true
    while (didRemove) do
        local newGrid = {}
        didRemove = false
        for row = 1, nRows, 1 do
            local newRow = ""
            for col = 1, nCols, 1 do
                if (gridElem(rollGrid, row, col) == "@" and
                        isRollAccessible(rollGrid, row, col)) then
                    newRow = newRow .. "."
                    didRemove = true
                    sum = sum + 1
                else
                    newRow = newRow .. gridElem(rollGrid, row, col)
                end
            end
            table.insert(newGrid, newRow)
        end
        rollGrid = newGrid
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
local testRemoveCount = getTotalRemoveCount(testRolls)
if (testRemoveCount ~= 43) then
    print("Unexpected roll count:",testRemoveCount)
else
    print("Roll count passed")
end

if (arg[1] == nil) then
    print("Usage: part2.lua <infile>")
    return
end

inFile = io.open(arg[1], "r")
inGrid = {}
for line in inFile:lines() do
    table.insert(inGrid, line)
end
rollCount = getTotalRemoveCount(inGrid)
print("remove count:", rollCount)

