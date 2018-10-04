//
//  GameViewController.swift
//  InvadeSpace
//
//  Created by Cartwheel Galaxy on 5/04/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.

import UIKit
import SpriteKit
import GameplayKit
import Lottie
import Device_swift
import GoogleMobileAds


//banner definition
var bannerView: GADBannerView!

class GameViewController: UIViewController, GADBannerViewDelegate  {
    var value:Double = 1.0
    var timerIntro = Timer()
    let deviceType = UIDevice.current.deviceType
    var intro = LOTAnimationView()
    var contador: Int = 0
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = false
        
        //add banner to a subview and request it
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-5267056163100832/5401230956"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        //present banner
        addBannerViewToView(bannerView)
        
        if deviceType == .iPad || deviceType == .iPad2 || deviceType == .iPadMini ||  UIDevice.current.userInterfaceIdiom == .phone{
             intro = LOTAnimationView(name: "IntroInvade_Space")
        }else{
            intro = LOTAnimationView(name: "IntroInvade_SpaceIpad")
        }
        
        intro.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        intro.contentMode = .scaleAspectFill
        self.view.addSubview(intro)
        intro.play{ (finished) in
            
            self.timerIntro = Timer.scheduledTimer(timeInterval: 0.10, target: self, selector: #selector(self.introTimer), userInfo: nil, repeats: true)
        }
        print("ESTE ES EL CONTADOR", (contador))
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
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
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
    
   //function to display the banner
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .top,
                                relatedBy: .equal,
                                toItem: topLayoutGuide,
                                attribute: .bottom,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
    
}
