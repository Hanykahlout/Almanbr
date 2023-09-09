//
//  AddReviewerViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 24/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView

class AddReviewerViewController: UIViewController {
    
    @IBOutlet weak var mainStackView: UIStackView!
    private var selectedUser = [SearchBranchRecords]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        // Do any additional setup after loading the view.
    }
    
    private func initialization(){
        let usersSelectionView = UsersSearchView()
        usersSelectionView.searchTextField.placeholder = "Reviewers"
        usersSelectionView.selectionType = .multiSelection
        usersSelectionView.usersResult = { result in
            self.selectedUser = result
        }
        mainStackView.insertArrangedSubview(usersSelectionView, at: 2)
    }
    
    
    @IBAction func addAction(_ sender: Any) {
        addPayRoleReviewers()
    }
    
    @IBAction func closeAciton(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
    
    
}
// MARK: - API Handling
extension AddReviewerViewController{
    private func addPayRoleReviewers(){
        var body:[String:Any] = [:]
        for index in 0..<selectedUser.count{
            body["users_ids[\(index)]"] = selectedUser[index].value ?? ""
        }
        showLoadingActivity()
        APIController.shard.addPayRoleReviewers(body: body) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status, status{
                    SCLAlertView().showSuccess("Success".localized(), subTitle: data.msg ?? "")
                    NotificationCenter.default.post(name: .init("ReloadPayRoleReviewers"), object: nil)
                    self.navigationController?.dismiss(animated: true)
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
            }
        }
    }
}
