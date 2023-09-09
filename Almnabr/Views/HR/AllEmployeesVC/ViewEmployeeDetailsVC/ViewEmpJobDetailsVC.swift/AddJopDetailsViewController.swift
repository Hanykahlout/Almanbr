//
//  AddJopDetailsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 14/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
class AddJopDetailsViewController: UIViewController {
    @IBOutlet weak var positionsTextField: UITextField!
    @IBOutlet weak var positionsArrow: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    private var dropDown = DropDown()
    private var jopList = [Joblists]()
    private var licenceDate = [Licenses]()
    var empId = ""
    var positionId = ""
    var isView = false
    var isUpload = false
    private var selectedSettingsId = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }
    
    private func initlization(){
        if L102Language.currentAppleLanguage() == "ar"{
            backButton.transform = .init(rotationAngle: .pi)
        }
        setUpTableView()
        setUpDropDown()
        setUpTextField()
        getJopList()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isUpload || isView{
            getUpdateData()
        }
        positionsTextField.isEnabled = !isView
        descriptionTextView.isEditable = !isView
        submitButton.isHidden = isView
    }
    
    
    private func setUpTextField(){
        positionsTextField.isUserInteractionEnabled = true
        positionsTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(positionsTextFieldAction)))
    }
    
    
    private func setUpDropDown(){
        dropDown.anchorView = positionsTextField
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.positionsArrow.transform = .init(rotationAngle: 0)
            if !isView{
                self.positionsTextField.text = item
                let selectedItem = self.jopList[index]
                selectedSettingsId = selectedItem.value ?? ""
                self.getNeededLicense(setting_Id: selectedItem.value ?? "")
            }
        }
        
        dropDown.cancelAction = { [unowned self] in
            self.positionsArrow.transform = .init(rotationAngle: 0)
        }
    }
    
    
    @objc private func positionsTextFieldAction(){
        dropDown.show()
    }
    
    @IBAction func addAction(_ sender: Any) {
        addJopDetails()
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}


extension AddJopDetailsViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "AddJopDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "AddJopDetailsTableViewCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return licenceDate.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddJopDetailsTableViewCell", for: indexPath) as! AddJopDetailsTableViewCell
        cell.setData(isView:isView,data: licenceDate[indexPath.row],indexPath:indexPath)
        cell.delegate = self
        return cell
    }
}

extension AddJopDetailsViewController:AddJopDetailsCellDelegate{
    func deleteCell(indexPath: IndexPath) {
        if licenceDate.count > 1{
            licenceDate.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}


// MARK: - API Handling
extension AddJopDetailsViewController{
    private func getJopList(){
        
        APIController.shard.getJopList { data in
            if let status = data.status,status{
                self.jopList = data.joblists ?? []
                self.dropDown.dataSource = self.jopList.map{$0.label ?? ""}
            }
        }
    }
    
    private func getNeededLicense(setting_Id:String){
        showLoadingActivity()
        APIController.shard.getNeededLicenes(setting_Id: setting_Id) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    self.licenceDate = data.licenses ?? []
                }else{
                    self.licenceDate.removeAll()
                }
                self.tableView.reloadData()
            }
        }
    }
    
    private func addJopDetails(){
        var param:[String:Any] = ["position_id": positionId,
                                  "settings_id": selectedSettingsId,
                                  "job_descriptions": descriptionTextView.text!,
                                  "id": empId ,
                                  "branch_id": ViewEmployeeDetailsVC.empData.data?.branch_id ?? ""]
        
        for index in 0..<licenceDate.count{
            let cell = tableView.cellForRow(at: IndexPath.init(row: index, section: 0)) as! AddJopDetailsTableViewCell
            param["liclists[\(index)][employee_number]"] = empId
            param["liclists[\(index)][licence_list_id]"] = licenceDate[index].licence_list_id ?? ""
            param["liclists[\(index)][settings_id]"] = selectedSettingsId
            param["liclists[\(index)][licence_number]"] = cell.licenceNumberTextField.text!
            param["liclists[\(index)][licence_issue_date_english]"] = cell.issueDateEnTextField.text!
            param["liclists[\(index)][licence_issue_date_arabic]"] = cell.issueDateArTextField.text!
            param["liclists[\(index)][licence_expiry_date_english]"] = cell.expiryDateEnTextField.text!
            param["liclists[\(index)][licence_expiry_date_arabic]"] = cell.expiryDateArTextField.text!
        }
        
        showLoadingActivity()
        APIController.shard.addPositionOrEducation(url: isUpload ? "update_position" : "create_position",body: param) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    let alertVC = UIAlertController(title: "Success".localized(), message: data.msg, preferredStyle: .alert)
                    alertVC.addAction(.init(title: "ok".localized(), style: .default, handler: { action in
                        NotificationCenter.default.post(name: NSNotification.Name("LoadingPositions"), object: nil)
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
    
    
    private func getUpdateData(){
        showLoadingActivity()
        APIController.shard.getDataForUpdateJopDetails(branchId: ViewEmployeeDetailsVC.empData.data?.branch_id ?? "", id: empId, positionID: positionId) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    if let _date = data.records?.first{
                        self.selectedSettingsId = _date.settings_id ?? ""
                        self.positionsTextField.text = _date.postition_name ?? ""
                        self.descriptionTextView.text = _date.job_descriptions ?? ""
                    }
                    if let licences = data.licences{
                        for item in licences{
                            self.licenceDate.append(.init(licence_list_id: item.licence_list_id ?? "", settings_id: item.setting_id ?? "", licence_name: item.licence_name ?? "", licence_number: item.licence_number ?? "", licence_issue_date_english: item.licence_issue_date_english ?? "", licence_issue_date_arabic: item.licence_issue_date_arabic ?? "", licence_expiry_date_english: item.licence_expiry_date_english ?? "", licence_expiry_date_arabic: item.licence_expiry_date_arabic ?? ""))
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    
}
