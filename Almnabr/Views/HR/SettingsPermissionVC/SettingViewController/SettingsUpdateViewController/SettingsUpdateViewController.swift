//
//  SettingsUpdateViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 02/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown

class SettingsUpdateViewController: UIViewController {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var typeArrow: UIImageView!
    @IBOutlet weak var titleEnTextField: UITextField!
    @IBOutlet weak var titleArTextField: UITextField!
    @IBOutlet weak var shortCodeTextField: UITextField!
    @IBOutlet weak var neededLicenseView: UIView!
    @IBOutlet weak var licenseLabel: UILabel!
    @IBOutlet weak var licenseArrow: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    
    private var selectedSettingsType = ""
    private var typeDropDown = DropDown()
    private var licencesDropDown = DropDown()
    private var licenseData = [LicenceData]()
    var isUpdate = true
    var data:SettingsDataRecords!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setData()
    }
    
    
    private func initlization(){
        if L102Language.currentAppleLanguage() == "ar" {
            backButton.transform = .init(rotationAngle: .pi)
        }
        setUpTableView()
        setUpViews()
        setUpDropDownLists()
    }
    
    
    private func setData(){
        if isUpdate{
            updateButton.setTitle("Update", for: .normal)
            titleLabel.text = "Update Settings".localized()
            let type = data.settings_type ?? ""
            if type == "BANK"{
                self.typeLabel.text = "Bank Name".localized()
                self.bankNameTypeShow()
            }else if type == "ETIT"{
                self.typeLabel.text = "Employee Title".localized()
                self.employeeTitleTypeShow()
            }else if type == "JTIT"{
                self.typeLabel.text = "Job Positions".localized()
                let licenseIndex = data.settings_need_licence ?? ""
                if licenseIndex == "1"{
                    self.jopPositionsYesTypeShow()
                }else{
                    self.jopPositionsNoTypeShow()
                }
            }
            
            titleEnTextField.text = data.settings_name_english ?? ""
            titleArTextField.text = data.settings_name_arabic ?? ""
            shortCodeTextField.text = data.settings_short_code ?? ""
        }else{
            titleEnTextField.isHidden = true
            titleArTextField.isHidden = true
            shortCodeTextField.isHidden = true
            neededLicenseView.isHidden = true
            addButton.isHidden = true
            tableView.isHidden = true
            updateButton.setTitle("Add".localized(), for: .normal)
            titleLabel.text = "Add Settings".localized()
        }
    }
    
    
    private func setUpViews(){
        settingView.isUserInteractionEnabled = true
        settingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(settingTypeAction)))
        neededLicenseView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(licenseAction)))
    }
    
    private func setUpDropDownLists(){
        // Settings Type drop down list
        typeDropDown.anchorView = settingView
        typeDropDown.dataSource = ["Employee Title".localized(),"Bank Name".localized(),"Job Positions".localized()]
        typeDropDown.bottomOffset = CGPoint(x: 0, y:(typeDropDown.anchorView?.plainView.bounds.height)!)
        
        typeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            typeArrow.transform = .init(rotationAngle: 0)
            typeLabel.text = item
            if item == "Employee Title".localized(){
                self.employeeTitleTypeShow()
            }else if item == "Bank Name".localized(){
                self.bankNameTypeShow()
            }else if item == "Job Positions".localized(){
                if licenseData.isEmpty{
                    self.jopPositionsNoTypeShow()
                }else{
                    self.jopPositionsYesTypeShow()
                }
            }
        }
        
        typeDropDown.cancelAction = { [unowned self] in
            typeArrow.transform = .init(rotationAngle: 0)
        }
        
        // Need License drop down list
        licencesDropDown.anchorView = neededLicenseView
        licencesDropDown.dataSource = ["Yes".localized(),"No".localized()]
        licencesDropDown.bottomOffset = CGPoint(x: 0, y:(licencesDropDown.anchorView?.plainView.bounds.height)!)
        
        licencesDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            licenseLabel.text = item
            licenseArrow.transform = .init(rotationAngle: 0)
            if item == "Yes".localized(){
                self.jopPositionsYesTypeShow()
            }else{
                self.jopPositionsNoTypeShow()
            }
        }
        
        licencesDropDown.cancelAction = { [unowned self] in
            licenseArrow.transform = .init(rotationAngle: 0)
        }
        
    }
    
    private func employeeTitleTypeShow(){
        addButton.isHidden = true
        tableView.isHidden = true
        neededLicenseView.isHidden = true
        shortCodeTextField.isHidden = true
        titleEnTextField.isHidden = false
        titleArTextField.isHidden = false
    }
    
    private func bankNameTypeShow(){
        addButton.isHidden = true
        tableView.isHidden = true
        neededLicenseView.isHidden = true
        shortCodeTextField.isHidden = false
        titleEnTextField.isHidden = false
        titleArTextField.isHidden = false
    }
    
    private func jopPositionsYesTypeShow(){
        addButton.isHidden = false
        tableView.isHidden = false
        neededLicenseView.isHidden = false
        shortCodeTextField.isHidden = false
        titleEnTextField.isHidden = false
        titleArTextField.isHidden = false
        licencesDropDown.selectRow(0)
        if isUpdate{
            getEditingData()
        }
    }
    
    private func jopPositionsNoTypeShow(){
        
        addButton.isHidden = true
        tableView.isHidden = true
        neededLicenseView.isHidden = false
        shortCodeTextField.isHidden = false
        titleEnTextField.isHidden = false
        titleArTextField.isHidden = false
        licencesDropDown.selectRow(1)
    }
    
    private func getBodyData()->[String:Any]{
        var body = [String:Any]()
        body["settings_id"] = isUpdate ? data.settings_id ?? "" : ""
        body["settings_type"] = isUpdate ? data.settings_type ?? "" : getSettingsType()
        body["settings_name_english"] = titleEnTextField.text!
        body["settings_name_arabic"] = titleArTextField.text!
        body["settings_short_code"] = shortCodeTextField.text!
        body["settings_need_licence"] = licencesDropDown.selectedItem == "Yes".localized() ? "1" : "0"
        body["settings_status"] = isUpdate ? data.settings_status : "1"
        for index in 0 ..< licenseData.count{
            let obj = licenseData[index]
            body["licenses[\(index)][licence_title_english]"] = obj.licence_name_english ?? ""
            body["licenses[\(index)][licence_title_arabic]"] = obj.licence_name_arabic ?? ""
        }
        return body
    }
    
    private func getSettingsType()->String{
        switch typeLabel.text{
        case "Bank Name".localized():
            return "BANK"
        case "Employee Title".localized():
            return "ETIT"
        case "Job Positions".localized():
            return "JTIT"
        default:
            return ""
        }
        
    }
    
    @objc private func settingTypeAction(){
        typeDropDown.show()
        typeArrow.transform = .init(rotationAngle: .pi)
    }
    
    
    @objc private func licenseAction(){
        licencesDropDown.show()
        licenseArrow.transform = .init(rotationAngle: .pi)
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func updateAction(_ sender: Any) {
        isUpdate ? updateData() : addData()
    }
    
    
    @IBAction func addAction(_ sender: Any) {
        licenseData.append(.init(licence_name_english: "", licence_name_arabic: ""))
        self.tableViewHeight.constant = CGFloat(110 * self.licenseData.count)
        tableView.reloadData()
    }
    
    
}

extension SettingsUpdateViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "UpdateSettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "UpdateSettingsTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return licenseData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpdateSettingsTableViewCell", for: indexPath) as! UpdateSettingsTableViewCell
        cell.delegate = self
        cell.setData(data: licenseData[indexPath.row],indexPath: indexPath)
        return cell
    }
    
    
}

// MARK: - Handling API

extension SettingsUpdateViewController{
    private func getEditingData(){
        showLoadingActivity()
        APIController.shard.getEditingData(setting_id: data.settings_id ?? "") { editingData in
            self.hideLoadingActivity()
            DispatchQueue.main.async {
                print("ZZZZZZ",editingData.licenceData ?? [])
                self.licenseData =  editingData.licenceData ?? []
                self.tableViewHeight.constant = CGFloat(110 * self.licenseData.count)
                self.tableView.reloadData()
            }
        }
    }
    
    private func updateData(){
        APIController.shard.updateSettingsData(body: getBodyData()) { data in
            if let status = data.status{
                DispatchQueue.main.async {
                    if status{
                        self.showAlert(title: "Success".localized(), message: data.msg ?? "")
                    }else{
                        self.showAlert(title: "error".localized(), message: data.error ?? "")
                    }
                }
            }
        }
    }
    
    private func addData(){
        APIController.shard.addSettingsData(body: getBodyData()) { data in
            if let status = data.status{
                DispatchQueue.main.async {
                    if status{
                        self.showAlert(title: "Success".localized(), message: data.msg ?? "")
                    }else{
                        self.showAlert(title: "error".localized(), message: data.error ?? "")
                    }
                }
            }
        }
    }
    
    private func showAlert(title:String,message:String){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel,handler: { action in
            if title == "Success".localized(){
                self.navigationController?.popViewController(animated: true)
            }
        }))
        present(alertVC, animated: true, completion: nil)
        
    }
    
    
}


// MARK: - Cell Delegate
extension SettingsUpdateViewController:UpdateSettingsDelegate{
    func updateData(indexPath: IndexPath, en: String, ar: String) {
        licenseData[indexPath.row].licence_name_english = en
        licenseData[indexPath.row].licence_name_arabic = ar
    }
    
    func removeAction(indexPath:IndexPath) {
        self.licenseData.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        self.tableViewHeight.constant = CGFloat(110 * self.licenseData.count)
        self.tableView.reloadData()
    }
    
    
    
}
