function getTotalFreshCount(ranges) do
    fresh = {}
    for idx, range in ipairs(ranges) do
        for i = 
    end
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
    testRanges[idx] = {}
    testRanges[idx][0] = beginVal
    testRanges[idx][1] = endVal
end

--inRangeFile = io.open(arg[1], "r")
--inRanges = {}
--idx = 0
--for line in inRangeFile:lines() do
--    local beginStr, endStr = line:match("(.+)-(.+)")
--    local beginVal = tonumber(beginStr)
--    local endVal = tonumber(endStr)
--    inRanges[idx] = {}
--    inRanges[idx][0] = beginVal
--    inRanges[idx][1] = endVal
--    idx = idx + 1
--end

print("Fresh count:",getFreshCount(inRanges, inIngredients))

