//
//  ApprovalWithPasswordVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 25/12/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
class ApprovalWithPasswordVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!

    var formType = ""
    var transactionId = ""
    var actionAfterApprove : (()->Void)?
    var formTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = formTitle
    }
    
    @IBAction func approveAction(_ sender: Any) {
        approve()
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
}

// MARK: - API Handling
extension ApprovalWithPasswordVC{
    
    private func approve(){
        showLoadingActivity()
        APIController.shard.approveCForm(formType: formType, transactionId: transactionId, user_pass: passwordTextField.text!) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    SCLAlertView().showSuccess("Success".localized(), subTitle: data.msg ?? "")
                    self.actionAfterApprove?()
                    self.navigationController?.dismiss(animated: true)
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "There is an unknown error !!")
                }
            }
        }
    }
}
