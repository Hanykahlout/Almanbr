//
//  UpdateAttendanceGroupViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 01/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
class UpdateAttendanceGroupViewController: UIViewController {
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var titleEnTextField: UITextField!
    @IBOutlet weak var titleArTextField: UITextField!
    @IBOutlet weak var restrictedGroupSwitch: UISwitch!
    
    private let multiSelectionUsers = UsersSearchView()
    var data:AttendanceGroupsRecords?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBarTitle(navigationTitle: "Update Attendance Group".localized())
        navigationController?.setNavigationBarHidden(false, animated: true)
        multiSelectionUsers.selectionType = .multiSelection
        mainStackView.insertArrangedSubview(multiSelectionUsers, at: 2)
        if let data = data{
            getUpdateData(groupId: data.group_id ?? "")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    
    @IBAction func saveAction(_ sender: Any) {
        updateAttendanceGroupsData()
        
    }
    
    
    
    
    
}

// MARK: - API Handling
extension UpdateAttendanceGroupViewController{
    private func getUpdateData(groupId:String){
        showLoadingActivity()
        APIController.shard.getUpdateAttendanceGroupsData(groupId: groupId) { data in
            self.hideLoadingActivity()
            if let status = data.status , status{
                DispatchQueue.main.async {
                    self.titleEnTextField.text = data.records?.first?.group_title_english ?? ""
                    self.titleArTextField.text = data.records?.first?.group_title_arabic ?? ""
                    self.restrictedGroupSwitch.isOn = (data.records?.first?.un_restricted_group ?? "0") == "1" ? true : false
                    self.multiSelectionUsers.selectedResults = data.users ?? []
                    self.multiSelectionUsers.collectionView.reloadData()
                    self.multiSelectionUsers.collectionView.isHidden = self.multiSelectionUsers.selectedResults.isEmpty
                }
            }
        }
    }
    
    private func updateAttendanceGroupsData(){
        var body:[String:Any] = [
            "group_title_english": titleEnTextField.text!,
            "group_title_arabic": titleArTextField.text!,
            "un_restricted_group": restrictedGroupSwitch.isOn ? "1" : "0"
        ]
        
        for index in 0..<multiSelectionUsers.selectedResults.count{
            body["group_users[\(index)]"] = multiSelectionUsers.selectedResults[index].value ?? ""
        }
        
        showLoadingActivity()
        APIController.shard.updateAttendanceGroupsData(url:data == nil ? "/at/create_groups" : "/at/update_groups/\(data?.group_id ?? "")",body: body) { data in
            self.hideLoadingActivity()
            DispatchQueue.main.async {
                if let status = data.status , status{
                    self.navigationController?.popViewController(animated: true)
                    SCLAlertView().showSuccess("Success".localized(), subTitle: data.msg ?? "")
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
            }
        }
    }
    
    
}
