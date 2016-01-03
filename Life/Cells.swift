
import Foundation

let NumColumns = 30
let NumRows = 60

class Cells {
    private var field = Array2D<Cell>(columns: NumColumns, rows: NumRows)

    func getCell(column: Int, row: Int) -> Cell? {
        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)
        return field[column, row]
    }

    func shuffle() -> Set<Cell> {
        return createInitialCells()
    }

/* Any live cell with fewer than two live neighbours dies, as if caused by under-population.
Any live cell with two or three live neighbours lives on to the next generation.
Any live cell with more than three live neighbours dies, as if by over-population.
Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
*/
    func executeRound() -> Set<Cell> {
        var set = Set<Cell>()
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                let currentCell = getCell(column, row: row)
                if(currentCell!.alive) {
                    currentCell?.alive = stillAlive(currentCell!)
                } else {
                    currentCell?.alive = comingToLife(currentCell!)
                }
                field[column, row] = currentCell!
                set.insert(currentCell!)
            }
        }
        return set
    }
    
    func comingToLife(cell:Cell) -> Bool {
        var comingToLife = false
        let numLivingNeighbors = getLivingNeighborCount(cell)
        if numLivingNeighbors == 3 {
            comingToLife = true
        }
        return comingToLife
    }

    func stillAlive(cell: Cell) -> Bool {
        var stillAlive = false
        let numLivingNeighbors = getLivingNeighborCount(cell)
        if numLivingNeighbors > 1 && numLivingNeighbors < 4 {
            stillAlive = true
        }
        return stillAlive
    }
    
    func getLivingNeighborCount(cell: Cell) -> Int {
        let numLivingNeighbors = getNorthLivingCount(cell) + getSouthLivingCount(cell) + getEastLivingCount(cell) + getWestLivingCount(cell) + getNorthWestLivingCount(cell) + getSouthWestLivingCount(cell) + getNorthEastLivingCount(cell) + getSouthEastLivingCount(cell)
        return numLivingNeighbors
    }
    
    func getNorthLivingCount(cell: Cell) -> Int {
        var retVal = 0
        let row = cell.row - 1
        if (row >= 0) {
            if (getCell(cell.column, row: row)!.alive) {
                retVal = 1
            }
        }
        return retVal
    }
    
    func getSouthLivingCount(cell: Cell) -> Int {
        var retVal = 0
        let row = cell.row + 1
        if (row < NumRows) {
            if (getCell(cell.column, row: row)!.alive) {
                retVal = 1
            }
        }
        return retVal
    }
    
    func getWestLivingCount(cell: Cell) -> Int {
        var retVal = 0
        let col = cell.column - 1
        if (col > 0) {
            if (getCell(col, row: cell.row)!.alive) {
                retVal = 1
            }
        }
        return retVal
    }

    
    func getEastLivingCount(cell: Cell) -> Int {
        var retVal = 0
        let col = cell.column + 1
        if (col < NumColumns) {
            if (getCell(col, row: cell.row)!.alive) {
                retVal = 1
            }
        }
        return retVal
    }
    
    func getNorthWestLivingCount(cell: Cell) -> Int {
        var retVal = 0
        let row = cell.row - 1
        let col = cell.column - 1
        if (row >= 0 && col >= 0) {
            if (getCell(col, row: row)!.alive) {
                retVal = 1
            }
        }
        return retVal
    }

    func getNorthEastLivingCount(cell: Cell) -> Int {
        var retVal = 0
        let row = cell.row - 1
        let col = cell.column + 1
        if (row >= 0 && col < NumColumns) {
            if (getCell(col, row: row)!.alive) {
                retVal = 1
            }
        }
        return retVal
    }
    
    func getSouthWestLivingCount(cell: Cell) -> Int {
        var retVal = 0
        let row = cell.row + 1
        let col = cell.column - 1
        if (row < NumRows && col >= 0) {
            if (getCell(col, row: row)!.alive) {
                retVal = 1
            }
        }
        return retVal
    }

    func getSouthEastLivingCount(cell: Cell) -> Int {
        var retVal = 0
        let row = cell.row + 1
        let col = cell.column + 1
        if (row < NumRows && col < NumColumns) {
            if (getCell(col, row: row)!.alive) {
                retVal = 1
            }
        }
        return retVal
    }
    
    private func createInitialCells() -> Set<Cell> {
        var set = Set<Cell>()
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                let cell = Cell(column: column, row: row, alive: coinFlip())
                field[column, row] = cell
                set.insert(cell)
            }
        }
        return set
    }
    
    private func coinFlip() -> Bool {
        let randomNumber = arc4random()
        var coin = false
        if randomNumber % 2 == 0 {
            coin = true
        }
        return coin
    }
}