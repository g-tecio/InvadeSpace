//
//  GameViewController.swift
//  InvadeSpace
//
//  Created by Herbeyg Robledo Reyes on 8/28/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import Lottie


class GameViewController: UIViewController {
    var value:Double = 1.0
    var timerIntro = Timer()
    let intro = LOTAnimationView(name: "IntroInvade_Space")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = false
        
        intro.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        intro.contentMode = .scaleAspectFill
        self.view.addSubview(intro)
        intro.play{ (finished) in
            
            self.timerIntro = Timer.scheduledTimer(timeInterval: 0.10, target: self, selector: #selector(self.introTimer), userInfo: nil, repeats: true)
        }
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            
            if let scene = SKScene(fileNamed: "MenuScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
        }
        
        
        
    }
    
    @objc func introTimer() {
        value = value - 0.1
        intro.alpha = CGFloat(value)
        if self.value < 0.1 {
            self.timerIntro.invalidate()
            self.view.isUserInteractionEnabled = true
            self.intro.removeFromSuperview()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
