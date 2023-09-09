//
//  ChangePasswordViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 09/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswrodTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func submitAction(_ sender: Any) {
        changePassword()
    }
    
    
    @IBAction func closeAction(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
}

// MARK: - API Handling
extension ChangePasswordViewController{
    private func changePassword(){
        let body = [
            "opassword": oldPasswordTextField.text!,
            "password": passwordTextField.text! ,
            "cpassword": confirmPasswrodTextField.text!
        ]
        showLoadingActivity()
        APIController.shard.changePassword(body: body) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status , status{
                    self.navigationController?.dismiss(animated: true)
                    SCLAlertView().showSuccess("Success".localized(), subTitle: data.msg ?? "")
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
            }
        }
    }
}
