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
    var firstRowOfWater: SKSpriteNode!
    var secondRowOfWater: SKSpriteNode!
    var thirdRowOfWater: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var timerLabel: SKLabelNode!
    var firstThreeBullets: SKSpriteNode!
    var lastThreeBullets: SKSpriteNode!
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
    var shotsFired = 0 {
        didSet {
            numberOfBullets -= 1
        }
    }
    var rowNumber = 0
    var timeInterval = 10.0
    var appearTime = 5.0
    
    var isGameOver = false
    
    override func didMove(to view: SKView) {
        
        backgroundColor = .systemBackground
        
        firstRowOfWater = SKSpriteNode(imageNamed: "water-bg")
        firstRowOfWater.zPosition = 0
        firstRowOfWater.position = CGPoint(x: 512, y: 128)
        firstRowOfWater.size.width = view.frame.size.width
        addChild(firstRowOfWater)
        
        secondRowOfWater = SKSpriteNode(imageNamed: "water-fg")
        secondRowOfWater.zPosition = -1
        secondRowOfWater.position = CGPoint(x: 512, y: 256)
        secondRowOfWater.size.width = view.frame.size.width
        addChild(secondRowOfWater)
        
        thirdRowOfWater = SKSpriteNode(imageNamed: "water-bg")
        thirdRowOfWater.zPosition = -2
        thirdRowOfWater.position = CGPoint(x: 512, y: 384)
        thirdRowOfWater.size.width = view.frame.size.width
        addChild(thirdRowOfWater)
        
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
        
        if objects.isEmpty {
            reload()
        }
        
        for duck in objects {
            if shotsFired <= 6 {
                if duck.name == "newborn" && duck.xScale == 0.5 {
                    shoot()
                    if shotsFired < 6 || numberOfBullets == 0 {
                        if numberOfBullets == 0 {
                            numberOfBullets = -1
                        }
                        score -= 30
                        duck.run(SKAction.fadeOut(withDuration: 0.5))
                    }
                } else if duck.name == "newborn" && duck.xScale == -0.75 {
                    shoot()
                    if shotsFired < 6 || numberOfBullets == 0 {
                        if numberOfBullets == 0 {
                            numberOfBullets = -1
                        }
                        score -= 15
                        duck.run(SKAction.fadeOut(withDuration: 0.5))
                    }
                } else if duck.name == "newborn" && duck.xScale == 1 {
                    shoot()
                    if shotsFired < 6 || numberOfBullets == 0 {
                        if numberOfBullets == 0 {
                            numberOfBullets = -1
                        }
                        score -= 10
                        duck.run(SKAction.fadeOut(withDuration: 0.5))
                    }
                } else if duck.name == "youngling" && duck.xScale == 0.5 {
                    shoot()
                    if shotsFired < 6 || numberOfBullets == 0 {
                        if numberOfBullets == 0 {
                            numberOfBullets = -1
                        }
                        score += 3
                        duck.run(SKAction.fadeOut(withDuration: 0.5))
                    }
                } else if duck.name == "youngling" && duck.xScale == -0.75 {
                    shoot()
                    if shotsFired < 6 || numberOfBullets == 0 {
                        if numberOfBullets == 0 {
                            numberOfBullets = -1
                        }
                        score += 2
                        duck.run(SKAction.fadeOut(withDuration: 0.5))
                    }
                } else if duck.name == "youngling" && duck.xScale == 1 {
                    shoot()
                    if shotsFired < 6 || numberOfBullets == 0 {
                        if numberOfBullets == 0 {
                            numberOfBullets = -1
                        }
                        score += 1
                        duck.run(SKAction.fadeOut(withDuration: 0.5))
                    }
                } else if duck.name == "adult" && duck.xScale == 0.5 {
                    shoot()
                    if shotsFired < 6 || numberOfBullets == 0 {
                        if numberOfBullets == 0 {
                            numberOfBullets = -1
                        }
                        score += 10
                        duck.run(SKAction.fadeOut(withDuration: 0.5))
                    }
                } else if duck.name == "adult" && duck.xScale == -0.75 {
                    shoot()
                    if shotsFired < 6 || numberOfBullets == 0 {
                        if numberOfBullets == 0 {
                            numberOfBullets = -1
                        }
                        score += 5
                        duck.run(SKAction.fadeOut(withDuration: 0.5))
                    }
                } else if duck.name == "adult" && duck.xScale == 1 {
                    shoot()
                    if shotsFired < 6 || numberOfBullets == 0 {
                        if numberOfBullets == 0 {
                            numberOfBullets = -1
                        }
                        score += 3
                        duck.run(SKAction.fadeOut(withDuration: 0.5))
                    }
                }
            }
        }
        
        for object in objects {
            guard isGameOver == true else { continue }
            
            if object.name == "restart" {
                score = 0
                timer = 60
                shotsFired = 0
                numberOfBullets = 6
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
    
    func shoot() {
        if shotsFired == 6 {
            run(SKAction.playSoundFileNamed("empty", waitForCompletion: false))
        } else if shotsFired < 6 {
            shotsFired += 1
            run(SKAction.playSoundFileNamed("shot", waitForCompletion: false))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < 0 || node.position.x > 1024 {
                node.removeFromParent()
            }
        }
        
        if numberOfBullets == 6 {
            firstThreeBullets.texture = SKTexture(imageNamed: "shots3")
        } else if numberOfBullets == 5 {
            firstThreeBullets.texture = SKTexture(imageNamed: "shots2")
        } else if numberOfBullets == 4 {
            firstThreeBullets.texture = SKTexture(imageNamed: "shots1")
        } else if numberOfBullets == 3 {
            firstThreeBullets.texture = SKTexture(imageNamed: "shots0")
        } else if numberOfBullets == 2 {
            lastThreeBullets.texture = SKTexture(imageNamed: "shots2")
        } else if numberOfBullets == 1 {
            lastThreeBullets.texture = SKTexture(imageNamed: "shots1")
        } else if numberOfBullets <= 0 {
            lastThreeBullets.texture = SKTexture(imageNamed: "shots0")
        }
    }
    
    func start() {
        firstThreeBullets = SKSpriteNode(imageNamed: "shots3")
        firstThreeBullets.zPosition = -2
        firstThreeBullets.position = CGPoint(x: 974, y: 738)
        addChild(firstThreeBullets)
        
        lastThreeBullets = SKSpriteNode(imageNamed: "shots3")
        lastThreeBullets.zPosition = -2
        lastThreeBullets.position = CGPoint(x: 893, y: 738)
        addChild(lastThreeBullets)
        
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
    
    func reload() {
        guard isGameOver == false else { return }
        
        lastThreeBullets.texture = SKTexture(imageNamed: "shots3")
        firstThreeBullets.texture = SKTexture(imageNamed: "shots3")
        
        run(SKAction.playSoundFileNamed("reload", waitForCompletion: true))
        
        shotsFired = 0
        numberOfBullets = 6
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
