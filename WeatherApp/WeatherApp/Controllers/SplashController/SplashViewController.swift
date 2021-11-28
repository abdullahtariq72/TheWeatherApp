//
//  ViewController.swift
//  WeatherApp
//
//  Created by Abdullah Tariq on 11/26/21.
//

import UIKit
import SwiftGifOrigin
import Lottie
import SSCustomTabbar

class SplashViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var gifAnimationView: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
         Initiate Views for Controller*/
        setViews()
        
        /**
         Navigate to Dashboard View Controller*/
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            let tabBarVC = Storyboards.MAIN.instantiateViewController(withIdentifier: Controllers.TABBR_VC) as! SSCustomTabBarViewController
            tabBarVC.view.layoutIfNeeded()
            AppUtility.keyWindow!.rootViewController = tabBarVC
            AppUtility.keyWindow!.makeKeyAndVisible()
        }
    }
    
    // MARK: - SetupControllerViews
    func setViews(){
        configureLottieAnimation()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - SetupAnimationLogo
    func configureLottieAnimation(){
        let animation = Animation.named("weatherAnimate")
        gifAnimationView.contentMode = .scaleAspectFill
        gifAnimationView.animation = animation
        gifAnimationView.loopMode = .loop
        gifAnimationView.play()
    }
}

