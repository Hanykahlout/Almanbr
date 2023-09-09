//
//  ViewController.swift
//  Almnabr
//
//  Created by MacBook on 22/09/2021.
//

import UIKit
import FAPanels

class ViewController: UIViewController {
  

    override func viewDidLoad() {
        super.viewDidLoad()
        //NewSuccessModel.removeLoginSuccessToken()
    // self.goToScreens()
    }
    
     func goToScreens() {
        if NewSuccessModel.getLoginSuccessToken() == nil {
            guard let window = UIApplication.shared.windows.first else {return}
           
            let vc : SignInVC = AppDelegate.mainSB.instanceVC()
            let rootNC = UINavigationController(rootViewController: vc)
            window.rootViewController = rootNC
            window.makeKeyAndVisible()
//            let aViewController = SignInViewController(nibName: "SignInViewController", bundle: nil)
//             navigationController?.pushViewController(aViewController, animated: true)
            
           // let vc:SignInVC = AppDelegate.mainSB.instanceVC()
//            let signInViewController = SignInVC()
//            let navController = UINavigationController(rootViewController: signInViewController)
//
//            navController.modalTransitionStyle = .crossDissolve
//            navController.modalPresentationStyle = .fullScreen
//
//            self.present(navController, animated: true, completion: {
//            })
          
           // self.navigationController?.pushViewController(vc, animated: true)
           //self.present(vc, animated: true, completion: nil)
        } else {
            
            print("no")
            
            let NavigationNewsandactivity : HomeVC = AppDelegate.mainSB.instanceVC()
//            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            let faPanelController = AppDelegate.mainSB.instantiateViewController(withIdentifier: "FAPanelController") as! FAPanelController
            let SRSliderTVC = AppDelegate.mainSB.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
            faPanelController.configs.centerPanelTransitionType = .curlUp
            
            faPanelController.configs.centerPanelTransitionDuration = 0.60
            _ = faPanelController.center(NavigationNewsandactivity).right(SRSliderTVC)
            faPanelController.configs.rightPanelWidth = UIScreen.main.bounds.size.width - 50
            faPanelController.configs.bounceOnRightPanelOpen = false
            faPanelController.rightPanelPosition = .front
//            newViewController.modalTransitionStyle = .crossDissolve
//            newViewController.modalPresentationStyle = .fullScreen
            // window?.rootViewController = faPanelController
            
//            let homeVC = HomeVC()
//            let navController = UINavigationController(rootViewController: homeVC)
//            navController.modalTransitionStyle = .crossDissolve
//            navController.modalPresentationStyle = .fullScreen
//            self.present(navController, animated: true, completion: {
//            })
            
//            let homeVC = HomeVC()
//            let navController = UINavigationController(rootViewController: homeVC)
//
//            navController.modalTransitionStyle = .crossDissolve
//            navController.modalPresentationStyle = .fullScreen
//
//            self.present(navController, animated: true, completion: {
//            })
            
//            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
//            newViewController.modalTransitionStyle = .crossDissolve
//            newViewController.modalPresentationStyle = .fullScreen
//            self.present(newViewController, animated: true, completion: {
//            })
        }
    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    
}


