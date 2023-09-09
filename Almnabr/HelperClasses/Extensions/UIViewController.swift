//
//  UIViewController.swift
//  Almnabr
//
//  Created by MacBook on 23/09/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import Foundation
import ZVProgressHUD
import DPLocalization

extension UIViewController {
    
    

    func showAMessage(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title.localized(), message: message.localized(), preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "ok".localized(), style: .default) { action in
            print("You've pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAMessage(withTitle title: String, message : String, completion:@escaping () -> Void) {
        let alertController = UIAlertController(title: title.localized(), message: message.localized(), preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "ok".localized(), style: .default) { action in
            print("You've pressed OK Button")
            completion()
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func showLoadingActivity() {
//        ZVProgressHUD.displayStyle = .dark
//        ZVProgressHUD.maskType = .black
//        ZVProgressHUD.strokeWith = 2.0
        ZVProgressHUD.show()
       // CustomLoader.sharedInstance.startAnimation()
    }
    
    @objc func hideLoadingActivity() {
   //     CustomLoader.sharedInstance.stopAnimation()
        ZVProgressHUD.dismiss()
        
    }
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    func checkErrorMessageForUserLogout(responseErrorObject: ResponseModel) {
       
    }
    
    func formatedDate(date:Date?) ->String{
        let dateFormater = DateFormatter()
        dateFormater.locale = .init(identifier: "en")
        dateFormater.dateFormat = "YYYY/MM/dd"
        return date != nil ? dateFormater.string(from: date!) : ""
    }
    
    func formattedTime(date:Date?) -> String{
        let dateFormater = DateFormatter()
        dateFormater.locale = .init(identifier: "en")
        dateFormater.dateFormat = "hh:mm"
        return date != nil ? dateFormater.string(from: date!) : ""
    }
    
    func formatedDate2(date:Date?) ->String{
        let dateFormater = DateFormatter()
        dateFormater.locale = .init(identifier: "en")
        dateFormater.dateFormat = "EEEE, MMMM dd, YYYY"
        return date != nil ? dateFormater.string(from: date!) : ""
    }
    
    func getDateFromString(str:String) ->Date{
        let dateFormater = DateFormatter()
        dateFormater.locale = .init(identifier: "en")
        dateFormater.dateFormat = "YYYY/MM/dd"
        return dateFormater.date(from: str) ?? Date()
    }
    
    func formatedDate3(date:Date) ->String{
        let dateFormater = DateFormatter()
        dateFormater.locale = .init(identifier: "en")
        dateFormater.dateFormat = "dd/MM/YYYY"
        return dateFormater.string(from: date)
    }
    
    
    func makeUserLogout() {
        if NewSuccessModel.getLoginSuccessToken() != nil {
            self.hideLoadingActivity()
            UIApplication.shared.applicationIconBadgeNumber = 0

            NewSuccessModel.removeLoginSuccessToken()
            puplic_total = 0 
            guard let window = UIApplication.shared.keyWindow else {return}
           
            let vc : SignInVC = AppDelegate.mainSB.instanceVC()
            let rootNC = UINavigationController(rootViewController: vc)
            window.rootViewController = rootNC
            window.makeKeyAndVisible()

        }
    }
    
    
    func addNavigationBarTitle(navigationTitle: String) {
        let lblNavigationTile = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        lblNavigationTile.textAlignment = .center
        //lblNavigationTile.backgroundColor = .clear
        lblNavigationTile.textColor = .white
        lblNavigationTile.font = .kufiBoldFont(ofSize: 15)
        lblNavigationTile.text = navigationTitle.localized()
        lblNavigationTile.frame = CGRect(x: 0, y: 0, width: 120, height: 30)
        
        
        let barImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 82, height: 30))
        //barImage.image = UIImage(named: "icon_nav_bar.png")
        self.navigationItem.titleView = lblNavigationTile
    }
    
    func addNavigationBarTitlee(navigationTitle: String) {
        let lblNavigationTile = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        lblNavigationTile.textAlignment = .center
        //lblNavigationTile.backgroundColor = .clear
        lblNavigationTile.textColor = .white
        lblNavigationTile.font = .kufiRegularFont(ofSize: 15)
        lblNavigationTile.text = navigationTitle.localized()
        lblNavigationTile.frame = CGRect(x: 0, y: 0, width: 120, height: 30)
        
        
        let barImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 82, height: 30))
        //barImage.image = UIImage(named: "icon_nav_bar.png")
        self.navigationItem.titleView = lblNavigationTile
    }
    
    func addNavigationBarTitleColor(navigationTitle: String) {
        let lblNavigationTile = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        lblNavigationTile.textAlignment = .center
        //lblNavigationTile.backgroundColor = .clear
        lblNavigationTile.textColor = maincolor
        lblNavigationTile.font = .kufiBoldFont(ofSize: 15)
        lblNavigationTile.text = navigationTitle.localized()
        lblNavigationTile.frame = CGRect(x: 0, y: 0, width: 120, height: 30)
        
        
        let barImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 82, height: 30))
        //barImage.image = UIImage(named: "icon_nav_bar.png")
        self.navigationItem.titleView = lblNavigationTile
    }
    
    
    func addNavigationBarLeftButton() -> UIButton {
        let btnDone = UIButton(type: .custom)
        btnDone.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //btnDone.setTitleColor(GlobalClass.color(fromHexString: "272727"), for: .normal)
        btnDone.setImage(UIImage(named: "icon_nav_search"), for: .normal)
        btnDone.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        let doneBtn = UIBarButtonItem(customView: btnDone)
        self.navigationItem.rightBarButtonItem = doneBtn
        return btnDone
    }
    
    func isArabicSelected() -> Bool {
        return L102Language.currentAppleLanguage() == "ar"
    }
    
    
    
//    func showThanksView(title: String?, message: String?, imageName: String?) {
//        let confirmview = ConfirmationView(frame: (self.view.window?.bounds)!)
//        confirmview.alpha = 0
//        confirmview.btn.addTarget(self, action: #selector(hideThanksView_Click(_:)), for: .touchUpInside)
//
//        confirmview.lblTitle.text = title!.localized()
//        confirmview.lblMessage.text = message!.localized()
//        confirmview.img_icon.image = UIImage(named: imageName!)
//
//
//        self.view.window?.addSubview(confirmview)
//        self.view.window?.bringSubviewToFront(confirmview)
//        UIView.animate(withDuration: 0.35) {
//            confirmview.alpha = 1
//            confirmview.transform = CGAffineTransform(scaleX: 1, y: 1)
//        }
//    }
    
    
    @IBAction func hideThanksView_Click(_ sender: UIButton) {
        
        let confirmview = sender.superview?.superview?.superview
        confirmview!.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        confirmview!.alpha = 1
        UIView.animate(withDuration: 0.35, animations: {
            confirmview!.alpha = 0
            confirmview!.transform = CGAffineTransform(scaleX: 1, y: 1)
            confirmview!.removeFromSuperview()
        }) { (finished) in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
//    @objc func showThanksViewObjectiveC(title: String?, message: String?, imageName: String?) {
//        let confirmview = ConfirmationView(frame: (self.view.window?.bounds)!)
//        confirmview.alpha = 0
//        confirmview.btn.addTarget(self, action: #selector(hideThanksViewObjectiveC_Click(_:)), for: .touchUpInside)
//
//        confirmview.lblTitle.text = title!.localized()
//        confirmview.lblMessage.text = message!.localized()
//        confirmview.img_icon.image = UIImage(named: imageName!)
//
//
//        self.view.window?.addSubview(confirmview)
//        self.view.window?.bringSubviewToFront(confirmview)
//        UIView.animate(withDuration: 0.35) {
//            confirmview.alpha = 1
//            confirmview.transform = CGAffineTransform(scaleX: 1, y: 1)
//        }
//    }
    
    
    @objc func hideThanksViewObjectiveC_Click(_ sender: UIButton) {
        
        let confirmview = sender.superview?.superview?.superview
        confirmview!.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        confirmview!.alpha = 1
        UIView.animate(withDuration: 0.35, animations: {
            confirmview!.alpha = 0
            confirmview!.transform = CGAffineTransform(scaleX: 1, y: 1)
            confirmview!.removeFromSuperview()
        }) { (finished) in
        }
    }
}



extension Date {
    
    
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
}

    
extension UIView{
    
    
    @objc func showLoadingActivity() {
//        ZVProgressHUD.displayStyle = .dark
//        ZVProgressHUD.maskType = .black
//        ZVProgressHUD.strokeWith = 2.0
        ZVProgressHUD.show()
    }
    
    @objc func hideLoadingActivity() {
        ZVProgressHUD.dismiss()
    }
    
}

extension UIViewController {

func switchRootViewController(rootViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        guard let window = UIApplication.shared.keyWindow else { return }
        if animated {
            UIView.transition(with: window, duration: 0.3
                , options: .transitionCrossDissolve, animations: {
                    let oldState: Bool = UIView.areAnimationsEnabled
                    UIView.setAnimationsEnabled(false)
                    let navController = UINavigationController.init(rootViewController: rootViewController)
                    navController.navigationBar.isHidden = true
                    window.rootViewController = navController
                    UIView.setAnimationsEnabled(oldState)
            }, completion: { (finished: Bool) -> () in
                if (completion != nil) {
                    completion!()
                }
            })
        } else {
            window.rootViewController = rootViewController
        }
    }
}
