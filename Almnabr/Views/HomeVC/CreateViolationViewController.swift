//
//  CreateViolationViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 27/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import SCLAlertView

class CreateViolationViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var usersArrow: UIImageView!
    
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var emptyNoteLabel: UILabel!
    
    private var usersDropDown = DropDown()
    private var users = [SearchBranchRecords]()
    private var selectedUser: SearchBranchRecords?
    var isCreate = true
    var data = [ViolationRecords]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }

    private func initialization(){
        userTextField.addTarget(self, action: #selector(searchAction), for: .editingChanged)
        noteTextView.delegate = self
        setUpDropDown()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerLabel.text = isCreate ? "Create Violation" : "Cancel Violation"
        noteTextView.isHidden = isCreate
        emptyNoteLabel.isHidden = isCreate
        userTextField.isHidden = !isCreate
        usersArrow.isHidden = !isCreate
    }
    
    private func setUpDropDown(){
        //        usersDropDown
        usersDropDown.anchorView = userTextField
        usersDropDown.bottomOffset = CGPoint(x: 0, y:(usersDropDown.anchorView?.plainView.bounds.height)!)
        usersDropDown.selectionAction = { (index: Int, item: String) in
            DispatchQueue.main.async {
                if !self.users.isEmpty{
                    self.usersArrow.transform = .init(rotationAngle: 0)
                    let objc = self.users[index]
                    self.userTextField.text = ""
                    self.userTextField.placeholder = objc.label
                    self.selectedUser = objc
                    
                }
            }
        }
        
        usersDropDown.cancelAction = {
            DispatchQueue.main.async {
                self.usersArrow.transform = .init(rotationAngle: .pi)
            }
        }
    }
    
    @objc private func searchAction(){
        getUsers()
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        if isCreate {
            createViolation()
        } else{
            cancelViolation()
        }
    }
    
    
    
}

// MARK: - Text View Delegate
extension CreateViolationViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        emptyNoteLabel.isHidden = true
    }
}


// MARK: - API Handling
extension CreateViolationViewController{
    private func getUsers(){
        APIController.shard.searchForUser(searchText: userTextField.text!, lang: L102Language.currentAppleLanguage(), id: Auth_User.user_type_id) { data in
            if let status = data.status , status{
                self.users = data.list ?? []
                self.usersDropDown.dataSource = self.users.map{$0.label ?? ""}
            }else{
                self.usersDropDown.dataSource = ["No items found"]
            }
            self.usersDropDown.show()
            self.usersArrow.transform = .init(rotationAngle: .pi)
        }
    }
    
    private func createViolation(){
        
        var body = [
            "direct_manager": selectedUser?.value ?? ""
        ]
            
        for index in 0..<data.count {
            body["violation_log_id[\(index)]"] = data[index].id ?? ""
        }
         
        
        showLoadingActivity()
        APIController.shard.createViolation(body: body) { data in
            self.hideLoadingActivity()
            if let status = data.status , status{
                let alert = SCLAlertView()
                alert.showSuccess("Success".localized(), subTitle: data.message ?? "",closeButtonTitle: "Ok")
            }else{
                SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
            }
            self.navigationController?.dismiss(animated: true)
        }
    }
    
    private func cancelViolation(){
        
        var body = [
            "cancel_note": noteTextView.text!
        ]
            
        for index in 0..<data.count {
            body["violation_log_id[\(index)]"] = data[index].id ?? ""
        }
         
        
        showLoadingActivity()
        APIController.shard.cancelViolation(body: body) { data in
            self.hideLoadingActivity()
            if let status = data.status , status{
                let alert = SCLAlertView()
                alert.showSuccess("Success".localized(), subTitle: data.message ?? "",closeButtonTitle: "Ok")
            }else{
                SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
            }
            self.navigationController?.dismiss(animated: true)
        }
        
    }
    
}









