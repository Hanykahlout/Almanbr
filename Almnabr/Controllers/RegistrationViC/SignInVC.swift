//
//  SignInVC.swift
//  Almnabr
//
//  Created by MacBook on 26/09/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import DPLocalization
import FAPanels
import LocalAuthentication
import SCLAlertView

class SignInVC: UIViewController {
    
    //- MARK: Outlets
    @IBOutlet weak var txtControlEmailAdress: TextFieldWithLabelView!
    @IBOutlet weak var txtControlPassword: TextFieldWithLabelView!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnRememeberMe: UIButton!
    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var lblRememeberMe: UILabel!
    @IBOutlet weak var btncheck: UIButton!
    @IBOutlet weak var btnFinger: UIButton!
    
    private let dropDown = DropDown()
    
    var arr_lang = ["English".localized(),"Arabic".localized()]
    var IsCheck:Bool = false
    
    @IBOutlet weak var btnLogin: UIButton!{
        didSet{
            self.btnLogin.titleLabel?.font = .kufiRegularFont(ofSize: 15)
            self.btnLogin.setBackgroundImage(UIImage.init(color: .buttonBackgroundColor()), for: .normal)
            self.btnLogin.setBackgroundImage(UIImage.init(color: Constants.color_main.getUIColor()), for: .disabled)
            self.btnLogin.setTitle("btn_login".localized(), for: .normal)
            self.btnLogin.setTitleColor(.white, for: .normal)
            self.btnLogin.clipsToBounds = true
            self.btnLogin.layer.shadowRadius = 10.0
            self.btnLogin.layer.shadowColor = "0D3768".getUIColor().cgColor
            self.btnLogin.layer.shadowOffset = CGSize()
            self.btnLogin.layer.shadowOpacity = 0.8
            
        }
    }
    
    
    @IBOutlet weak var btnLanguage: UIButton!{
        didSet{
            self.btnLanguage.titleLabel?.font = .kufiRegularFont(ofSize: 15)
            self.btnLanguage.setBackgroundImage(UIImage.init(color: .buttonBackgroundColor()), for: .normal)
            self.btnLanguage.setBackgroundImage(UIImage.init(color: Constants.color_main.getUIColor()), for: .disabled)
            self.btnLanguage.setTitle("btn_language".localized(), for: .normal)
            self.btnLanguage.setTitleColor(.white, for: .normal)
            self.btnLanguage.clipsToBounds = true
            self.btnLanguage.layer.shadowRadius = 10.0
            self.btnLanguage.layer.shadowColor = "0D3768".getUIColor().cgColor
            self.btnLanguage.layer.shadowOffset = CGSize()
            self.btnLanguage.layer.shadowOpacity = 0.8
            
        }
    }
    //MARK: - UIView Life Cycle Method
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.btnLogin.layer.cornerRadius = 11.0
        self.btnLogin.layer.shadowPath = UIBezierPath(rect: self.btnLogin.bounds).cgPath
        
        self.btnLanguage.layer.cornerRadius = 11.0
        self.btnLanguage.layer.shadowPath = UIBezierPath(rect: self.btnLogin.bounds).cgPath
        
        self.btnFinger.layer.cornerRadius = 11.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = "FFFFFF".getUIColor()
        configGUI()
        setUpDropDown()
        
        for family: String in UIFont.familyNames {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family) {
                print("== \(names)")
            }
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the Navigation Bar
        //self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        txtControlEmailAdress.txtField.placeholder = "txt_username_address".localized()
        txtControlPassword.txtField.placeholder = "txt_password".localized()
        txtControlPassword.hideShowPassword.isHidden = false
        txtControlPassword.txtField.font = .kufiRegularFont(ofSize: 15)
        txtControlEmailAdress.txtField.font = .kufiRegularFont(ofSize: 15)
        txtControlPassword.txtField.isSecureTextEntry = true
        txtControlPassword.backgroundColor = .clear
        txtControlEmailAdress.backgroundColor = .clear
        txtControlEmailAdress.txtField.keyboardType = .emailAddress
        
        btnForgotPassword.setUnderLine(stringValue: "btn_forget_password", withTextSize: 13)
        
        
        btnForgotPassword.setTitleColor("8B9194".getUIColor(), for: .normal)
        
        btnForgotPassword.titleLabel?.font = .kufiRegularFont(ofSize: 15)
        if HelperClassSwift.IsFirstLunch == false && HelperClassSwift.IsLoggedOut == false{
            FingerLogin()
        }
        
        if  HelperClassSwift.IsLoggedOut == true{
            
            self.btnFinger.isHidden = false
            
        }
    }
    
  
    func reloadViewControllers() {
        
        if let lang = HelperClassSwift.getUserInformation(key: Constants.kAppLanguageSelect) {
            if lang == "ar" {
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
                UISlider.appearance().semanticContentAttribute = .forceLeftToRight
                //   changeLanguage(lang: "ar")
            } else {
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
                UISlider.appearance().semanticContentAttribute = .forceLeftToRight
                // changeLanguage(lang: "en")
            }
        }
    }
    
    
    func changeLanguage(lang: String) {
        UserDefaults.standard.set([lang], forKey: "AppleLanguages")
        //UserDefaults.standard.synchronize()
        guard let window = UIApplication.shared.keyWindow else {return}
        
        let vc : SignInVC = AppDelegate.mainSB.instanceVC()
        let rootNC = UINavigationController(rootViewController: vc)
        window.rootViewController = rootNC
        window.makeKeyAndVisible()
        self.dismiss(animated: true) {
            
        }
    }
    
    func GoToHome(){
        guard let window = UIApplication.shared.keyWindow else {return}
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
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    
    func login(Username:String , Password:String){
        
        showLoadingActivity()
        //AppInstance.showLoader()
        var fcmToken = ""
        var language = ""
        
        if let fcm_token = HelperClassSwift.getUserInformation(key: Constants.DEFINEFCMDEVICETOKEN){
            fcmToken = fcm_token
        }
        
        //        if let Language = dp_get_current_language() {
        //            language = Language
        //        }
        
        
        let params = ["username" : Username,
                      "password" : Password,
                      "noti_registrationId": "\(Auth_User.FCMtoken)",
                      "language": L102Language.currentAppleLanguage(),
                      "platform":"ios"]
        
        
        
        APIController.shard.postAnyData(queryString: "login", parameters: params ) { (responseObject, error) in
            self.hideLoadingActivity()
            // AppInstance.hideLoader()
            self.btnLogin.isEnabled = true
            self.btnLogin.isUserInteractionEnabled = true
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
                Auth_User.isAdmin = responseObject.user_data?.is_admin ?? "0" == "1"
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
    
    
    func FingerLogin(){
        
        
        let context = LAContext()
        var error: NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "Please authorize with touch id "
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){ success, error in
                
                if success {
                    
                    // Move to the main thread because a state update triggers UI changes.
                    DispatchQueue.main.async { [unowned self] in
                        print("success")
                        self.login(Username: HelperClassSwift.UserName , Password: HelperClassSwift.UserPassword )
                    }}
                
            }
        }else{
            print("can not use ")
            self.showAMessage(withTitle: "Unavailabel", message: "You Can't use This Feature")
        }
    }
    
    private func setUpDropDown(){
        dropDown.anchorView = view
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 2.0
        
        dropDown.dataSource = self.arr_lang
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            let selectedLang = index == 0 ? "en" : "ar"
            L102Language.changeLanguage(view: self, newLang: selectedLang, rootViewController: "SignInVC")
        }
        dropDown.direction = .bottom
        dropDown.anchorView = btnLanguage
        dropDown.bottomOffset = CGPoint(x: 0, y: btnLanguage.bounds.height)
        dropDown.width = btnLanguage.bounds.width
    }
    
    
    @IBAction func btnLogin_Click(_ sender: Any) {
        self.view.endEditing(true)
        showLoadingActivity()
        APIController.shard.fetchSendCode(username: txtControlEmailAdress.txtField.text!, password: txtControlPassword.txtField.text!) { data in
            self.hideLoadingActivity()
            if let status = data.status,status{
                let vc = SendSignInCodeVC()
                vc.username = self.txtControlEmailAdress.txtField.text!
                vc.password = self.txtControlPassword.txtField.text!
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                if let _ = data.otp_need{
                    self.login(Username: self.txtControlEmailAdress.txtField.text!, Password: self.txtControlPassword.txtField.text!)
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
            }
        }

    }
    
    
    @IBAction func btnLanguage_Click(_ sender: Any) {
        dropDown.show()
    }
    
    
    @IBAction func btnForgotPassword_Click(_ sender: Any) {
        let vc:ForgetPasswordVC = AppDelegate.mainSB.instanceVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func btnRememberMe_Click(_ sender: Any) {
        if IsCheck{
            self.btnRememeberMe.setImage(UIImage(named: "square_uncheck"), for: .normal)
            self.IsCheck = false
            
        }else{
            self.IsCheck = true
            self.btnRememeberMe.setImage(UIImage(named: "square_check"), for: .normal)
        }
    }
    
    
    
    @IBAction func btnFingerPrintSingnin_Click(_ sender: Any) {
        FingerLogin()
        
    }
}
