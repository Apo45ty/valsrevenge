//
//  GameScene.swift
//  valsrevenge
//
//  Created by Antonio Tapia Maldonado on 11/29/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, GameViewControllerDelegate{
    
    private var player :Player?
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    
    }
    override func didMove(to view: SKView) {
        player = childNode(withName: "player") as? Player
        player?.move(.stop)
        setupCamera()
    }
    func didChangeLayout() {
        let w = view? .bounds.size.width ?? 1024
        let h = view? .bounds.size.height ?? 1336
        
        if h >= w {
            camera?.setScale(1.0)
        } else {
            camera?.setScale(1.25)
        }
    }
    
    func setupCamera(){
        guard let player = player else {return}
        let distance = SKRange(constantValue: 0)
        let playerConstrant = SKConstraint.distance(distance, to: player)
        camera?.constraints = [playerConstrant]
    }
    func touchDown(atPoint pos : CGPoint) {
        let nodeAtPoint = atPoint(pos)
        if let touchedNode = nodeAtPoint as? SKSpriteNode{
            if touchedNode.name?.starts(with: "controller_")==true {
                let direction = touchedNode.name?.replacingOccurrences(of: "controller_", with: "")
                player?.move(Direction(rawValue: direction ?? "stop")!)
            } else if touchedNode.name == "button_attack" {
                player?.attack()
            }
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        let nodeAtPoint = atPoint(pos)
        if let touchedNode = nodeAtPoint as? SKSpriteNode{
            if touchedNode.name?.starts(with: "controller_")==true {
                let direction = touchedNode.name?.replacingOccurrences(of: "controller_", with: "")
                player?.move(Direction(rawValue: direction ?? "stop")!)
            }
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        let nodeAtPoint = atPoint(pos)
        if let tochedNode = nodeAtPoint as? SKSpriteNode{
            if tochedNode.name?.starts(with: "controller_")==true{
                player?.stop()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    let margin :CGFloat = 20.0
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
    override func didFinishUpdate() {
        updateControllerLocation()
    }
    func updateControllerLocation(){
        let controller = childNode(withName: "//controller")
        controller?.position = CGPoint(x: viewLeft+margin, y: viewBottom+margin)
        let attackButton = childNode(withName: "//attackButton")
        attackButton?.position = CGPoint(x: viewRight-margin, y: viewBottom+margin)
    }
}
