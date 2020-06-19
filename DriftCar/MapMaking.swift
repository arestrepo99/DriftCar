//
//  MapMaking.swift
//  DriftCar
//
//  Created by Agustin Restrepo on 6/16/20.
//  Copyright © 2020 Agustin Restrepo. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Map{
    
    private var current_point: CGPoint = CGPoint(x:0,y:0)
    private var road_direction: String = "n"
    private var mapsize = 5
    
    let turns: [String]
    let graphics: [String]
    
    init(turns: [String], graphics: [String]){
        self.turns = turns
        self.graphics = graphics
        
    }
    
    func render(gameScene: GameScene){
        for turn in turns{
            plot(turn: turn, gameScene: gameScene)
        }
        for i in -mapsize...mapsize{
            for j in -mapsize...mapsize{
                let backgroundtile = SKSpriteNode(imageNamed: "Background")
                backgroundtile.position = CGPoint(x: 500*i, y: 500*j)
                backgroundtile.zPosition = -5
                gameScene.addChild(backgroundtile)
            }
        }
    }
    func plot(turn: String, gameScene: GameScene)  {
        let bloc_size: CGFloat = 500
        switch self.road_direction{
        case "n":
            switch turn{
            case "s":
                let image = SKSpriteNode(imageNamed: "tarmac_straight")
                image.position = current_point
                gameScene.addChild(image)
                current_point.y = current_point.y+bloc_size
                road_direction = "n"
            case "r":
                let image: SKSpriteNode = SKSpriteNode(imageNamed: "tarmac_right")
                image.position = current_point
                current_point.x = current_point.x + bloc_size
                gameScene.addChild(image)
                road_direction = "e"
            case "l":
                let image: SKSpriteNode = SKSpriteNode(imageNamed: "tarmac_left")
                image.position = current_point
                current_point.x = current_point.x-bloc_size
                current_point.y = current_point.y+bloc_size
                gameScene.addChild(image)
                road_direction = "w"
            default:
                print("Error")
            }
        case "s":
            switch turn{
            case "s":
                let image = SKSpriteNode(imageNamed: "tarmac_straight")
                image.position = current_point
                image.zRotation = CGFloat.pi
                gameScene.addChild(image)
                current_point.y = current_point.y-bloc_size
                road_direction = "s"
            case "r":
                let image: SKSpriteNode = SKSpriteNode(imageNamed: "tarmac_right")
                image.position = current_point
                image.zRotation = CGFloat.pi
                current_point.x = current_point.x-bloc_size
                gameScene.addChild(image)
                road_direction = "w"
            case "l":
                let image: SKSpriteNode = SKSpriteNode(imageNamed: "tarmac_left")
                image.position = current_point
                image.zRotation = CGFloat.pi
                current_point.x = current_point.x+bloc_size
                gameScene.addChild(image)
                road_direction = "e"
            default:
                print("Error")
            }
        case "e":
            switch turn{
            case "s":
                let image = SKSpriteNode(imageNamed: "tarmac_straight")
                image.position = current_point
                image.zRotation = -CGFloat.pi/2
                gameScene.addChild(image)
                current_point.x = current_point.x+bloc_size
                road_direction = "e"
            case "r":
                let image: SKSpriteNode = SKSpriteNode(imageNamed: "tarmac_right")
                image.position = current_point
                image.zRotation = -CGFloat.pi/2
                current_point.y = current_point.y-bloc_size
                gameScene.addChild(image)
                road_direction = "s"
            case "l":
                let image: SKSpriteNode = SKSpriteNode(imageNamed: "tarmac_left")
                image.position = current_point
                image.zRotation = -CGFloat.pi/2
                current_point.y = current_point.y+bloc_size
                gameScene.addChild(image)
                road_direction = "n"
            default:
                print("Error")
            }
        case "w":
            switch turn{
            case "s":
                let image = SKSpriteNode(imageNamed: "tarmac_straight")
                image.position = current_point
                image.zRotation = CGFloat.pi/2
                gameScene.addChild(image)
                current_point.x = current_point.x-bloc_size
                road_direction = "e"
            case "r":
                let image: SKSpriteNode = SKSpriteNode(imageNamed: "tarmac_right")
                image.position = current_point
                image.zRotation = CGFloat.pi/2
                current_point.y = current_point.y+bloc_size
                gameScene.addChild(image)
                road_direction = "s"
            case "l":
                let image: SKSpriteNode = SKSpriteNode(imageNamed: "tarmac_left")
                image.position = current_point
                image.zRotation = CGFloat.pi/2
                current_point.y = current_point.y-bloc_size
                gameScene.addChild(image)
                road_direction = "n"
            default:
                print("Error")
            }
        default:
            print("ERROR")
        }
    }
}
