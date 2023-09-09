//
//  SettingsPermissionVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 02/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class SettingsPermissionVC: UIViewController {
    
    @IBOutlet weak var permissionMentionsView: UIView!
    @IBOutlet weak var permissionMentionsLabel: UILabel!
    
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var settingsLabel: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var header: HeaderView!
    
    private var settingsVC:PermissionViewController!
    private var permissionVC:SettingViewController!
    
    private var currentVCIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        header.btnAction = {
            let language =  L102Language.currentAppleLanguage()
            if language == "ar"{
                self.panel?.openRight(animated: true)
            }else{
                self.panel?.openLeft(animated: true)
            }
        }
    }
    
    private func initlization(){
        setUpViews()
    }
    
    
    private func setUpContainerView(){
        settingsVC = PermissionViewController()
        permissionVC = SettingViewController()
        setUpContanrView()
    }
    
    private func setUpContanrView(){
        addChild(settingsVC)
        addChild(permissionVC)
        
        mainView.addSubview(settingsVC.view)
        mainView.addSubview(permissionVC.view)
        
        settingsVC.didMove(toParent: self)
        permissionVC.didMove(toParent: self)
        
        settingsVC.view.frame = mainView.bounds
        permissionVC.view.frame = mainView.bounds
        
        settingsVC.view.isHidden = false
        permissionVC.view.isHidden = true
    }
    
    
    private func setUpViews(){
        setUpContainerView()
        
        permissionMentionsView.isUserInteractionEnabled = true
        permissionMentionsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(permissionMentionsAction)))
        
        settingsView.isUserInteractionEnabled = true
        settingsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(settingsAction)))
     
        
        
    }
    
    @objc private func permissionMentionsAction(){
        permissionMentionsView.backgroundColor = UIColor(hexString: "458FB8")
        permissionMentionsLabel.textColor = .white
        
        settingsView.backgroundColor = .clear
        settingsLabel.textColor = UIColor(hexString: "458FB8")
        
        settingsVC.view.isHidden = false
        permissionVC.view.isHidden = true
        currentVCIndex = 0
    }
    
    
    @objc private func settingsAction(){
        
        settingsView.backgroundColor = UIColor(hexString: "458FB8")
        settingsLabel.textColor = .white
        
        
        permissionMentionsView.backgroundColor = .clear
        permissionMentionsLabel.textColor = UIColor(hexString: "458FB8")
        
        
        settingsVC.view.isHidden = true
        permissionVC.view.isHidden = false
        
        currentVCIndex = 1
    }
    
    
    
    @IBAction func addAction(_ sender: Any) {
        if currentVCIndex == 0 {
            // add in permissionMentionsVC
            let vc = AddPermissionMentionsVC()
            navigationController?.pushViewController(vc, animated: true)
        }else{
            // add in SettingVC
            let vc = SettingsUpdateViewController()
            vc.isUpdate = false
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
    }
    
    
    
    @IBAction func backAction(_ sender: Any) {
//        backToDash()
    }
    
    
}
