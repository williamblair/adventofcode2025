function isValidId(idStr)
    local strLen = idStr:len()
    for dupLen = 1, strLen / 2, 1 do
        if (strLen % dupLen == 0) then        
            local patternStr = idStr:sub(1, dupLen)
            local allMatch = true
            for i = dupLen + 1, strLen, dupLen do
                local testStr = idStr:sub(i, i + dupLen - 1)
                if (testStr ~= patternStr) then
                    allMatch = false
                    break
                end
            end
            if (allMatch) then
                return false
            end
        end
    end
    return true
end

function getInvalidIdsSum(rangeStr)
    local beginStr, endStr = rangeStr:match("(.+)-(.+)")
    local beginVal = tonumber(beginStr)
    local endVal = tonumber(endStr)
    local invalidIdSum = 0
    for i = beginVal, endVal, 1 do
        local idStr = tostring(i)
        if (not isValidId(idStr)) then
            invalidIdSum = invalidIdSum + i
        end
    end
    return invalidIdSum
end

function getIdRanges(inStr)
    ranges = {}
    local curRange = ""
    local endId = ""
    local gettingBegin = true
    for i = 1, inStr:len(), 1 do
        if (i == inStr:len()) then
            curRange = curRange .. inStr:sub(i,i)
            table.insert(ranges, curRange)
        elseif (inStr:sub(i,i) == ",") then
            table.insert(ranges, curRange)
            curRange = ""
        else
            curRange = curRange .. inStr:sub(i,i)
        end
    end
    return ranges
end

function getRangesSum(ranges)
    local sum = 0
    for idx, range in ipairs(ranges) do
        sum = sum + getInvalidIdsSum(range)
    end
    return sum
end

ranges = getIdRanges("11-22,95-115,998-1012,1188511880-1188511890,222220-222224,"..
"1698522-1698528,446443-446449,38593856-38593862,565653-565659,"..
"824824821-824824827,2121212118-2121212124")
local rangesSum = getRangesSum(ranges)
if (rangesSum ~= 4174379265) then
    print("Test ranges sum failed")
    return
end

if (arg[1] == nil) then
    print("Usage: day01.lua <infile>")
    return
end

inFile = io.open(arg[1], "r")
inStr = inFile:read()
ranges = getIdRanges(inStr)
print("Invalid id sum:", getRangesSum(ranges))

