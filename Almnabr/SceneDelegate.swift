//
//  SceneDelegate.swift
//  Almnabr
//
//  Created by MacBook on 22/09/2021.
//

import UIKit
import FAPanels
import LocalAuthentication
import IQKeyboardManagerSwift


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func get_theme(){
        
        APIController.shard.sendRequestGetAuthTheme(urlString: "gettheme" ) { (response) in
            
            let status = response["status"] as? Bool
            if status == true{
                if  let data = response["data"] as? [String:Any]{
                    let obj = themeObj(data)
                    HelperClassSwift.acolor = obj.acolor
                    HelperClassSwift.bcolor = obj.bcolor
                }
            }else{
                HelperClassSwift.acolor = "#1992bc"
                HelperClassSwift.bcolor = "#000000"
            }
        }
    }
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate{
            delegate.window = self.window
        }
        
        HelperClassSwift.IsLoggedOut = false
        
        maybeOpenedFromWidget(urlContexts: connectionOptions.urlContexts)
        //NewSuccessModel.removeLoginSuccessToken()
        
        
    }
    
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        maybeOpenedFromWidget(urlContexts: URLContexts)
    }
    
    
    private func maybeOpenedFromWidget(urlContexts: Set<UIOpenURLContext>) {
        DispatchQueue.main.async {
            
            IQKeyboardManager.shared.enable = true
            if NewSuccessModel.getLoginSuccessToken() != nil {
                if let _: UIOpenURLContext = urlContexts.first(where: { $0.url.scheme == "widget-deeplink" }) {
                    self.GoToHome(isFromWidget: true)
                } else {
                    self.CheckActiveTime()
                }
            }else{
                self.GoToSignIn()
            }
            
            self.isUpdateAvailable { update in
                if update {
                    self.showUpdateAlert()
                }
            }
        }
    }
    
    
    
    func GoToHome(isFromWidget:Bool){
        
        if isFromWidget{
            
            let qrScannerVC = QRScannerViewController()
            qrScannerVC.isFromWidget = true
            let nav = UINavigationController.init(rootViewController: qrScannerVC)
            window?.rootViewController = nav
            UIView.transition(with: window!, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
            
        }else{
            let vc = AppDelegate.mainSB.instantiateViewController(withIdentifier: "HomeVC")
            
            let nav = UINavigationController.init(rootViewController: vc)
            let sideMenu: MenuVC = AppDelegate.mainSB.instanceVC()
            let rootController : FAPanelController = AppDelegate.mainSB.instanceVC()
            let center : MenuVC = AppDelegate.mainSB.instanceVC()
            
            _ = rootController.center(nav).right(center).left(sideMenu)
            rootController.rightPanelPosition = .front
            rootController.leftPanelPosition = .front
            
            // rootController.configs.rightPanelWidth = (window?.frame.size.width)!
            let width = UIScreen.main.bounds.width - 150
            
            
            rootController.configs.leftPanelWidth = width
            rootController.configs.rightPanelWidth = width
            
            rootController.configs.maxAnimDuration = 0.3
            rootController.configs.canRightSwipe = true
            rootController.configs.canLeftSwipe = true
            rootController.configs.changeCenterPanelAnimated = false
            window?.rootViewController = rootController
            UIView.transition(with: window!, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
        
        
        
    }
    
    private func showUpdateAlert(){
        let vc = AppUpdateVC()
        vc.updateButtonAction = {
            if let url = URL(string: "https://apps.apple.com/us/app/almnabr/id1621889347") {
                    UIApplication.shared.open(url)
            }
        }
        
        if let panel = window?.rootViewController as? FAPanelController,let rootNav = panel.center as?  UINavigationController{
            rootNav.pushViewController(vc, animated: true)
        }else if let rootNav = window?.rootViewController as? UINavigationController{
            rootNav.pushViewController(vc, animated: true)
        }
    }
    
    
    
    func GoToSignIn(){
        // guard let window = UIApplication.shared.keyWindow else {return}
        
        let vc : SignInVC = AppDelegate.mainSB.instanceVC()
        let rootNC = UINavigationController(rootViewController: vc)
        window?.rootViewController = rootNC
        window?.makeKeyAndVisible()
//        UIView.transition(with: window!, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func CheckActiveTime(){
        
        guard let lastOpened = UserDefaults.standard.object(forKey: "LastOpened") as? Date else {
            GoToHome(isFromWidget: false)
            return
        }
        let elapsed = Calendar.current.dateComponents([.minute], from: lastOpened, to: Date())
        print(elapsed)
        
        if elapsed.minute! > 30 {
            let context = LAContext()
            var error: NSError? = nil
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
                let reason = "Please authorize with touch id "
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){ success, error in
                    if success {
                        
                        // Move to the main thread because a state update triggers UI changes.
                        DispatchQueue.main.async { [unowned self] in
                            print("success")
                            GoToHome(isFromWidget: false)
                            //self.login(Username: HelperClassSwift.UserName , Password: HelperClassSwift.UserPassword )
                        }}else{
                            DispatchQueue.main.async { [unowned self] in
                                self.GoToSignIn()
                                print("nil")
                            }
                        }
                }
            }else{
                GoToHome(isFromWidget: false)
                // Auth_User.topVC()!.showAMessage(withTitle: "Unavailabel", message: "You Can't use This Feature")
            }
        }else{
            GoToHome(isFromWidget: false)
        }
    }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        UserDefaults.standard.set(Date(), forKey: "LastOpened")
        
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
        UserDefaults.standard.set(Date(), forKey: "LastOpened")
        guard let lastOpened = UserDefaults.standard.object(forKey: "LastOpened") as? Date else {
            return
        }
        let elapsed = Calendar.current.dateComponents([.minute], from: lastOpened, to: Date())
        print(elapsed)
        HelperClassSwift.IsLoadTheme = false
        
        SocketIOController.shard.disconnect()
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        UserDefaults.standard.set(Date(), forKey: "LastOpened")
    }
    
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        guard let lastOpened = UserDefaults.standard.object(forKey: "LastOpened") as? Date else {
            return
        }
        let elapsed = Calendar.current.dateComponents([.hour], from: lastOpened, to: Date())
        print(elapsed)
        HelperClassSwift.IsLoadTheme = false
    
    }
    
    
}


// MARK: - Check App Update From App Store
extension SceneDelegate{
    func isUpdateAvailable(thereIsUpdate:@escaping (Bool)->Void){
        guard let info = Bundle.main.infoDictionary,
              let currentVersion = info["CFBundleShortVersionString"] as? String else {
            return
        }
        
        APIController.shard.getCurrentVersion { response in
            if let version = response.results?.first?.version {
                thereIsUpdate(version != currentVersion)
            }
        }
    }
}

enum VersionError: Error {
    case invalidResponse, invalidBundleInfo
}
    
