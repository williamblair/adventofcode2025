function gridIdx(grid, row, col)
    return grid[row]:sub(col, col)
end

function insertChar(str, idx, val)
    return str:sub(1, idx - 1) .. val .. str:sub(idx + 1)
end

function getSplitCount(grid)
    local splitCount = 0
    local nRows = #grid
    local nCols = grid[1]:len()
    print("nRows,nCols:", nRows, nCols)

    -- find starting S
    local startCol = 1
    while gridIdx(grid, 1, startCol) ~= "S" do
        startCol = startCol + 1
    end
    print("Start col:", startCol)

    -- initial tachyon
    grid[2] = insertChar(grid[2], startCol, "|")

    -- process all rows
    for row = 3, nRows do
        for col = 1, nCols do
            if gridIdx(grid, row, col) == "^" then
                if (row - 1 >= 1) and (gridIdx(grid, row - 1, col) == "|") then
                    splitCount = splitCount + 1
                    grid[row] = insertChar(grid[row], col - 1, "|")
                    grid[row] = insertChar(grid[row], col + 1, "|")
                end
            elseif (gridIdx(grid, row, col) == ".") and (gridIdx(grid, row - 1, col) == "|") then
                grid[row] = insertChar(grid[row], col, "|")
            end
        end
    end

    for idx, row in ipairs(grid) do
    print(row)
    end

    return splitCount
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
if getSplitCount(testGrid) ~= 21 then
    print("Unexpected test split count")
    return
else
    print("Test split count passed")
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
print("Split Count:",getSplitCount(inputStrs))

