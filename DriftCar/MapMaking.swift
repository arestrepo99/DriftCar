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
            print(turn,road_direction)
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
    func plot_road(imageNamed: String, position: CGPoint, rotation: CGFloat, gameScene: GameScene){
        let image = SKSpriteNode(imageNamed: imageNamed)
        let shadow = SKSpriteNode(imageNamed: imageNamed+"_shadow")
        let glow = SKSpriteNode(imageNamed: imageNamed+"_glow")
        image.position  = position
        image.zRotation = rotation
        shadow.position = CGPoint(x: position.x+7,y: position.y+7)
        shadow.zRotation = rotation
        shadow.alpha = 0.3
        glow.position = CGPoint(x: position.x-7,y: position.y-7)
        glow.zRotation = rotation
        shadow.zPosition = image.zPosition-0.5
        glow.zPosition = image.zPosition-0.5
        glow.alpha = 0.5
        gameScene.addChild(image)
        gameScene.addChild(shadow)
        gameScene.addChild(glow)
    }
    
    
    func plot(turn: String, gameScene: GameScene)  {
        let bloc_size: CGFloat = 500
        switch self.road_direction{
        case "n":
            switch turn{
            case "s":
                plot_road(imageNamed: "tarmac_straight", position: current_point, rotation: 0, gameScene: gameScene)
                current_point.y = current_point.y+bloc_size
                road_direction = "n"
            case "r":
                plot_road(imageNamed: "tarmac_right", position: current_point, rotation: 0, gameScene: gameScene)
                current_point.x = current_point.x + bloc_size
                road_direction = "e"
            case "l":
                plot_road(imageNamed: "tarmac_left", position: current_point, rotation: 0, gameScene: gameScene)
                current_point.x = current_point.x-bloc_size
                road_direction = "w"
            default:
                print("Error")
            }
        case "s":
            switch turn{
            case "s":
                plot_road(imageNamed: "tarmac_straight", position: current_point, rotation:  CGFloat.pi, gameScene: gameScene)
                current_point.y = current_point.y-bloc_size
                road_direction = "s"
            case "r":
                plot_road(imageNamed: "tarmac_right", position: current_point, rotation: CGFloat.pi, gameScene: gameScene)
                current_point.x = current_point.x-bloc_size
                road_direction = "w"
            case "l":
                plot_road(imageNamed: "tarmac_left", position: current_point, rotation:  CGFloat.pi, gameScene: gameScene)
                current_point.x = current_point.x+bloc_size
                road_direction = "e"
            default:
                print("Error")
            }
        case "e":
            switch turn{
            case "s":
                plot_road(imageNamed: "tarmac_straight", position: current_point, rotation:  -CGFloat.pi/2, gameScene: gameScene)
                current_point.x = current_point.x+bloc_size
                road_direction = "e"
            case "r":
                plot_road(imageNamed: "tarmac_right", position: current_point, rotation: -CGFloat.pi/2, gameScene: gameScene)
                current_point.y = current_point.y-bloc_size
                road_direction = "s"
            case "l":
                plot_road(imageNamed: "tarmac_left", position: current_point, rotation: -CGFloat.pi/2, gameScene: gameScene)
                current_point.y = current_point.y+bloc_size
                road_direction = "n"
            default:
                print("Error")
            }
        case "w":
            switch turn{
            case "s":
                plot_road(imageNamed: "tarmac_straight", position: current_point, rotation:  CGFloat.pi/2, gameScene: gameScene)
                current_point.x = current_point.x-bloc_size
                road_direction = "e"
            case "r":
                plot_road(imageNamed: "tarmac_right", position: current_point, rotation: CGFloat.pi/2, gameScene: gameScene)
                current_point.y = current_point.y+bloc_size
                road_direction = "n"
            case "l":
                plot_road(imageNamed: "tarmac_left", position: current_point, rotation: CGFloat.pi/2, gameScene: gameScene)
                current_point.y = current_point.y-bloc_size
                road_direction = "s"
            default:
                print("Error")
            }
        default:
            print("ERROR")
        }
    }
}
