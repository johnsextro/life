//
//  GameViewController.swift
//  Life
//
//  Created by Family on 1/2/16.
//  Copyright (c) 2016 9 Principles. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    var scene: GameScene!
    var cells: Cells!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        // Create and configure the scene.
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        cells = Cells()
        scene.cells = cells
        beginGame()
        sleep(1)
        // Present the scene.
        skView.presentScene(scene)
    }
    
    func beginGame() {
        shuffle()
    }
    
    func shuffle() {
        let newCells = cells.shuffle()
        scene.addSpritesForCells(newCells)
    }
}
