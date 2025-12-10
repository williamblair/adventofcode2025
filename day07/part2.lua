function gridIdx(grid, row, col)
    return grid[row]:sub(col, col)
end

function insertChar(str, idx, val)
    return str:sub(1, idx - 1) .. val .. str:sub(idx + 1)
end

function getPathCount(grid)
    local nRows = #grid
    local nCols = grid[1]:len()
    print("nRows,nCols:", nRows, nCols)

    -- find starting S
    local startCol = 1
    while gridIdx(grid, 1, startCol) ~= "S" do
        startCol = startCol + 1
    end
    grid[1] = insertChar(grid[1], startCol, "^")
    print("Start col:", startCol)

    counts = {}
    for i = 1, nCols do
        counts[i] = 0
    end
    counts[startCol] = 1

    for row = 1, nRows do
        for col = 1, nCols do
            if (gridIdx(grid, row, col) == "^") then
                counts[col - 1] = counts[col - 1] + counts[col]
                counts[col + 1] = counts[col + 1] + counts[col]
                counts[col] = 0
            end
        end
    end

    local sum = 0
    for i = 1, nCols do
        sum = sum + counts[i]
    end
    return sum
end

testGrid = {
".......S.......",
"...............",
".......^.......",
"...............",
"......^.^......",
"...............",
".....^.^.^.....",
"...............",
"....^.^...^....",
"...............",
"...^.^...^.^...",
"...............",
"..^...^.....^..",
"...............",
".^.^.^.^.^...^.",
"..............."
}
if getPathCount(testGrid) ~= 40 then
    print("Unexpected test split count")
    return
else
    print("Test split count passed")
end

if (arg[1] == nil) then
    print("Usage: part2.lua <infile>")
    return
end

inFile = io.open(arg[1], "r")
inputStrs = {}
for line in inFile:lines() do
    table.insert(inputStrs, line)
end
print("Split Count:", getPathCount(inputStrs))

