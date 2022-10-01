//
//  GameScene.swift
//  Consolidation_7-Shooting_Gallery_Game
//
//  Created by Edwin Przeźwiecki Jr. on 30/09/2022.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var miles = [DeadDuckWalking]()
    var appearTime = 0.85
    var numberOfBullets = 6
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
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self ] in
            self?.letDucksLoose(row: 1, at: CGPoint(x: 0, y: 0))
            self?.letDucksLoose(row: 2, at: CGPoint(x: 0, y: 200))
            self?.letDucksLoose(row: 3, at: CGPoint(x: 0, y: 400))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    func letDucksLoose(row rowNumber: Int, at position: CGPoint) {
        let mile = DeadDuckWalking()
        
        mile.configure(row: rowNumber, at: position)
        mile.scale(row: rowNumber)
        addChild(mile)
        miles.append(mile)
    }
    
    func createDucks() {
        miles.shuffle()
        miles[0].show()
        
        if Int.random(in: 0...2) == 0 { miles[1].show() }
        if Int.random(in: 0...2) == 1 { miles[2].show() }
        if Int.random(in: 0...2) == 2 { miles[3].show() }
        
        let minDelay = appearTime / 2.0
        let maxDelay = appearTime * 2
        let delay = Double.random(in: minDelay...maxDelay)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [ weak self ] in
            self?.createDucks()
        }
    }
}
