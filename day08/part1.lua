function getPositions(strPositions)
    local positions = {}
    for idx, str in ipairs(strPositions) do
        local xPos, yPos, zPos = str:match("(.+),(.+),(.+)")
        local pos = {}
        pos[1] = tonumber(xPos)
        pos[2] = tonumber(yPos)
        pos[3] = tonumber(zPos)
        positions[idx] = pos
    end
    return positions
end

function distSqr(posA, posB)
    return 
        (posA[1] - posB[1]) * (posA[1] - posB[1]) +
        (posA[2] - posB[2]) * (posA[2] - posB[2]) +
        (posA[3] - posB[3]) * (posA[3] - posB[3])
end

function getClosestIdxs(positions, connMap)
    local minDist = distSqr(positions[1], positions[2])
    local minIdxA = 1
    local minIdxB = 2
    for i = 1, #positions - 1 do
        for j = i + 1, #positions do
            local dist = distSqr(positions[i], positions[j])
            if dist < minDist and connMap[i][j] == nil then
                minDist = dist
                minIdxA = i
                minIdxB = j
            end
        end
    end
    return minIdxA, minIdxB
end

function findContainingCircuits(circuits, posIdxA, posIdxB)
    local containingCircs = {}
    for i = 1, #circuits do
        if circuits[i][posIdxA] ~= nil or circuits[i][posIdxB] ~= nil then
            table.insert(containingCircs, i)
        end
    end
    return containingCircs
end

function getCircuitsProduct(strPositions, numIter)
    local positions = getPositions(strPositions)
    local circuits = {}
    local connMap = {}
    for i = 1, #positions do
        connMap[i] = {}
    end

    for iter = 1, numIter do
        minIdxA, minIdxB = getClosestIdxs(positions, connMap)
        connMap[minIdxA][minIdxB] = true
        connMap[minIdxB][minIdxA] = true
        local containingCircs = findContainingCircuits(circuits, minIdxA, minIdxB)
        if #containingCircs == 0 then
            local newCircuit = {}
            newCircuit[minIdxA] = true
            newCircuit[minIdxB] = true
            table.insert(circuits, newCircuit)
        else
            if #containingCircs == 1 then
                for _, idx in ipairs(containingCircs) do
                    circuits[idx][minIdxA] = true
                    circuits[idx][minIdxB] = true
                end
            else
                local newCircuit = {}
                local numRemoved = 0
                for _, circIdx in ipairs(containingCircs) do
                    for posIdx, trueVal in pairs(circuits[circIdx - numRemoved]) do
                        newCircuit[posIdx] = true
                    end
                    table.remove(circuits, circIdx - numRemoved)
                    numRemoved = numRemoved + 1
                end
                newCircuit[minIdxA] = true
                newCircuit[minIdxB] = true
                table.insert(circuits, newCircuit)
            end
        end
    end
    local circuitLengths = {}
    for idx, circ in ipairs(circuits) do
        local elemCount = 0
        for _, __ in pairs(circ) do
            elemCount = elemCount + 1
        end
        circuitLengths[idx] = elemCount
    end
    table.sort(circuitLengths, function(a,b) return a > b end)
    return circuitLengths[1] * circuitLengths[2] * circuitLengths[3]
end

testPositions = {
"162,817,812",
"57,618,57",
"906,360,560",
"592,479,940",
"352,342,300",
"466,668,158",
"542,29,236",
"431,825,988",
"739,650,466",
"52,470,668",
"216,146,977",
"819,987,18",
"117,168,530",
"805,96,715",
"346,949,466",
"970,615,88",
"941,993,340",
"862,61,35",
"984,92,344",
"425,690,689"
}
if getCircuitsProduct(testPositions, 10) ~= 40 then
    print("Unexpected test circuit product")
    return
else
    print("Test circuit product passed")
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
print("Circuit product:", getCircuitsProduct(inputStrs, 1000))

