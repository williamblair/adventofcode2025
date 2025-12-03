function getMaxBankJolt(bankStr)
    local maxJolt = 0
    for i = 1, bankStr:len() - 1, 1 do
        local numA = 10 * tonumber(bankStr:sub(i,i))
        for j = i + 1, bankStr:len(), 1 do
            local numB = tonumber(bankStr:sub(j,j))
            local jolt = numA + numB
            if jolt > maxJolt then
                maxJolt = jolt
            end
        end
    end
    return maxJolt
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
if (getMaxBankJoltSum(testBanks) ~= 357) then
    print("Unexpected bank jolt sum")
else
    print("Bank jolt sum passed")
end

if (arg[1] == nil) then
    print("Usage: part1.lua <infile>")
    return
end

inFile = io.open(arg[1], "r")
inBanks = {}
for line in inFile:lines() do
    table.insert(inBanks, line)
end
joltSum = getMaxBankJoltSum(inBanks)
print("jolt sum:",joltSum)

