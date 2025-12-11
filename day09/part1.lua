function getArea(posA, posB)
    return (math.abs(posA[1] - posB[1]) + 1) * (math.abs(posA[2] - posB[2]) + 1)
end

function getLargestArea(posStrs)
    local positions = {}
    for idx, str in ipairs(posStrs) do
        local xPosStr, yPosStr = str:match("(.+),(.+)")
        local newPos = {}
        newPos[1] = tonumber(xPosStr)
        newPos[2] = tonumber(yPosStr)
        table.insert(positions, newPos)
    end

    local maxArea = 0
    local maxIdxA = 1
    local maxIdaB = 2
    for i = 1, #positions - 1 do
        for j = i + 1, #positions do
            local area = getArea(positions[i], positions[j])
            if area > maxArea then
                maxArea = area
                maxIdxA = i
                maxIdxB = j
            end
        end
    end
    print("Max area from ", positions[maxIdxA][1], positions[maxIdxA][2],
        positions[maxIdxB][1], positions[maxIdxB][2])
    return maxArea
end

testPositions = {
"7,1",
"11,1",
"11,7",
"9,7",
"9,5",
"2,5",
"2,3",
"7,3"
}
if getLargestArea(testPositions) ~= 50 then
    print("Unexpected test rect area")
    return
else
    print("Test rect area passed")
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
print("Rect area:", getLargestArea(inputStrs))

