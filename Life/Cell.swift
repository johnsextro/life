
import SpriteKit

class Cell: Equatable, Hashable {
    var column: Int
    var row: Int
    var alive: Bool
    var sprite: SKSpriteNode?
    
    init(column: Int, row: Int, alive: Bool) {
        self.column = column
        self.row = row
        self.alive = alive
    }
    
    var hashValue: Int {
        return row*10 + column
    }
    
}
func ==(lhs: Cell, rhs: Cell) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row
}