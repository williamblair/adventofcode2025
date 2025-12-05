function isFresh(freshRanges, ingredient)
  for idx, range in ipairs(freshRanges) do
      if (ingredient >= range[0] and ingredient <= range[1]) then
          return true
      end
  end
  return false
end

function getFreshCount(freshRanges, ingredients)
  local sum = 0
  for idx, ingredient in ipairs(ingredients) do
      if isFresh(freshRanges, ingredient) then
          sum = sum + 1
      end
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
    testRanges[idx] = {}
    testRanges[idx][0] = beginVal
    testRanges[idx][1] = endVal
end
testIngredients = {1, 5, 8, 11, 17, 32}
if (getFreshCount(testRanges, testIngredients) ~= 3) then
    print("Unexpected fresh count")
else
    print("Fresh count passed")
end

if (arg[1] == nil or arg[2] == nil) then
    print("Usage: part1.lua <rangefile> <ingredientfile>")
    return
end

inRangeFile = io.open(arg[1], "r")
inRanges = {}
idx = 0
for line in inRangeFile:lines() do
    local beginStr, endStr = line:match("(.+)-(.+)")
    local beginVal = tonumber(beginStr)
    local endVal = tonumber(endStr)
    inRanges[idx] = {}
    inRanges[idx][0] = beginVal
    inRanges[idx][1] = endVal
    idx = idx + 1
end

inIngredientFile = io.open(arg[2], "r")
inIngredients = {}
idx = 0
for line in inIngredientFile:lines() do
    local val = tonumber(line)
    inIngredients[idx] = val
    idx = idx + 1
end

print("Fresh count:",getFreshCount(inRanges, inIngredients))

