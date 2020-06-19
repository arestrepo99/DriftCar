//
//  GameViewController.swift
//  DriftCar
//
//  Created by Agustin Restrepo on 6/16/20.
//  Copyright © 2020 Agustin Restrepo. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            let scene = GameScene(size: CGSize(width: 750, height: 1334), map: Map(turns: "ssrrrbssrsrssssslllblrrlsrsr", graphics: []), car: Car())
            // Load the SKScene from 'GameScene.sks'
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            
            //if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
              //  scene.scaleMode = .aspectFill
                                // Present the scene
            
                //view.presentScene(scene)
            //}
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
