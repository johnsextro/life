import SpriteKit

class GameScene: SKScene {
    
    var cells: Cells!
    
    let TileWidth: CGFloat = 10.0
    let TileHeight: CGFloat = 10.0
    
    let gameLayer = SKNode()
    let cellsLayer = SKNode()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let background = SKSpriteNode(color: UIColor.grayColor(), size: size)
        addChild(background)
        
        addChild(gameLayer)
        
        let layerPosition = CGPoint(
            x: -TileWidth * CGFloat(NumColumns) / 2,
            y: -TileHeight * CGFloat(NumRows) / 2)
        
        cellsLayer.position = layerPosition
        gameLayer.addChild(cellsLayer)
    }
    
    func addSpritesForCells(cells: Set<Cell>) {
        cellsLayer.removeAllChildren()
        for cell in cells {
            let sprite = SKSpriteNode(color: UIColor.grayColor(), size: CGSize(width: 9.5, height: 9.5))
            if(cell.alive) {
                sprite.color = UIColor.greenColor()
            }
            sprite.position = pointForColumn(cell.column, row:cell.row)
            cellsLayer.addChild(sprite)
            cell.sprite = sprite
        }
    }
    
    func pointForColumn(column: Int, row: Int) -> CGPoint {
        return CGPoint(
            x: CGFloat(column)*TileWidth + TileWidth/2,
            y: CGFloat(row)*TileHeight + TileHeight/2)
    }
    
    override func update(currentTime: NSTimeInterval) {
        addSpritesForCells(cells.executeRound())
    }

}
