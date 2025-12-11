#include <iostream>
#include <fstream>
#include <string>
#include <cstdint>
#include <cstring>
#include <vector>

struct Pos {
    int x;
    int y;
};

static inline int ABS(const int val) {
    return (val < 0 ? -val : val);
}

uint64_t getArea(const Pos& posA, const Pos& posB) {
    return
        uint64_t(ABS(posA.x - posB.x) + 1) *
        uint64_t(ABS(posA.y - posB.y) + 1);
}

std::vector<Pos> getPositions(const std::vector<std::string>& posStrs) {
    std::vector<Pos> positions;
    for (const std::string& str : posStrs) {
        Pos newPos;
        sscanf(str.c_str(), "%d,%d", &newPos.x, &newPos.y);
        positions.push_back(newPos);
    }
    return positions;
}

uint8_t* getInitialGrid(
        const std::vector<Pos>& positions,
        int& resMinX, int& resMinY,
        int& resNRows, int& resNCols) {
    int minX = positions[0].x;
    int minY = positions[0].y;
    int maxX = positions[0].x;
    int maxY = positions[0].y;
    for (const Pos& pos : positions) {
        if (pos.x < minX) { minX = pos.x; }
        if (pos.x > maxX) { maxX = pos.x; }
        if (pos.y > maxY) { maxY = pos.y; }
        if (pos.y < minY) { minY = pos.y; }
    }
    int nRows = maxY - minY + 1;
    int nCols = maxX - minX + 1;
    std::cout << "nRows, nCols:" << nRows << " " << nCols << std::endl;
    uint8_t* pGrid = new uint8_t[uint64_t(nRows)*uint64_t(nCols)];
    if (!pGrid) {
        std::cout << "Failed to alloc grid" << std::endl;
        return nullptr;
    }
    memset(pGrid, 0, uint64_t(nRows)*uint64_t(nCols));
    for (const Pos& pos : positions) {
        uint64_t row = uint64_t(pos.y) - uint64_t(minY);
        uint64_t col = uint64_t(pos.x) - uint64_t(minX);
        pGrid[row*nCols + col] = 1;
    }
//    std::cout << "Initial grid: " << std::endl;
//    for (int row = 0; row < nRows; row++) {
//        for (int col = 0; col < nCols; col++) {
//            std::cout << (int)pGrid[uint64_t(row)*uint64_t(nCols) + uint64_t(col)];
//        }
//        std::cout << std::endl;
//    }
    resMinX = minX;
    resMinY = minY;
    resNRows = nRows;
    resNCols = nCols;
    return pGrid;
}

bool isAllRedOrGreen(uint8_t* pGrid, int nCols, int aX, int aY, int bX, int bY) {
    for (int row = std::min(aY, bY); row <= std::max(aY, bY); row++) {
        for (int col = std::min(aX, bX); col <= std::max(aX, bX); col++) {
            if (pGrid[uint64_t(row)*uint64_t(nCols) + col] != 1) {
                return false;
            }
        }
    }
    return true;
}

uint64_t getLargestArea(const std::vector<std::string>& posStrs) {
    std::vector<Pos> positions = getPositions(posStrs);
    int minX = 0, minY = 0;
    int nRows = 0, nCols = 0;
    uint8_t* pGrid = getInitialGrid(positions, minX, minY, nRows, nCols);

    // create outlined positions
    for (int i = 0; i < (int)positions.size() - 1; i++) {
        const Pos& posA = positions[i];
        const Pos& posB = positions[i+1];
        int aX = posA.x - minX;
        int aY = posA.y - minY;
        int bX = posB.x - minX;
        int bY = posB.y - minY;
        if (aX == bX) {
            for (int y = std::min(aY, bY); y <= std::max(aY, bY); y++) {
                pGrid[uint64_t(y)*uint64_t(nCols) + aX] = 1;
            }
        }
        else if (aY == bY) {
            for (int x = std::min(aX, bX); x <= std::max(aX, bX); x++) {
                pGrid[uint64_t(aY)*uint64_t(nCols) + x] = 1;
            }
        }
        else {
            std::cout << "aX != bX || aY != bY!!!" << std::endl;
            delete[] pGrid;
            return 0;
        }
    }

    // connect end to beginning
    {
        const Pos& posA = positions[positions.size()-1];
        const Pos& posB = positions[0];
        int aX = posA.x - minX;
        int aY = posA.y - minY;
        int bX = posB.x - minX;
        int bY = posB.y - minY;
        if (aX == bX) {
            for (int y = std::min(aY, bY); y <= std::max(aY, bY); y++) {
                pGrid[uint64_t(y)*uint64_t(nCols) + aX] = 1;
            }
        }
        else if (aY == bY) {
            for (int x = std::min(aX, bX); x <= std::max(aX, bX); x++) {
                pGrid[uint64_t(aY)*uint64_t(nCols) + x] = 1;
            }
        }
        else {
            std::cout << "aX != bX || aY != bY!!!" << std::endl;
            delete[] pGrid;
            return 0;
        }
    }

//    std::cout << "Outlined grid: " << std::endl;
//    for (int row = 0; row < nRows; row++) {
//        for (int col = 0; col < nCols; col++) {
//            std::cout << (int)pGrid[uint64_t(row)*uint64_t(nCols) + col];
//        }
//        std::cout << std::endl;
//    }

    // fill in grid
    for (int row = 0; row < nRows; row++) {
        bool isFilling = false;
        for (int col = 0; col < nCols; col++) {
            if (!isFilling) {
                if ((pGrid[uint64_t(row)*uint64_t(nCols)+col] == 1) &&
                        (col < nCols - 1) &&
                        (pGrid[uint64_t(row)*uint64_t(nCols) + col + 1] == 0)) {
                    isFilling = true;
                }
            }
            else {
                if (pGrid[uint64_t(row)*uint64_t(nCols)+col] == 1) {
                    isFilling = false;
                }
                else {
                    pGrid[uint64_t(row)*uint64_t(nCols)+col] = 1;
                }
            }
        }
    }

//    std::cout << "Filled grid: " << std::endl;
//    for (int row = 0; row < nRows; row++) {
//        for (int col = 0; col < nCols; col++) {
//            std::cout << (int)pGrid[uint64_t(row)*uint64_t(nCols) + col];
//        }
//        std::cout << std::endl;
//    }

    uint64_t maxArea = 0;
    for (int i = 0; i < positions.size() - 1; i++) {
        for (int j = i + 1; j < positions.size(); j++) {
            const Pos& posA = positions[i];
            const Pos& posB = positions[j];
            uint64_t area = getArea(posA, posB);
            if (area > maxArea) {
                int aX = posA.x - minX;
                int aY = posA.y - minY;
                int bX = posB.x - minX;
                int bY = posB.y - minY;
                if (isAllRedOrGreen(pGrid, nCols, aX, aY, bX, bY)) {
                    std::cout << "Largest area at " << posA.x << " "
                        << posA.y << " "
                        << posB.x << " "
                        << posB.y << std::endl;
                    maxArea = area;
                }
            }
        }
    }

    delete[] pGrid;
    return maxArea;
}

int main(int argc, char* argv[]) {
    std::vector<std::string> testStrs = {
        "7,1",
        "11,1",
        "11,7",
        "9,7",
        "9,5",
        "2,5",
        "2,3",
        "7,3"
    };
    if (getLargestArea(testStrs) != 24) {
        std::cout << "Unexpected largest area" << std::endl;
        return 1;
    }
    std::cout << "Test largest area passed" << std::endl;

    if (argc != 2) {
        std::cout << "Usage: " << argv[0] << " <input txt>" << std::endl;
        return 1;
    }

    std::ifstream inFile(argv[1]);
    std::string curLine = "";
    std::vector<std::string> inputStrs;
    while (std::getline(inFile, curLine)) {
        inputStrs.push_back(curLine);
    }
    inFile.close();

    std::cout << "Largest area: " << getLargestArea(inputStrs) << std::endl;

    return 0;
}

