//
//  DeadDuckWalking.swift
//  Consolidation_7-Shooting_Gallery_Game
//
//  Created by Edwin Przeźwiecki Jr. on 30/09/2022.
//

import SpriteKit
import UIKit

class DeadDuckWalking: SKNode {
    var stickNode: SKSpriteNode!
    var duckNode: SKSpriteNode!
    
    var isVisible = false
    var isShot = false
    
    var rowNumber = 0
    
    func configure(row rowNumber: Int, at position: CGPoint) {
        self.position = position
        
        stickNode = SKSpriteNode(imageNamed: "stick")
        stickNode.zPosition = 1
        if rowNumber == 2 {
            stickNode.position = CGPoint(x: 1024, y: 28)
        } else {
            stickNode.position = CGPoint(x: 0, y: 28)
        }
        addChild(stickNode)
        
        duckNode = SKSpriteNode(imageNamed: "duck")
        duckNode.zPosition = 2
        if rowNumber == 1 {
            duckNode.position = CGPoint(x: 0, y: 145)
        } else if rowNumber == 2 {
            duckNode.position = CGPoint(x: 1024, y: 115)
        } else if rowNumber == 3 {
            duckNode.position = CGPoint(x: 0, y: 85)
        }
        duckNode.name = "aim"
        addChild(duckNode)
        
        stickNode.physicsBody = SKPhysicsBody(texture: stickNode.texture!, size: stickNode.size)
        stickNode.physicsBody?.collisionBitMask = 0
        if rowNumber == 2 {
            stickNode.physicsBody?.velocity = CGVector(dx: -300, dy: 0)
        } else {
            stickNode.physicsBody?.velocity = CGVector(dx: 300, dy: 0)
        }
        stickNode.physicsBody?.angularVelocity = 0
        stickNode.physicsBody?.linearDamping = 0
        stickNode.physicsBody?.angularDamping = 0
        
        duckNode.physicsBody = SKPhysicsBody(texture: duckNode.texture!, size: duckNode.size)
        duckNode.physicsBody?.collisionBitMask = 0
        if rowNumber == 2 {
            duckNode.physicsBody?.velocity = CGVector(dx: -300, dy: 0)
        } else {
            duckNode.physicsBody?.velocity = CGVector(dx: 300, dy: 0)
        }
        duckNode.physicsBody?.angularVelocity = 0
        duckNode.physicsBody?.linearDamping = 0
        duckNode.physicsBody?.angularDamping = 0
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
    
    func show() {
        if isVisible { return }
        
        if rowNumber == 2 {
            stickNode.run(SKAction.moveBy(x: -1024, y: 0, duration: 5))
            duckNode.run(SKAction.moveBy(x: -1024, y: 0, duration: 5))
        } else {
            stickNode.run(SKAction.moveBy(x: 1024, y: 0, duration: 5))
            duckNode.run(SKAction.moveBy(x: -1024, y: 0, duration: 5))
        }
        
        isVisible = true
        isShot = false
        
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
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            [weak self] in
            self?.hide()
        }
    }
    
    func hide() {
        if !isVisible { return }
        
        if duckNode.position == CGPoint(x: 0, y: 1024) {
            isVisible = false
        }
    }
    
    func shot() {
        isShot = true
        
        let delay = SKAction.wait(forDuration: 0.25)
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let notVisible = SKAction.run { [unowned self] in
            self.isVisible = false }
        duckNode.run(SKAction.sequence([delay, fadeOut, notVisible]))
    }
}
