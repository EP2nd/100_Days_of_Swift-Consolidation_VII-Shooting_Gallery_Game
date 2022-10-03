//
//  DeadDuckWalking.swift
//  Consolidation_7-Shooting_Gallery_Game
//
//  Created by Edwin Przeźwiecki Jr. on 30/09/2022.
//

import SpriteKit
import UIKit

class DeadDuckWalking: SKNode {
    var duckNode: SKSpriteNode!
    
    var isShot = false
    
    func shot() {
        isShot = true
        
        let delay = SKAction.wait(forDuration: 0.25)
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        
        duckNode.run(SKAction.sequence([delay, fadeOut]))
    }
}
