
import Foundation

let NumColumns = 30
let NumRows = 60

class Cells {
    private var field = Array2D<Cell>(columns: NumColumns, rows: NumRows)

    func lifeStatusForCell(column: Int, row: Int) -> Cell? {
        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)
        return field[column, row]
    }

    func shuffle() -> Set<Cell> {
        return createInitialCells()
    }
    
    private func createInitialCells() -> Set<Cell> {
        var set = Set<Cell>()
        
        // 1
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