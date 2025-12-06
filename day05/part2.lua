function overlaps(minA, maxA, minB, maxB)
    return minA <= maxB and minB <= maxA
end

function combineOverlappingRanges(ranges)
    local minA, maxA = next(ranges)
    while minA do
        local minB, maxB = next(ranges, minA)
        local tmpMinB, tmpMaxB = minB, maxB
        while (tmpMinB ~= nil and tmpMaxB ~= nil) do
            if (overlaps(minA, maxA, tmpMinB, tmpMaxB)) then
                ranges[minA] = nil
                ranges[tmpMinB] = nil
                ranges[math.min(minA,tmpMinB)] = math.max(maxA,tmpMaxB)
                return true
            end
            tmpMinB, tmpMaxB = next(ranges, tmpMinB)
        end
        minA, maxA = minB, maxB
    end
    return false
end

function getTotalFreshCount(ranges)
    local didCombine = true
    while (didCombine) do
        didCombine = combineOverlappingRanges(ranges)
    end
    local sum = 0
    for min, max in pairs(ranges) do
        sum = sum + (max - min) + 1
    end
    return sum
end

testRangesStrs = {
    "3-5",
    "10-14",
    "16-20",
    "12-18"
}
testRanges = {}
for idx, rangeStr in ipairs(testRangesStrs) do
    local beginStr, endStr = rangeStr:match("(.+)-(.+)")
    local beginVal = tonumber(beginStr)
    local endVal = tonumber(endStr)
    testRanges[beginVal] = endVal
end
local testCount = getTotalFreshCount(testRanges)
if (testCount ~= 14) then
    print("Total fresh count failed:", testCount)
    return
else
    print("Total fresh count passed")
end

if (arg[1] == nil) then
    print("Usage: part2.lua <rangefile>")
    return
end

inRangeFile = io.open(arg[1], "r")
inRanges = {}
for line in inRangeFile:lines() do
    local beginStr, endStr = line:match("(.+)-(.+)")
    local beginVal = tonumber(beginStr)
    local endVal = tonumber(endStr)
    inRanges[beginVal] = endVal
end

print("Fresh count:", getTotalFreshCount(inRanges))

