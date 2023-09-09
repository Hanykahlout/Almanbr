//
//  ForgetPasswordVC.swift
//  Almnabr
//
//  Created by MacBook on 26/09/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import DPLocalization

class ForgetPasswordVC: UIViewController {
    
    //- MARK: Outlets
    @IBOutlet weak var txtControlEmailAdress: TextFieldWithLabelView!
    @IBOutlet weak var txtControlUserName: TextFieldWithLabelView!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnRememeberMe: UIButton!
    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var lblRememeberMe: UILabel!
    @IBOutlet weak var btncheck: UIButton!
    
    
    
    var arr_lang = ["English".localized(),"Arabic".localized()]
    var IsCheck:Bool = false
    
    @IBOutlet weak var btnLogin: UIButton!{
        didSet{
            self.btnLogin.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            self.btnLogin.setBackgroundImage(UIImage.init(color: .buttonBackgroundColor()), for: .normal)
            self.btnLogin.setBackgroundImage(UIImage.init(color: Constants.color_main.getUIColor()), for: .disabled)
            self.btnLogin.setTitle("btn_submit".localized(), for: .normal)
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
            self.btnLanguage.titleLabel?.font = UIFont.systemFont(ofSize: 16)
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
        
//        self.btnLanguage.layer.cornerRadius = 11.0
//        self.btnLanguage.layer.shadowPath = UIBezierPath(rect: self.btnLogin.bounds).cgPath
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = "FFFFFF".getUIColor()
        configGUI()
        configNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the Navigation Bar
        //self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Config Navigation
    func configNavigation() {
        _ = self.navigationController?.preferredStatusBarStyle
        self.view.backgroundColor = "FFFFFF".getUIColor() //F0F4F8
        navigationController?.navigationBar.barTintColor = .buttonBackgroundColor()
        
        addNavigationBarTitle(navigationTitle: "Forgot password")
    }
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        txtControlEmailAdress.txtField.placeholder = "txt_email_address".localized()
        txtControlUserName.txtField.placeholder = "txt_username_address".localized()
        txtControlUserName.txtField.isSecureTextEntry = false
        txtControlUserName.backgroundColor = .clear
        txtControlEmailAdress.backgroundColor = .clear
        txtControlEmailAdress.txtField.keyboardType = .emailAddress
       
        
        
        
    }
    
    
    func reloadViewControllers() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        let storyboardName = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        delegate?.window?.rootViewController = storyboard.instantiateInitialViewController()
        if let lang = HelperClassSwift.getUserInformation(key: Constants.kAppLanguageSelect) {
            if lang == "ar" {
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
                UISlider.appearance().semanticContentAttribute = .forceLeftToRight
                changeLanguage(lang: "ar")
            } else {
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
                UISlider.appearance().semanticContentAttribute = .forceLeftToRight
                changeLanguage(lang: "en")
            }
        }
    }
    
    
    func changeLanguage(lang: String) {
        UserDefaults.standard.set([lang], forKey: "AppleLanguages")
        //UserDefaults.standard.synchronize()
        
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: .favLanguage, object: self, userInfo: nil)
        }
    }
    
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        //GIDSignIn.sharedInstance().signOut()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    
    
    @IBAction func btnLogin_Click(_ sender: Any) {
        self.view.endEditing(true)
        btnLogin.isEnabled = false
        btnLogin.isUserInteractionEnabled = false
        showLoadingActivity()
        
        
        
        //let language = dp_get_current_language()
        let params = ["user_email" : txtControlEmailAdress.txtField.text!,
                      "user_username" : txtControlUserName.txtField.text!]
        
        
        
        APIController.shard.postAnyData(queryString: "fpassword/en", parameters: params ) { (responseObject, error) in
            self.hideLoadingActivity()
            self.btnLogin.isEnabled = true
            self.btnLogin.isUserInteractionEnabled = true
            if responseObject.error != nil && (responseObject.error?.count)! > 0 {
                self.showAMessage(withTitle: "error".localized(), message: responseObject.error!, completion: {
                    
                })
            } else if responseObject.error != nil && (responseObject.error?.count)! > 0 {
                self.showAMessage(withTitle: "error".localized(), message: responseObject.error!, completion: {
                    
                })
            }else if responseObject.msg != nil && (responseObject.msg?.count)! > 0 {
                self.showAMessage(withTitle: " ".localized(), message: responseObject.msg!, completion: {
                    self.navigationController?.popViewController(animated: true)
                })

                
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
    
    @IBAction func btnLanguage_Click(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.anchorView = view
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 2.0
        
        dropDown.dataSource = self.arr_lang
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            if item == self.arr_lang[0] {
                print(item)
                HelperClassSwift.setUserInformation(value: "en", key: Constants.kAppLanguageSelect)
                dp_set_current_language("en")
                self.reloadViewControllers()
                
            }else{
                HelperClassSwift.setUserInformation(value: "ar", key: Constants.kAppLanguageSelect)
                dp_set_current_language("ar")
                self.reloadViewControllers()
            }
            
        }
        dropDown.direction = .bottom
        dropDown.anchorView = btnLanguage
        dropDown.bottomOffset = CGPoint(x: 0, y: btnLanguage.bounds.height)
        dropDown.width = btnLanguage.bounds.width
        dropDown.show()
    }
    
    @IBAction func btnForgotPassword_Click(_ sender: Any) {
        //        let aViewController = ForgetPasswordViewController(nibName: "ForgetPasswordViewController", bundle: nil)
        //        navigationController?.pushViewController(aViewController, animated: true)
        
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
}
