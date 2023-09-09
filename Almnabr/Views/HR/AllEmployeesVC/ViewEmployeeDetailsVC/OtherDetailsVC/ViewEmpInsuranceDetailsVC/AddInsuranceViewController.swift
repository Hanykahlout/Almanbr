//
//  AddInsuranceViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 19/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import Fastis
class AddInsuranceViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var insuranceNumberTextField: UITextField!
    @IBOutlet weak var insuranceDateTextFiled: UITextField!
    @IBOutlet weak var insuranceTypeClassTextField: UITextField!
    private var dateController = FastisController(mode: .single)
    private var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    
    private func initlization(){
        if L102Language.currentAppleLanguage() == "ar"{
            backButton.transform = .init(rotationAngle: .pi)
        }
        setUpTableView()
        setUpDateController()
        setInsuranceData()
    }
    
    
    private func setUpDateController(){
        insuranceDateTextFiled.isEnabled = false
        dateController.title = "Choose Date".localized()
        
        dateController.allowToChooseNilDate = true
        dateController.shortcuts = [.today]
        dateController.doneHandler = { result in
            if let result = result{
                self.insuranceDateTextFiled.text = self.formatedDate(date: result)
            }else{
                self.insuranceDateTextFiled.text = ""
            }
        }
    }
    
    
    private func setInsuranceData(){
        insuranceTypeClassTextField.text = ViewEmployeeDetailsVC.empData.data?.insurance_type_class ?? ""
        insuranceNumberTextField.text = ViewEmployeeDetailsVC.empData.data?.insurance_number ?? ""
        insuranceDateTextFiled.text = ViewEmployeeDetailsVC.empData.data?.insurance_date ?? ""
        
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addAction(_ sender: Any) {
        count += 1
        tableView.reloadData()
    }
    
    @IBAction func dateAction(_ sender: Any) {
        dateController.present(above: self)
    }
    
    @IBAction func submitAction(_ sender: Any) {
        addInsuranceDetails()
    }
    
}

extension AddInsuranceViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "AddInsuranceTableViewCell", bundle: nil), forCellReuseIdentifier: "AddInsuranceTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddInsuranceTableViewCell", for: indexPath) as! AddInsuranceTableViewCell
        cell.delegate = self
        return cell
    }
}

// MARK: - Table View Cell Delegate
extension AddInsuranceViewController:AddInsuranceCellDelegate{
    func deleteAction() {
        if count > 0{
            count -= 1
            tableView.reloadData()
        }
    }
}


// MARK: - API Handling
extension AddInsuranceViewController{
    private func addInsuranceDetails(){
        var param = [String:Any]()
        
        param["branch_id"] = ViewEmployeeDetailsVC.empData.data?.branch_id ?? ""
        param["id"] = ViewEmployeeDetailsVC.empData.data?.employee_number ?? ""
        param["employee_id_number"] = ViewEmployeeDetailsVC.empData.data?.employee_id_number ?? ""
        param["insurance_number"] = insuranceNumberTextField.text!
        param["insurance_date"] = insuranceDateTextFiled.text!
        param["insurance_type_class"] = insuranceTypeClassTextField.text!
        if count != 0{
            for index in 0...count-1{
                let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! AddInsuranceTableViewCell
                param["insgroups[\(index)][insurance_dependent_name]"] = cell.dependentNameTextField.text!
                param["insgroups[\(index)][insurance_dependent_ins_no]"] = cell.insuranceNumberTextField.text!
                param["insgroups[\(index)][insurance_dependent_number]"] = cell.dependentIDTextField.text!
                param["insgroups[\(index)][insurance_dependent_reaplationship]"] = cell.selectedRelationship == nil ? "" : "\(cell.selectedRelationship!)"
                param["insgroups[\(index)][insurance_dependent_date]"] = cell.insuranceDateTextField.text!
            }
        }
        
        showLoadingActivity()
        APIController.shard.addInsuranceDetails(body: param) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                var alertVC:UIAlertController!
                if let status = data.status,status{
                    alertVC = UIAlertController(title: "Sucess".localized(), message: data.msg, preferredStyle: .alert)
                    alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel, handler: { action in
                        NotificationCenter.default.post(name: .init(rawValue: "ReloadInsuranceDetails"), object: nil)
                        self.navigationController?.popViewController(animated: true)
                    }))
                }else{
                    alertVC = UIAlertController(title: "error".localized(), message: data.error, preferredStyle: .alert)
                    alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel, handler: nil))
                }
                self.present(alertVC, animated: true)
            }
        }

    }
}
