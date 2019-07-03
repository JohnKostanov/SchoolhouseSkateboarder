//
//  GameViewController.swift
//  SchoolhouseSkateboarder
//
//  Created by Andrian Kryk on 1/5/19.
//  Copyright © 2019 Andrian Kryk. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
//test commit
class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
				
				let width = view.bounds.width
				let height = view.bounds.height
				scene.size = CGSize(width: width, height: height)
				
				
				
				
                // Present the scene
                view.presentScene(scene)
            }
            
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
