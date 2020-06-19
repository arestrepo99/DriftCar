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
    
    private let phisicsBody: SKPhysicsBody
    
    init(){
        //self
        self.phisicsBody = SKPhysicsBody(circleOfRadius:50)
        self.phisicsBody.affectedByGravity = false
        self.phisicsBody.allowsRotation = true
        self.phisicsBody.isDynamic = true
        self.phisicsBody.mass = 10
        self.phisicsBody.friction = 0.0
        self.phisicsBody.angularDamping = 0.3
        let texture = SKTexture(imageNamed: "car")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        super.physicsBody = self.phisicsBody
        self.zRotation = CGFloat.pi/2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func turn(turn: CGFloat){
        let sensitivity: CGFloat = 5
        phisicsBody.applyTorque(turn*sensitivity)
        if turn == 0 {
            phisicsBody.angularVelocity = phisicsBody.angularVelocity*0.1
        }
    }
    
    func dot(v1: CGVector, v2: CGVector) -> CGFloat{
        return(CGFloat((v1.dx * v2.dx) + (v1.dy * v2.dy)))
    }
    func theta(v1: CGVector, v2: CGVector) -> CGFloat{
        return( acos(dot(v1: v1, v2: v2)/(mag(v: v1)*mag(v: v2))) )
    }
    
    func mag(v: CGVector)-> CGFloat{
        return(pow(dot(v1: v, v2: v),0.5))
    }
    
    func vecc(v: CGVector, c: CGFloat) -> CGVector{
        return(CGVector(dx: v.dx*c, dy: v.dy*c))
    }
    func vecmul(v1: CGVector, v2: CGVector) -> CGVector{
        return(CGVector(dx: v1.dx*v2.dx, dy: v1.dy*v2.dy))
    }
    
    func vecsum(v1: CGVector, v2: CGVector) -> CGVector{
        return(CGVector(dx: v1.dx+v2.dx, dy: v1.dy+v2.dy))
    }
    
    func norm(v: CGVector)-> CGVector{
        return(vecc(v: v, c: 1/mag(v: v)))
    }
    
    func proj(u: CGVector, v: CGVector) -> CGVector{
        return(vecc(v: v, c: dot(v1: u, v2: v)/pow(mag(v: v),2)))
    }
    
    func step(scene: GameScene, currentTime: TimeInterval, pastTime: TimeInterval){
        let force: CGFloat = 5000
        let topSpeed: CGFloat = 500
        var forcevec = CGVector(dx: cos(self.zRotation)*force, dy: sin(self.zRotation)*force)
        if theta(v1: phisicsBody.velocity, v2: forcevec)<CGFloat.pi/2{
            let projection = proj(u: forcevec, v: phisicsBody.velocity)
            //print("Speed", phisicsBody.velocity.dx, phisicsBody.velocity.dy, mag(v: phisicsBody.velocity))
            forcevec = vecsum(v1: forcevec, v2: vecc(v: projection, c: -mag(v: phisicsBody.velocity)/topSpeed))
        }
        phisicsBody.applyForce(forcevec)
        scene.cameraNode.position = self.position
        var angle = theta(v1: self.phisicsBody.velocity, v2: CGVector(dx:0, dy:1))
        if self.phisicsBody.velocity.dx>0{
            angle = -angle
        }
        scene.cameraNode.zRotation = angle
    }
    

    
}
