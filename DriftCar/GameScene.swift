//
//  GameScene.swift
//  DriftCar
//
//  Created by Agustin Restrepo on 6/16/20.
//  Copyright © 2020 Agustin Restrepo. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //public var carNode: SKShapeNode = SKShapeNode.init(rectOf:CGSize.init(width: 50, height: 100), cornerRadius: 10)
    
    public let cameraNode = SKCameraNode()
    
    public var map: Map
    public var car: Car
    
    init(size: CGSize, map: Map, car: Car){
        self.map = map
        self.car = car
        super.init(size: size)
    }

    convenience override init(){
        self.init()
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor(cgColor: CGColor(srgbRed: 12/355, green: 242/355, blue: 22/355, alpha: 1))
        self.addChild(cameraNode)
        self.camera = cameraNode
        self.addChild(car)
        self.addChild(car.shadow)
        self.map.render(gameScene: self)
    }
    
    func start(map:Map){
        map.render(gameScene: self)
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        car.turn(turn: -pos.x/300)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
       car.turn(turn: -pos.x/300)
    }
    
    func touchUp(atPoint pos : CGPoint) {
        car.turn(turn: 0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       for t in touches { self.touchDown(atPoint: t.location(in: cameraNode)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: cameraNode)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: cameraNode)) }

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    var pastTime: TimeInterval = -1
    
    override func update(_ currentTime: TimeInterval) {
        if pastTime == -1{
            pastTime = currentTime
        }
        else{
            car.step(scene: self, currentTime: currentTime,pastTime: pastTime)
        }
        
    }
    

        
}
