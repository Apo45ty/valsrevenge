//
//  Player.swift
//  valsrevenge
//
//  Created by Antonio Tapia Maldonado on 11/29/21.
//

import SpriteKit

enum Direction:String{
    case stop
    case left
    case right
    case up
    case down
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}


class Player:SKSpriteNode{
    
    private var currentDirection = Direction.stop;
    
    func move(_ direction:Direction){
        if direction != .stop{
            currentDirection=direction
        }
        
        switch direction {
        case .stop:
            stop()
        case .left:
            self.physicsBody?.velocity = CGVector(dx: -100, dy: 0)
        case .right:
            self.physicsBody?.velocity = CGVector(dx: 100, dy: 0)
        case .up:
            self.physicsBody?.velocity = CGVector(dx: 0, dy: 100)
        case .down:
            self.physicsBody?.velocity = CGVector(dx: 0, dy: -100)
        case .topLeft:
            self.physicsBody?.velocity = CGVector(dx: -100, dy: 100)
        case .topRight:
            self.physicsBody?.velocity = CGVector(dx: 100, dy: 100)
        case .bottomLeft:
            self.physicsBody?.velocity = CGVector(dx: -100, dy: -100)
        case .bottomRight:
            self.physicsBody?.velocity = CGVector(dx: 100, dy: -100)
        }
    }
    
    func stop(){
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }
    func attack(){
        let projectile = SKSpriteNode(imageNamed: "knife")
        projectile.position = CGPoint(x: 0.0, y: 0.0)
        addChild(projectile)
        
        var throwDirection = CGVector(dx: 0, dy: 0)
        
        switch currentDirection {
        case .left:
            projectile.zRotation = CGFloat.pi/2.0
            throwDirection = CGVector(dx: -300, dy: 0)
        case .right,.stop:
            projectile.zRotation = -CGFloat.pi/2.0
            throwDirection = CGVector(dx: 300, dy: 0)
        case .up:
            projectile.zRotation = 0
            throwDirection = CGVector(dx: 0, dy: 300)
        case .down:
            projectile.zRotation = -CGFloat.pi
            throwDirection = CGVector(dx: 0, dy: -300)
        case .topLeft:
            projectile.zRotation = CGFloat.pi/4
            throwDirection = CGVector(dx: -300, dy: 300)
        case .topRight:
            projectile.zRotation = -CGFloat.pi/4
            throwDirection = CGVector(dx: 300, dy: 300)
        case .bottomLeft:
            projectile.zRotation = 3.0 * CGFloat.pi/4
            throwDirection = CGVector(dx: -300, dy: -300)
        case .bottomRight:
            projectile.zRotation = 3.0 * -CGFloat.pi/4
            throwDirection = CGVector(dx: 300, dy: -300)
        }
        
        let throwProjectile = SKAction.move(by: throwDirection, duration: 0.25)
        projectile.run(throwProjectile,completion: {projectile.removeFromParent()})
    }
}
