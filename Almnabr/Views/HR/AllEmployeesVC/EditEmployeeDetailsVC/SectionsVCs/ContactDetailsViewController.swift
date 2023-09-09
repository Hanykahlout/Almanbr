//
//  ContactDetailsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 08/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {
    
    @IBOutlet weak var primaryMobileTextField: UITextField!
    @IBOutlet weak var primaryEmailAddressTextField: UITextField!
    @IBOutlet weak var primaryAddressTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
       
    }
    
    
    private func initlization(){
        setEditBodyData()
        addSubmitObserver()
    }
    
    
    private func setEditBodyData(){
        self.primaryMobileTextField.text! = EditEmployeeDetailsVC.editBody.primary_mobile
        self.primaryEmailAddressTextField.text! = EditEmployeeDetailsVC.editBody.primary_email
        self.primaryAddressTextView.text! = EditEmployeeDetailsVC.editBody.primary_address
    }
    
    private func addSubmitObserver(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Submit2"), object: nil, queue: .main) { notifi in
            print("Submit2")
            EditEmployeeDetailsVC.editBody.primary_mobile = self.primaryMobileTextField.text!
            EditEmployeeDetailsVC.editBody.primary_email = self.primaryEmailAddressTextField.text!
            EditEmployeeDetailsVC.editBody.primary_address = self.primaryAddressTextView.text!
        }
    }
    
}
