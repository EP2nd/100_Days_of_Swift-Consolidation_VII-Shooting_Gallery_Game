//
//  GameScene.swift
//  Consolidation_7-Shooting_Gallery_Game
//
//  Created by Edwin Przeźwiecki Jr. on 30/09/2022.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var stickNode: SKSpriteNode!
    var duckNode: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var timerLabel: SKLabelNode!
    var gameOverLabel: SKSpriteNode!
    var restartLabel: SKLabelNode!
    var gameTimer: Timer?
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var timer = 60 {
        didSet {
            timerLabel.text = "\(timer) s"
        }
    }
    var numberOfBullets = 6
    var numberOfTaps = 0
    var rowNumber = 0
    var timeInterval = 10.0
    var appearTime = 5.0
    
    var isGameOver = false
    var isShot = false
    
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
        
        /* if Int.random(in: 0...3) == 0 {
            duckNode.texture = SKTexture(imageNamed: "duck-chick")
            duckNode.name = "newborn"
        } else if Int.random(in: 0...3) == 1 {
            duckNode.texture = SKTexture(imageNamed: "duck-young")
            duckNode.name = "youngling"
        } else {
            duckNode.texture = SKTexture(imageNamed: "duck")
            duckNode.name = "adult"
        } */
        
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
        
        timerLabel = SKLabelNode(fontNamed: "GillSans-UltraBold")
        timerLabel.zPosition = 1
        timerLabel.position = CGPoint(x: 512, y: 728)
        timerLabel.text = "60 s"
        timerLabel.fontColor = .systemRed
        addChild(timerLabel)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        start()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let objects = nodes(at: location)
        
        for duck in objects {
            if duck.name == "newborn" && duck.xScale == 0.5 {
                score -= 30
                numberOfTaps += 1
                duck.run(SKAction.fadeOut(withDuration: 0.5))
                run(SKAction.playSoundFileNamed("shot", waitForCompletion: false))
            } else if duck.name == "newborn" && duck.xScale == -0.75 {
                score -= 15
                numberOfTaps += 1
                duck.run(SKAction.fadeOut(withDuration: 0.5))
                run(SKAction.playSoundFileNamed("shot", waitForCompletion: false))
            } else if duck.name == "newborn" && duck.xScale == 1 {
                score -= 10
                numberOfTaps += 1
                duck.run(SKAction.fadeOut(withDuration: 0.5))
                run(SKAction.playSoundFileNamed("shot", waitForCompletion: false))
            } else if duck.name == "youngling" && duck.xScale == 0.5 {
                score += 3
                numberOfTaps += 1
                duck.run(SKAction.fadeOut(withDuration: 0.5))
                run(SKAction.playSoundFileNamed("shot", waitForCompletion: false))
            } else if duck.name == "youngling" && duck.xScale == -0.75 {
                score += 2
                numberOfTaps += 1
                duck.run(SKAction.fadeOut(withDuration: 0.5))
                run(SKAction.playSoundFileNamed("shot", waitForCompletion: false))
            } else if duck.name == "youngling" && duck.xScale == 1 {
                score += 1
                numberOfTaps += 1
                duck.run(SKAction.fadeOut(withDuration: 0.5))
                run(SKAction.playSoundFileNamed("shot", waitForCompletion: false))
            } else if duck.name == "adult" && duck.xScale == 0.5 {
                score += 10
                numberOfTaps += 1
                duck.run(SKAction.fadeOut(withDuration: 0.5))
                run(SKAction.playSoundFileNamed("shot", waitForCompletion: false))
            } else if duck.name == "adult" && duck.xScale == -0.75 {
                score += 5
                numberOfTaps += 1
                duck.run(SKAction.fadeOut(withDuration: 0.5))
                run(SKAction.playSoundFileNamed("shot", waitForCompletion: false))
            } else if duck.name == "adult" && duck.xScale == 1 {
                score += 3
                numberOfTaps += 1
                duck.run(SKAction.fadeOut(withDuration: 0.5))
                run(SKAction.playSoundFileNamed("shot", waitForCompletion: false))
            }
        }
        
        for object in objects {
            if object.name == "restart" {
                score = 0
                timer = 60
                isGameOver = false
                
                if let gameOverLabel = gameOverLabel {
                    gameOverLabel.removeFromParent()
                }
                
                if let restartLabel = restartLabel {
                    restartLabel.removeFromParent()
                }
                
                start()
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < 0 || node.position.x > 1024 {
                node.removeFromParent()
            }
        }
    }
    
    func start() {
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (Timer) in
            if self.timer > 0 {
                self.timer -= 1
            } else {
                Timer.invalidate()
                self.gameOver()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self ] in
            self?.createDucks(row: 1)
            self?.createDucks(row: 2)
            self?.createDucks(row: 3)
        }
    }
    
    @objc func createDucks(row rowNumber: Int) {
        if isGameOver { return }
        
        stickNode = SKSpriteNode(imageNamed: "stick")
        stickNode.zPosition = 1
        if rowNumber == 1 {
            stickNode.position = CGPoint(x: 0, y: 28)
        } else if rowNumber == 2 {
            stickNode.position = CGPoint(x: 1024, y: 228)
        } else if rowNumber == 3 {
            stickNode.position = CGPoint(x: 0, y: 428)
        }
        stickNode.name = "stick"
        addChild(stickNode)
        
        duckNode = SKSpriteNode(imageNamed: "duck")
        if Int.random(in: 0...3) == 0 {
            duckNode.texture = SKTexture(imageNamed: "duck-chick")
            duckNode.name = "newborn"
        } else if Int.random(in: 0...3) == 1 {
            duckNode.texture = SKTexture(imageNamed: "duck-young")
            duckNode.name = "youngling"
        } else {
            duckNode.texture = SKTexture(imageNamed: "duck")
            duckNode.name = "adult"
        }
        duckNode.zPosition = 2
        if rowNumber == 1 {
            duckNode.position = CGPoint(x: 0, y: 145)
        } else if rowNumber == 2 {
            duckNode.position = CGPoint(x: 1024, y: 315)
        } else if rowNumber == 3 {
            duckNode.position = CGPoint(x: 0, y: 485)
        }
        addChild(duckNode)
        
        stickNode.physicsBody = SKPhysicsBody(texture: stickNode.texture!, size: stickNode.size)
        stickNode.physicsBody?.collisionBitMask = 0
        if rowNumber == 1 {
            stickNode.physicsBody?.velocity = CGVector(dx: 200, dy: 0)
        } else if rowNumber == 2 {
            stickNode.physicsBody?.velocity = CGVector(dx: -300, dy: 0)
        } else {
            stickNode.physicsBody?.velocity = CGVector(dx: 500, dy: 0)
        }
        stickNode.physicsBody?.angularVelocity = 0
        stickNode.physicsBody?.linearDamping = 0
        stickNode.physicsBody?.angularDamping = 0
        
        duckNode.physicsBody = SKPhysicsBody(texture: duckNode.texture!, size: duckNode.size)
        duckNode.physicsBody?.collisionBitMask = 0
        if rowNumber == 1 {
            duckNode.physicsBody?.velocity = CGVector(dx: 200, dy: 0)
        } else if rowNumber == 2 {
            duckNode.physicsBody?.velocity = CGVector(dx: -300, dy: 0)
        } else {
            duckNode.physicsBody?.velocity = CGVector(dx: 500, dy: 0)
        }
        duckNode.physicsBody?.angularVelocity = 0
        duckNode.physicsBody?.linearDamping = 0
        duckNode.physicsBody?.angularDamping = 0
        
        scale(row: rowNumber)
        
        let minDelay = appearTime / 2.0
        let maxDelay = appearTime * 2
        let delay = Double.random(in: minDelay...maxDelay)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [ weak self ] in
            self?.createDucks(row: rowNumber/*, at: position*/)
        }
    }
    
    func scale(row rowNumber: Int) {
        if rowNumber == 1 {
            stickNode.xScale = 1; stickNode.yScale = 1
            duckNode.xScale = 1; duckNode.yScale = 1
        } else if rowNumber == 2 {
            stickNode.xScale = 0.75; stickNode.yScale = 0.75
            duckNode.xScale = -0.75; duckNode.yScale = 0.75
        } else if rowNumber == 3 {
            stickNode.xScale = 0.5; stickNode.yScale = 0.5
            duckNode.xScale = 0.5; duckNode.yScale = 0.5
        } else {
            return
        }
    }
    
    func gameOver() {
        if timer == 0 {
            isGameOver = true
        }
        
        gameOverLabel = SKSpriteNode(imageNamed: "game-over")
        gameOverLabel.zPosition = 1
        gameOverLabel.position = CGPoint(x: 512, y: 384)
        addChild(gameOverLabel)
        
        restartLabel = SKLabelNode(fontNamed: "GillSans-UltraBold")
        restartLabel.zPosition = 1
        restartLabel.position = CGPoint(x: 512, y: 244)
        restartLabel.horizontalAlignmentMode = .center
        restartLabel.text = "Restart"
        restartLabel.fontSize = 54
        restartLabel.fontColor = .brown
        restartLabel.name = "restart"
        addChild(restartLabel)
        
        for node in children {
            if node.name == "stick" || node.name == "newborn" || node.name == "youngling" || node.name == "duck" {
                node.removeFromParent()
            }
        }
    }
}
