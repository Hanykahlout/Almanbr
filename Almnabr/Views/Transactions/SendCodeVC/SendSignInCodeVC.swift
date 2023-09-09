//
//  SendSignInCodeVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 28/07/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
import FAPanels

class SendSignInCodeVC: UIViewController {

    @IBOutlet weak var emailCheckImageView: UIImageView!
    @IBOutlet weak var mobileCheckImageView: UIImageView!
    @IBOutlet weak var whatsappCheckImageView: UIImageView!

    @IBOutlet weak var codeStackView: UIStackView!
    @IBOutlet weak var emailStackView: UIStackView!
    @IBOutlet weak var mobileStackView: UIStackView!
    @IBOutlet weak var whatsappStackView: UIStackView!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var sendCodeButton: UIButton!
    @IBOutlet weak var sendCodeView: UIView!
    
    private var senderType = ""
    
    var username:String = ""
    var password:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iniltization()
    }
    
    
    private func iniltization(){
        setUpSelectionStacks()
        addNavigationBarTitle(navigationTitle: "Verification Code".localized())
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    
    private func setUpSelectionStacks(){
        emailStackView.addTapGesture {
            self.changeCheckStatus(imageView: self.emailCheckImageView,status: true)
            self.changeCheckStatus(imageView: self.mobileCheckImageView,status: false)
            self.changeCheckStatus(imageView: self.whatsappCheckImageView,status: false)
            self.senderType = "email"
            self.sendCodeView.isHidden = false
            self.codeStackView.isHidden = true
        }
        
        mobileStackView.addTapGesture {
            self.changeCheckStatus(imageView: self.emailCheckImageView,status: false)
            self.changeCheckStatus(imageView: self.mobileCheckImageView,status: true)
            self.changeCheckStatus(imageView: self.whatsappCheckImageView,status: false)
            self.senderType = "mobile"
            self.sendCodeView.isHidden = false
            self.codeStackView.isHidden = true
        }
        
        whatsappStackView.addTapGesture {
            self.changeCheckStatus(imageView: self.emailCheckImageView,status: false)
            self.changeCheckStatus(imageView: self.mobileCheckImageView,status: false)
            self.changeCheckStatus(imageView: self.whatsappCheckImageView,status: true)
            self.senderType = "whatsapp"
            self.sendCodeView.isHidden = false
            self.codeStackView.isHidden = true
        }
        
    }
    
    private func changeCheckStatus(imageView:UIImageView,status:Bool){
        if status{
            imageView.image = UIImage(named: "check")
            imageView.tag = 1
        }else{
            imageView.image = UIImage(named: "uncheck")
            imageView.tag = 0
        }
    }
    
    
    @IBAction func sendCodeAction(_ sender: Any) {
        sendCode()
    }
    
    
    @IBAction func submitTextFiled(_ sender: Any) {
        self.login(code:self.codeTextField.text!,Username: self.username, Password: self.password)
    }
    
}

// MARK: - APIHandling
extension SendSignInCodeVC{
    private func sendCode(){
        showLoadingActivity()
        APIController.shard.sendCode(username: username , password: password, senderType: senderType) { data in
            self.hideLoadingActivity()
            if let status = data.status,status{
                self.codeStackView.isHidden = false
                self.showAMessage(withTitle: "Verify Account".lowercased(), message: "\("Please, enter the verification code sent to your".localized()) \(self.senderType)")
            }else{
                SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
            }
        }
    }
    
    private func GoToHome(){
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else {return}
        let vc : HomeVC = AppDelegate.mainSB.instanceVC()
        let nav = UINavigationController.init(rootViewController: vc)
        let sideMenu: MenuVC = AppDelegate.mainSB.instanceVC()
        let rootController : FAPanelController = AppDelegate.mainSB.instanceVC()
        let center : MenuVC = AppDelegate.mainSB.instanceVC()
        
        _ = rootController.center(nav).right(center).left(sideMenu)
        rootController.rightPanelPosition = .front
        rootController.leftPanelPosition = .front
        // rootController.configs.rightPanelWidth = (window?.frame.size.width)!
        let width = UIScreen.main.bounds.width - 80
        
        
        rootController.configs.leftPanelWidth = width
        rootController.configs.rightPanelWidth = width
        
        rootController.configs.maxAnimDuration = 0.3
        rootController.configs.canRightSwipe = false
        rootController.configs.canLeftSwipe = false
        rootController.configs.changeCenterPanelAnimated = false
        window.rootViewController = rootController
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
//    https://nahidh.sa/backend/form/FORM_WIR/cr/3/0
    }
    
    
    private func login(code:String,Username:String , Password:String){
        
        showLoadingActivity()
        
        var fcmToken = ""
        var language = ""
        
        if let fcm_token = HelperClassSwift.getUserInformation(key: Constants.DEFINEFCMDEVICETOKEN){
            fcmToken = fcm_token
        }
        
        
        
        let params = ["username" : Username,
                      "password" : Password,
                      "noti_registrationId": "\(Auth_User.FCMtoken)",
                      "language": L102Language.currentAppleLanguage(),
                      "platform":"ios",
                      "verification_code": code
        
        ]
        
        
        APIController.shard.postAnyData(queryString: "login", parameters: params ) { (responseObject, error) in
            self.hideLoadingActivity()
            
            if responseObject.error != nil && (responseObject.error?.count)! > 0 {
                self.showAMessage(withTitle: "error".localized(), message: responseObject.error!, completion: {
                    
                })
            } else if responseObject.error != nil && (responseObject.error?.count)! > 0 {
                self.showAMessage(withTitle: "error".localized(), message: responseObject.error!, completion: {
                    
                })
            }else if responseObject.user_data?.token != nil && (responseObject.user_data?.token?.count)! > 0 {
                NewSuccessModel.saveLoginSuccessToken(userToken: (responseObject.user_data?.token!)!)
                self.GoToHome()
                Auth_User.user_id = responseObject.user_data?.user_id ?? "0"
                Auth_User.user_type_id = responseObject.user_data?.user_type_id ?? "1"
                HelperClassSwift.IsFirstLunch = false
                HelperClassSwift.UserName = responseObject.user_data?.user_username ?? "0"
                HelperClassSwift.UserPassword = Password
            
            }
            
            else if responseObject.message != nil && (responseObject.message?.count)! > 0 {
                self.showAMessage(withTitle: "error".localized(), message: responseObject.message!, completion: {
                    
                })
            } else {
                self.showAMessage(withTitle: "error".localized(), message: "token_missing".localized(), completion: {
                    
                })
            }
            
        }
        
    }
}
