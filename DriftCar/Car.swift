//
//  Car.swift
//  DriftCar
//
//  Created by Agustin Restrepo on 6/17/20.
//  Copyright © 2020 Agustin Restrepo. All rights reserved.
//
import SpriteKit
import GameplayKit
import Foundation
public class Car: SKSpriteNode{
    
    public var action_value: CGFloat = 0
    private let action_sensitivity: CGFloat = 0.05
    private let phisicsBody: SKPhysicsBody
    private var direction: CGFloat = 0
    private let velocity:CGFloat = 5
    //public let carNode: SKSpriteNode = SKSpriteNode(imageNamed: "car")
    
    
    init(){
        //self
        self.phisicsBody = SKPhysicsBody(circleOfRadius:50)
        self.phisicsBody.affectedByGravity = false
        self.phisicsBody.allowsRotation = true
        self.phisicsBody.isDynamic = true
        self.phisicsBody.mass = 10
        self.phisicsBody.friction = 0.0
        let texture = SKTexture(imageNamed: "car")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        super.physicsBody = self.phisicsBody
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    func step2(scene: GameScene, currentTime: TimeInterval, pastTime: TimeInterval){
        let force: CGFloat = 1000
        //phisicsBody.applyForce(CGVector(dx: sin(direction)*force, dy: cos(direction)*force))
        phisicsBody.applyForce(CGVector(dx: sin(direction)*force, dy: cos(direction)*force))
    }
    
    func step(scene: GameScene, currentTime: TimeInterval, pastTime: TimeInterval){
        let dt = currentTime-pastTime
        self.zRotation = self.zRotation + action_sensitivity*action_value
        if self.zRotation > CGFloat.pi{
            self.zRotation = self.zRotation-2*CGFloat.pi
            self.direction = self.direction-2*CGFloat.pi
        }
        if self.zRotation < -CGFloat.pi{
            self.zRotation = self.zRotation+2*CGFloat.pi
            self.direction = self.direction+2*CGFloat.pi
        }
        //Turning
        self.position.x = self.position.x-sin(self.direction)*self.velocity
        self.position.y = self.position.y+cos(self.direction)*self.velocity
        //Inertia
        scene.cameraNode.zRotation = direction
        let drift_ratio:CGFloat = 0.01
        direction = (1-drift_ratio)*direction + drift_ratio*self.zRotation
        scene.cameraNode.position = self.position

        
        // Drift
        let timeStep = 0.01
        print(currentTime)
        if round(currentTime/timeStep) != round(pastTime/timeStep) && abs(self.zRotation-direction)>CGFloat.pi/4{
            print("Done")
            let driftNode = SKSpriteNode(imageNamed: "drift")
            driftNode.position = CGPoint(x: position.x, y: position.y)
            driftNode.run(SKAction.repeatForever(SKAction.move(by: CGVector(dx: -sin(-self.zRotation+CGFloat.random(in: -0.5...0.5))*self.velocity*10, dy:  -cos(-self.zRotation+CGFloat.random(in: -0.5...0.5))*self.velocity*10), duration: 0.1)))
            driftNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.1),
            SKAction.fadeOut(withDuration: 0.1),
            SKAction.removeFromParent()]))
            driftNode.zPosition = 0.5
            driftNode.alpha = 0.2
            scene.addChild(driftNode)
        }
    }
    

    
}
