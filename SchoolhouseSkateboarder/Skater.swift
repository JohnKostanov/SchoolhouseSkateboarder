//
//  Skater.swift
//  SchoolhouseSkateboarder
//
//  Created by Andrian Kryk on 1/6/19.
//  Copyright © 2019 Andrian Kryk. All rights reserved.
//

import SpriteKit

class Skater: SKSpriteNode {

	var velocity = CGPoint.zero
	var minimumY: CGFloat = 0.0
	var jumpSpead: CGFloat = 20.0
	var isOnGround = true
	
	func setupPhysicBody() {
		if let skaterTexture = texture {
			physicsBody = SKPhysicsBody (texture: skaterTexture, size: size)
			physicsBody?.isDynamic = true
			physicsBody?.density = 6.0
			physicsBody?.allowsRotation = true
			physicsBody?.angularDamping = 1.0
			
			physicsBody?.categoryBitMask = PhysicsCategory.skater
			physicsBody?.collisionBitMask = PhysicsCategory.brick
			physicsBody?.contactTestBitMask = PhysicsCategory.brick | PhysicsCategory.gem
			
		}
	}
	
}

