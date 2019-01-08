//
//  GameScene.swift
//  SchoolhouseSkateboarder
//
//  Created by Andrian Kryk on 1/5/19.
//  Copyright © 2019 Andrian Kryk. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
	
	var bricks = [SKSpriteNode]()
	var bricksSize = CGSize.zero
	
	var scrollSpeed:CGFloat = 5.0
	
	let grvitySpeed:CGFloat = 1.5
	
	
	var lastUpdateTime: TimeInterval?
	
	let skater = Skater (imageNamed: "skater")
	
    override func didMove(to view: SKView) {
		
		anchorPoint = CGPoint.zero
		
		let background = SKSpriteNode (imageNamed: "background")
		let xMid = frame.midX
		let yMid = frame.midY
		background.position = CGPoint (x: xMid, y: yMid)
		addChild(background)
		
		resetSkater()
		addChild(skater)
		
		let tapMethod = #selector(GameScene.handleTap(tapGesture:))
		let tapGesture = UITapGestureRecognizer(target: self, action: tapMethod)
		view.addGestureRecognizer(tapGesture)
		
		
		
		
        }
	
	func resetSkater () {
		let skaterX = frame.midX / 7.0
		let skaterY = skater.frame.height // 2.0 + 65
		skater.position = CGPoint (x: skaterX, y: skaterY)
		skater.zPosition = 10
		skater.minimumY = skaterY
		
	}
	
	func spawnBricks (atPosition position: CGPoint) -> SKSpriteNode {
		let brick = SKSpriteNode(imageNamed: "sidewalk")
		brick.position = position
		brick.zPosition = 8
		addChild(brick)
		
		bricksSize = brick.size
		
		bricks.append(brick)
		
		return brick
	}
	
	func updateBricks(withScrollAmount currentScrollAmount: CGFloat) {
		var farthestRightBrickX:CGFloat = 0.0
		
		for brick in bricks {
			
			let newX = brick.position.x - currentScrollAmount
			
			if newX < -bricksSize.width{
				brick.removeFromParent()
				
				if let brickIndex = bricks.index(of: brick){
					bricks.remove(at: brickIndex)
				}
			} else {
				brick.position = CGPoint (x: newX, y: brick.position.y)
				
				
				if brick.position.x > farthestRightBrickX {
					farthestRightBrickX = brick.position.x
				}
			}
			
		}
		
		
		while farthestRightBrickX < frame.width {
			var brickX = farthestRightBrickX + bricksSize.width + 1.0
			let brickY = bricksSize.height / 2.0
			
			let randomNumber = arc4random_uniform(99)
			
			if randomNumber < 5 {
				let gap = 20.0 * scrollSpeed
				brickX += gap
				
			}
			
			let newBrick = spawnBricks(atPosition: CGPoint(x: brickX, y: brickY))
			farthestRightBrickX = newBrick.position.x
			
		}
		
	}
	
    override func update(_ currentTime: TimeInterval) {
		
		var elapsedTime:TimeInterval = 0.0
		
		if let lastTimeStamp = lastUpdateTime {
			elapsedTime = currentTime - lastTimeStamp
		}
		
		lastUpdateTime = currentTime
		
		let expectedElapsedTime: TimeInterval = 1.0 / 60.0
		
		let scrollAdjustment = CGFloat (elapsedTime / expectedElapsedTime)
		let currentScrollAmount = scrollSpeed * scrollAdjustment
		
		updateBricks(withScrollAmount: currentScrollAmount)
		
    }
	
	@objc func handleTap(tapGesture: UITapGestureRecognizer){
		if skater.isOnGround {
			skater.velocity = CGPoint(x: 0.0, y: skater.jumpSpead)
			skater.isOnGround = false
		}
	}
	
}
