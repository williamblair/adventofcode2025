function getMaxBankJolt(bankStr)
    local numDigits = 12
    local joltStr = ""
    local numRemain = numDigits
    local lastIdx = 0
    while (joltStr:len() ~= 12) do
        local startIdx = bankStr:len() - numRemain + 1
        local maxDigit = 0
        local curMaxIdx = 0
        for i = startIdx, lastIdx + 1, -1 do
            local curDigit = tonumber(bankStr:sub(i,i))
            if (curDigit >= maxDigit) then
                maxDigit = curDigit
                curMaxIdx = i
            end
        end
        joltStr = joltStr .. tostring(maxDigit)
        numRemain = numRemain - 1
        lastIdx = curMaxIdx
    end
    return tonumber(joltStr)
end

function getMaxBankJoltSum(bankStrArr)
    local sum = 0
    for idx, bankStr in ipairs(bankStrArr) do
        sum = sum + getMaxBankJolt(bankStr)
    end
    return sum
end

testBanks = {
    "987654321111111",
    "811111111111119",
    "234234234234278",
    "818181911112111"
}
if (getMaxBankJoltSum(testBanks) ~= 3121910778619) then
    print("Unexpected bank jolt sum")
else
    print("Bank jolt sum passed")
end

if (arg[1] == nil) then
    print("Usage: part2.lua <infile>")
    return
end

inFile = io.open(arg[1], "r")
inBanks = {}
for line in inFile:lines() do
    table.insert(inBanks, line)
end
joltSum = getMaxBankJoltSum(inBanks)
print("jolt sum:",joltSum)

