//
//  ParentalGate.swift
//  InvadeSpace
//
//  Created by Herbeyg Robledo Reyes on 10/23/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import Device_swift
import Lottie

var puzzleSolved = false

struct ColliderType {
    
    static let circleIntro: UInt32 = 1
    static let triangleIntro: UInt32 = 1
    static let squareIntro: UInt32 = 2
    static let squareFake: UInt32 = 2
}

class ParentalGate: SKScene, SKPhysicsContactDelegate {
    
    var triangle: SKSpriteNode!
    var circle: SKSpriteNode!
    var square: SKSpriteNode!
    var drag: SKSpriteNode!
    var ask: SKSpriteNode!
    var inside: SKSpriteNode!
    
    var square1: SKSpriteNode!
    var square2: SKSpriteNode!
    var square3: SKSpriteNode!
    var square4: SKSpriteNode!
    
    var firstBody = SKPhysicsBody()
    var secondBody = SKPhysicsBody()
    
    var isFingerOnCircle = false
    var isFingerOnTriangle = false
    
    
    let deviceType = UIDevice.current.deviceType
    
    override func didMove(to view: SKView) {
        
        bannerView.isHidden = true
        self.physicsWorld.contactDelegate = self
        self.scaleMode = SKSceneScaleMode.fill
        
        backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        
        if deviceType == .iPad || deviceType == .iPad2 || deviceType == .iPadMini ||  UIDevice.current.userInterfaceIdiom == .phone {
            
            triangle = SKSpriteNode(imageNamed: "triangle")
            triangle.zPosition = 5
            triangle.position = CGPoint(
                x: (self.size.width * 1/4),
                y: (self.size.height * (((145 + (450 / 2)) / 1080 ) * 100) / 100))
            
            triangle.size = CGSize(
                width: (300 * (self.size.width / 300)*(((300/1080)*100)/100)),
                height: (300 * (self.size.height / 300)*(((300/1920)*100)/100)))
            
            triangle.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
            triangle.physicsBody?.affectedByGravity = false
            triangle.physicsBody?.isDynamic = false
            triangle.physicsBody!.collisionBitMask = 0
            triangle.physicsBody?.categoryBitMask = ColliderType.triangleIntro
            triangle.physicsBody?.collisionBitMask = ColliderType.squareIntro
            triangle.physicsBody?.contactTestBitMask = ColliderType.squareIntro
            
            
            circle = SKSpriteNode(imageNamed: "circle")
            circle.name = "Square"
            circle.zPosition = 5
            circle.position = CGPoint(
                x: (self.size.width * 3/4),
                y: (self.size.height * (((90 + (126)) / 1080 ) * 100) / 100))
            circle.size = CGSize(
                width: (350 * (self.size.width / 350)*(((350/1080)*100)/100)),
                height: (350 * (self.size.height / 350)*(((350/1920)*100)/100)))
            circle.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
            circle.physicsBody!.collisionBitMask = 0
            circle.physicsBody?.affectedByGravity = false
            circle.physicsBody?.isDynamic = false
            circle.physicsBody?.categoryBitMask = ColliderType.circleIntro
            circle.physicsBody?.collisionBitMask = ColliderType.squareIntro
            circle.physicsBody?.contactTestBitMask = ColliderType.squareIntro
            
            
            square = SKSpriteNode(imageNamed: "square")
            square.name = "Square"
            square.zPosition = 5
            square.position = CGPoint(
                x: (self.size.width * 3/4),
                y: (self.size.height * (((350 + (300)/2) / 1080 ) * 100) / 100))
            square.size = CGSize(
                width: (300 * (self.size.width / 300)*(((300/1080)*100)/100)),
                height: (300 * (self.size.height / 300)*(((300/1920)*100)/100)))
            
            square.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 100))
            square.physicsBody!.collisionBitMask = 0
            square.physicsBody?.affectedByGravity = false
            square.physicsBody?.categoryBitMask = ColliderType.squareIntro
            
            //ARRIBA
            square1 = SKSpriteNode(imageNamed: "squareInvisible")
            square1.name = "Square1"
            square1.zPosition = 5
            square1.position = CGPoint(
                x: (self.size.width * 3/4),
                y: (self.size.height * (((480 + (300)/2) / 1080 ) * 100) / 100))
            square1.size = CGSize(
                width: (300 * (self.size.width / 300)*(((300/1080)*100)/100)),
                height: (300 * (self.size.height / 300)*(((300/1920)*100)/100)))
            square1.physicsBody = SKPhysicsBody(rectangleOf: square1.frame.size)
            square1.physicsBody!.collisionBitMask = 0
            square1.physicsBody?.affectedByGravity = false
            square1.physicsBody?.categoryBitMask = ColliderType.squareFake
            
            //ABAJO
            square2 = SKSpriteNode(imageNamed: "squareInvisible")
            square2.name = "Square2"
            square2.zPosition = 5
            square2.position = CGPoint(
                x: (self.size.width * 3/4),
                y: (self.size.height * (((220 + (300)/2) / 1080 ) * 100) / 100))
            square2.size = CGSize(
                width: (300 * (self.size.width / 300)*(((300/1080)*100)/100)),
                height: (300 * (self.size.height / 300)*(((300/1920)*100)/100)))
            square2.physicsBody = SKPhysicsBody(rectangleOf: square2.frame.size)
            square2.physicsBody!.collisionBitMask = 0
            square2.physicsBody?.affectedByGravity = false
            square2.physicsBody?.categoryBitMask = ColliderType.squareFake
            
            //DERECHA
            square3 = SKSpriteNode(imageNamed: "squareInvisible")
            square3.name = "Square3"
            square3.zPosition = 5
            square3.position = CGPoint(
                x: (self.size.width * 3.85/4),
                y: (self.size.height * (((350 + (300)/2) / 1080 ) * 100) / 100))
            square3.size = CGSize(
                width: (300 * (self.size.width / 300)*(((300/1080)*100)/100)),
                height: (300 * (self.size.height / 300)*(((300/1920)*100)/100)))
            square3.physicsBody = SKPhysicsBody(rectangleOf: square3.frame.size)
            square3.physicsBody!.collisionBitMask = 0
            square3.physicsBody?.affectedByGravity = false
            square3.physicsBody?.categoryBitMask = ColliderType.squareFake
            
            //IZQUIERDA
            square4 = SKSpriteNode(imageNamed: "squareInvisible")
            square4.name = "Square4"
            square4.zPosition = 5
            square4.position = CGPoint(
                x: (self.size.width * 2.15/4),
                y: (self.size.height * (((350 + (300)/2) / 1080 ) * 100) / 100))
            square4.size = CGSize(
                width: (300 * (self.size.width / 300)*(((300/1080)*100)/100)),
                height: (300 * (self.size.height / 300)*(((300/1920)*100)/100)))
            square4.physicsBody = SKPhysicsBody(rectangleOf: square4.frame.size)
            square4.physicsBody!.collisionBitMask = 0
            square4.physicsBody?.affectedByGravity = false
            square4.physicsBody?.categoryBitMask = ColliderType.squareFake
            
            
            inside = SKSpriteNode(imageNamed: "circleInside")
            inside.zPosition = 5
            inside.position = CGPoint(
                x: (self.size.width * (((1566 + (126)) / 1920 ) * 100) / 100),
                y: (self.size.height * (((695 + (126)) / 1080 ) * 100) / 100))
            inside.size = square.size
            
            drag = SKSpriteNode(imageNamed: "publicityAdv_Ver")
            drag.zPosition = 5
            drag.position = CGPoint(
                x: (self.size.width / 2),
                y: (self.size.height * (((634 + (126)) / 1080 ) * 100) / 100))
            drag.size = CGSize(
                width: (950 * (self.size.width / 950)*(((950/1080)*100)/100)),
                height: (316 * (self.size.height / 316)*(((316/1920)*100)/100)))
            
            ask = SKSpriteNode(imageNamed: "askYourParents")
            ask.zPosition = 5
            ask.position = CGPoint(
                x:(self.size.width / 2),
                y: (self.size.height * (((900 + (96)) / 1080 ) * 100) / 100))
            ask.size = CGSize(
                width: (965 * (self.size.width / 965)*(((965/1080)*100)/100)),
                height: (75 * (self.size.height / 75)*(((75/1920)*100)/100)))
            
            
            
        }else {
            
            triangle = SKSpriteNode(imageNamed: "triangle")
            triangle.zPosition = 5
            triangle.position = CGPoint(
                x: (self.size.width * 1/4),
                y: (self.size.height * (((145 + (450 / 2)) / 1080 ) * 100) / 100))
            
            triangle.size = CGSize(
                width: (600 * (self.size.width / 600)*(((600/2048)*100)/100)),
                height: (600 * (self.size.height / 600)*(((600/2732)*100)/100)))

            
            circle = SKSpriteNode(imageNamed: "circle")
            circle.zPosition = 5
            circle.position = CGPoint(
                x: (self.size.width * 3/4),
                y: (self.size.height * (((30 + (126)) / 1080 ) * 100) / 100))
            circle.size = CGSize(
                width: (700 * (self.size.width / 700)*(((700/2048)*100)/100)),
                height: (700 * (self.size.height / 700)*(((700/2732)*100)/100)))
            
            circle.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
            circle.physicsBody!.collisionBitMask = 0
            circle.physicsBody?.affectedByGravity = false
            circle.physicsBody?.isDynamic = false
            circle.physicsBody?.categoryBitMask = ColliderType.circleIntro
            circle.physicsBody?.collisionBitMask = ColliderType.squareIntro
            circle.physicsBody?.contactTestBitMask = ColliderType.squareIntro
            
            square = SKSpriteNode(imageNamed: "square")
            square.zPosition = 5
            square.position = CGPoint(
                x: (self.size.width * 3/4),
                y: (self.size.height * (((360 + (300)/2) / 1080 ) * 100) / 100))
            square.size = CGSize(
                width: (600 * (self.size.width / 600)*(((600/2048)*100)/100)),
                height: (600 * (self.size.height / 600)*(((600/2732)*100)/100)))
            
            square.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 100))
            square.physicsBody!.collisionBitMask = 0
            square.physicsBody?.affectedByGravity = false
            square.physicsBody?.categoryBitMask = ColliderType.squareIntro
            
            //ARRIBA
            square1 = SKSpriteNode(imageNamed: "squareInvisible")
            square1.name = "Square1"
            square1.zPosition = 5
            square1.position = CGPoint(
                x: (self.size.width * 3/4),
                y: (self.size.height * (((525 + (300)/2) / 1080 ) * 100) / 100))
            square1.size = CGSize(
                width: (600 * (self.size.width / 600)*(((600/2048)*100)/100)),
                height: (600 * (self.size.height / 600)*(((600/2732)*100)/100)))
            square1.physicsBody = SKPhysicsBody(rectangleOf: square1.frame.size)
            square1.physicsBody!.collisionBitMask = 0
            square1.physicsBody?.affectedByGravity = false
            square1.physicsBody?.categoryBitMask = ColliderType.squareFake
            
            //ABAJO
            square2 = SKSpriteNode(imageNamed: "squareInvisible")
            square2.name = "Square2"
            square2.zPosition = 5
            square2.position = CGPoint(
                x: (self.size.width * 3/4),
                y: (self.size.height * (((195 + (300)/2) / 1080 ) * 100) / 100))
            square2.size = CGSize(
                width: (600 * (self.size.width / 600)*(((600/2048)*100)/100)),
                height: (600 * (self.size.height / 600)*(((600/2732)*100)/100)))
            square2.physicsBody = SKPhysicsBody(rectangleOf: square2.frame.size)
            square2.physicsBody!.collisionBitMask = 0
            square2.physicsBody?.affectedByGravity = false
            square2.physicsBody?.categoryBitMask = ColliderType.squareFake
            
            //DERECHA
            square3 = SKSpriteNode(imageNamed: "squareInvisible")
            square3.name = "Square3"
            square3.zPosition = 5
            square3.position = CGPoint(
                x: (self.size.width * 3.89/4),
                y: (self.size.height * (((360 + (300)/2) / 1080 ) * 100) / 100))
            square3.size = CGSize(
                width: (600 * (self.size.width / 600)*(((600/2048)*100)/100)),
                height: (600 * (self.size.height / 600)*(((600/2732)*100)/100)))
            square3.physicsBody = SKPhysicsBody(rectangleOf: square3.frame.size)
            square3.physicsBody!.collisionBitMask = 0
            square3.physicsBody?.affectedByGravity = false
            square3.physicsBody?.categoryBitMask = ColliderType.squareFake
            
            //IZQUIERDA
            square4 = SKSpriteNode(imageNamed: "squareInvisible")
            square4.name = "Square4"
            square4.zPosition = 5
            square4.position = CGPoint(
                x: (self.size.width * 2.11/4),
                y: (self.size.height * (((360 + (300)/2) / 1080 ) * 100) / 100))
            square4.size = CGSize(
                width: (600 * (self.size.width / 600)*(((600/2048)*100)/100)),
                height: (600 * (self.size.height / 600)*(((600/2732)*100)/100)))
            square4.physicsBody = SKPhysicsBody(rectangleOf: square4.frame.size)
            square4.physicsBody!.collisionBitMask = 0
            square4.physicsBody?.affectedByGravity = false
            square4.physicsBody?.categoryBitMask = ColliderType.squareFake
            
            inside = SKSpriteNode(imageNamed: "circleInside")
            inside.zPosition = 5
            inside.position = CGPoint(
                x: (self.size.width * (((2200 + (126)) / 2048 ) * 100) / 100),
                y: (self.size.height * (((1268 + (252)) / 2732 ) * 100) / 100))
            inside.size = square.size
            
            drag = SKSpriteNode(imageNamed: "publicityAdv_Ver")
            drag.zPosition = 5
            drag.position = CGPoint(
                x: (self.size.width / 2),
                y: (self.size.height * (((1268 + (252)) / 2048 ) * 100) / 100))
            
            drag.size = CGSize(
                width: (1898 * (self.size.width / 1898)*(((1898/2048)*100)/100)),
                height: (632 * (self.size.height / 632)*(((632/2732)*100)/100)))
            
            
            ask = SKSpriteNode(imageNamed: "askYourParents")
            ask.zPosition = 5
            ask.position = CGPoint(
                x:(self.size.width / 2),
                y: (self.size.height * (((1800 + (96)) / 2048 ) * 100) / 100))
            
            ask.size = CGSize(
                width: (1929 * (self.size.width / 1929)*(((1929/2048)*100)/100)),
                height: (150 * (self.size.height / 150)*(((150/2732)*100)/100)))
            
            
        }

        
        self.addChild(triangle)
        self.addChild(circle)
        self.addChild(square)
        self.addChild(drag)
        self.addChild(ask)
        
        self.addChild(square1)
        self.addChild(square2)
        self.addChild(square3)
        self.addChild(square4)
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.node?.name == circle.name {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
    }
    
    func checar() {
        
        if circle.name == firstBody.node?.name  && secondBody.node?.name == square.name {
            print("Contact detected")

            
            if deviceType == .iPad || deviceType == .iPad2 || deviceType == .iPadMini ||  UIDevice.current.userInterfaceIdiom == .phone {
                circle.size = CGSize(
                    width: (300 * (self.size.width / 300)*(((300/1920)*80)/100)),
                    height: (300 * (self.size.height / 300)*(((300/1080)*80)/100)))
                
            }else{
                circle.size = CGSize(
                    width: (700 * (self.size.width / 700)*(((700/2048)*70)/100)),
                    height: (700 * (self.size.height / 700)*(((700/2732)*70)/100)))
            }
            
            
            
            let transition = SKTransition.fade(with: UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.0), duration: 3.2)
            let parentalGate = SKScene(fileNamed: "MenuScene") as! MenuScene
            parentalGate.scaleMode = SKSceneScaleMode.fill
            self.view!.presentScene(parentalGate, transition: transition)
            
            bannerView.isHidden = true
            square.texture = SKTexture(imageNamed:"circleInside")
            circle.isHidden = true
            puzzleSolved = true
            savedValues()
            
        }else{
            

            
            if deviceType == .iPad || deviceType == .iPad2 || deviceType == .iPadMini ||  UIDevice.current.userInterfaceIdiom == .phone {
                circle.position = CGPoint(
                    x: (self.size.width * 3/4),
                    y: (self.size.height * (((90 + (126)) / 1080 ) * 100) / 100))
                
            }else{
                circle.position = CGPoint(
                    x: (self.size.width * 3/4),
                    y: (self.size.height * (((30 + (126)) / 1080 ) * 100) / 100))
            }
            
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            if circle.frame.contains(location) {
                circle.position.x = location.x
                circle.position.y = location.y
                isFingerOnCircle = true

                
                if deviceType == .iPad || deviceType == .iPad2 || deviceType == .iPadMini ||  UIDevice.current.userInterfaceIdiom == .phone {
                    circle.size = CGSize(
                        width: (300 * (self.size.width / 300)*(((300/1080)*80)/100)),
                        height: (300 * (self.size.height / 300)*(((300/1920)*80)/100)))
                    
                }else{
                    circle.size = CGSize(
                        width: (700 * (self.size.width / 700)*(((700/2048)*70)/100)),
                        height: (700 * (self.size.height / 700)*(((700/2732)*70)/100)))
                }
            }
        }
        
        for touch in touches {
            let location = touch.location(in: self)
            if triangle.frame.contains(location) {
                triangle.position = location
                isFingerOnTriangle = true

                
                if deviceType == .iPad || deviceType == .iPad2 || deviceType == .iPadMini ||  UIDevice.current.userInterfaceIdiom == .phone {
                    
                    triangle.size = CGSize(
                        width: (300 * (self.size.width / 300)*(((300/1080)*80)/100)),
                        height: (300 * (self.size.height / 300)*(((300/1920)*80)/100)))
                    
                }else{
                    triangle.size = CGSize(
                        width: (600 * (self.size.width / 600)*(((600/2048)*70)/100)),
                        height: (600 * (self.size.height / 600)*(((600/2732)*70)/100)))
                }
                
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if isFingerOnCircle {
            let touch = touches.first
            let touchLocation = touch!.location(in: self)
            let previousLocation = touch!.previousLocation(in: self)
            
            var circleX = circle.position.x + (touchLocation.x - previousLocation.x)
            var circleY = circle.position.y + (touchLocation.y - previousLocation.y)
            
            circleX = max(circleX, circle.size.width/2)
            circleX = min(circleX, size.width - circle.size.width/2)
            
            circleY = max(circleY, circle.size.width/2)
            circleY = min(circleY, size.width - circle.size.width/2)
            
            
            circle.position = CGPoint(x: circleX, y: circleY)
        }
        
        if isFingerOnTriangle {
            let touch = touches.first
            let touchLocation = touch!.location(in: self)
            let previousLocation = touch!.previousLocation(in: self)
            
            var triangleX = triangle.position.x + (touchLocation.x - previousLocation.x)
            var triangleY = triangle.position.y + (touchLocation.y - previousLocation.y)
            
            triangleX = max(triangleX, triangle.size.width/2)
            triangleX = min(triangleX, size.width - triangle.size.width/2)
            
            triangleY = max(triangleY, triangle.size.width/2)
            triangleY = min(triangleY, size.width - triangle.size.width/2)
            
            
            triangle.position = CGPoint(x: triangleX, y: triangleY)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        checar()
        isFingerOnCircle = false
        isFingerOnTriangle = false
        
  
        
            if deviceType == .iPad || deviceType == .iPad2 || deviceType == .iPadMini ||  UIDevice.current.userInterfaceIdiom == .phone {
                triangle.position = CGPoint(
                    x: (self.size.width * 1/4),
                    y: (self.size.height * (((145 + (450 / 2)) / 1080 ) * 100) / 100))
                
                triangle.size = CGSize(
                    width: (300 * (self.size.width / 300)*(((300/1080)*100)/100)),
                    height: (300 * (self.size.height / 300)*(((300/1920)*100)/100)))
                
                circle.size = CGSize(
                    width: (350 * (self.size.width / 350)*(((350/1080)*100)/100)),
                    height: (350 * (self.size.height / 350)*(((350/1920)*100)/100)))
                    
            }else{
                triangle.position = CGPoint(
                    x: (self.size.width * 1/4),
                    y: (self.size.height * (((145 + (450 / 2)) / 1080 ) * 100) / 100))
                
                triangle.size = CGSize(
                    width: (600 * (self.size.width / 600)*(((600/2048)*100)/100)),
                    height: (600 * (self.size.height / 600)*(((600/2732)*100)/100)))
                
                circle.size = CGSize(
                    width: (700 * (self.size.width / 700)*(((700/2048)*100)/100)),
                    height: (700 * (self.size.height / 700)*(((700/2732)*100)/100)))
            }
    }
    
    func savedValues() {
        
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(puzzleSolved, forKey: "puzzleSolvedKey")
        
        let puzzleSolvedValue = userDefaults.integer(forKey: "puzzleSolvedKey")
        print("Is the puzzle solved?: \(puzzleSolvedValue)")
        
    }
    
}
