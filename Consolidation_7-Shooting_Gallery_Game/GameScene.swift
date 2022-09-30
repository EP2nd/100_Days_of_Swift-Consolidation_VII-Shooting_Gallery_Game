//
//  GameScene.swift
//  Consolidation_7-Shooting_Gallery_Game
//
//  Created by Edwin Przeźwiecki Jr. on 30/09/2022.
//

import SpriteKit

class GameScene: SKScene {
    
    var ducks = [DeadDuckWalking]()
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var gameTime: Timer?
    var gameOverLabel: SKLabelNode!
    var restartLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        
        let firstRow = SKSpriteNode(imageNamed: "water-bg")
        firstRow.zPosition = 0
        firstRow.position = CGPoint(x: 512, y: 128)
        firstRow.size.width = view.frame.size.width
        addChild(firstRow)
        
        let secondRow = SKSpriteNode(imageNamed: "water-fg")
        secondRow.zPosition = -1
        secondRow.position = CGPoint(x: 512, y: 256)
        secondRow.size.width = view.frame.size.width
        addChild(secondRow)
        
        let thirdRow = SKSpriteNode(imageNamed: "water-bg")
        thirdRow.zPosition = -2
        thirdRow.position = CGPoint(x: 512, y: 384)
        thirdRow.size.width = view.frame.size.width
        addChild(thirdRow)
        
        let firstBullets = SKSpriteNode(imageNamed: "shots3")
        firstBullets.zPosition = -2
        firstBullets.position = CGPoint(x: 974, y: 738)
        addChild(firstBullets)
        
        let lastBullets = SKSpriteNode(imageNamed: "shots3")
        lastBullets.zPosition = -2
        lastBullets.position = CGPoint(x: 893, y: 738)
        addChild(lastBullets)
        
        scoreLabel = SKLabelNode(fontNamed: "GillSans-UltraBold")
        scoreLabel.zPosition = 1
        scoreLabel.position = CGPoint(x: 12, y: 728)
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.text = "Score: 0"
        scoreLabel.fontColor = .gray
        addChild(scoreLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
