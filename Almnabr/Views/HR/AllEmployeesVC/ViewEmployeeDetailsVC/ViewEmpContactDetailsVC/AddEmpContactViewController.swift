//
//  AddEmpContactViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 15/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class AddEmpContactViewController: UIViewController {
    @IBOutlet weak var personNameTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var contactAddressTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    var data : ContactRecords?
    var isView = false
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }
    
    private func initlization(){
        if L102Language.currentAppleLanguage() == "ar"{
            backButton.transform = .init(rotationAngle: .pi)
        }
        setUpMobileTextField()
        if let data = data{
            personNameTextField.text = data.contact_person_name ?? ""
            mobileNumberTextField.text = data.contact_mobile_number ?? ""
            emailAddressTextField.text = data.contact_email_address ?? ""
            contactAddressTextView.text = data.contact_address_text ?? ""
        }
        personNameTextField.isEnabled = !isView
        mobileNumberTextField.isEnabled = !isView
        emailAddressTextField.isEnabled = !isView
        contactAddressTextView.isEditable = !isView
        submitButton.isHidden = isView
    }
    
    
    private func setUpMobileTextField(){
        mobileNumberTextField.addTarget(self, action: #selector(mobileTextFieldAction(textField:)), for: .editingChanged)
    }
    
    @objc private func mobileTextFieldAction(textField:UITextField){
        if textField.text!.count > 12{
            textField.text = "\(textField.text!.prefix(12))"
        }
    }
    
    @IBAction func submitAction(_ sender: Any) {
        addContact()
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - API Handling

extension AddEmpContactViewController{
    private func addContact(){
        showLoadingActivity()
        APIController.shard.addContact(url: data == nil ? "add_contacts" : "update_contacts",contact_id: data?.contact_id ?? "", contact_person_name: personNameTextField.text!, contact_mobile_number: mobileNumberTextField.text!, contact_email_address: emailAddressTextField.text!, contact_address_text: contactAddressTextView.text!, branch_id: ViewEmployeeDetailsVC.empData.data?.branch_id ?? "", empId: ViewEmployeeDetailsVC.empData.data?.employee_number ?? "", employee_id_number: ViewEmployeeDetailsVC.empData.data?.employee_id_number ?? "") { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status , status {
                    let alertVC = UIAlertController(title: "Success".localized(), message: data.msg, preferredStyle: .alert)
                    alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel, handler: { action in
                        NotificationCenter.default.post(name: .init("LoadingContacts"), object: nil)
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alertVC, animated: true)
                }else{
                    let alertVC = UIAlertController(title: "error".localized(), message: data.error, preferredStyle: .alert)
                    alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel, handler: nil))
                    self.present(alertVC, animated: true)
                }
            }
        }
    }
    
}
