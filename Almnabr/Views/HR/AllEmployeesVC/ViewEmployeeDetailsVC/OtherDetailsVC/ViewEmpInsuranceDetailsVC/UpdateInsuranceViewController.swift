//
//  UpdateInsuranceViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 19/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import Fastis
import DropDown

class UpdateInsuranceViewController: UIViewController {
    
    @IBOutlet weak var dependentNameTextField: UITextField!
    @IBOutlet weak var dependentIDTextField: UITextField!
    @IBOutlet weak var insuranceNumberTextField: UITextField!
    @IBOutlet weak var insuranceRelationshipTextField: UITextField!
    @IBOutlet weak var insuranceDateTextField: UITextField!
    @IBOutlet weak var relationArrow: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    private var relationshipData = ["Choose".localized(),"Spouse".localized(),"Son".localized(),"Daugther".localized(),"Others".localized()]
    private var dateController = FastisController(mode: .single)
    private var dropDown = DropDown()
    private var selectedRelationship:Int?
    
    var data:InsuranceRecords!
    var isView = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        
    }
    
    
    private func initlization(){
        if L102Language.currentAppleLanguage() == "ar"{
            backButton.transform = .init(rotationAngle: .pi)
        }
        setInsuranceCellData()
        setUpDateController()
        setUpDropDownList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dependentNameTextField.isEnabled = !isView
        dependentIDTextField.isEnabled = !isView
        insuranceNumberTextField.isEnabled = !isView
        insuranceRelationshipTextField.isEnabled = !isView
        insuranceDateTextField.isEnabled = !isView
        submitButton.isHidden = isView
    }
    
    
    private func setUpDropDownList(){
        dropDown.anchorView = insuranceRelationshipTextField
        dropDown.dataSource = relationshipData
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            relationArrow.transform = .init(rotationAngle: 0)
            insuranceRelationshipTextField.text = item
            self.selectedRelationship = index
        }
        
        dropDown.cancelAction = { [unowned self] in
            relationArrow.transform = .init(rotationAngle: 0)
        }
        insuranceRelationshipTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(insuranceRelationshipAction)))
    }
    
    
    private func setUpDateController(){
        insuranceDateTextField.isEnabled = false
        dateController.title = "Choose Date".localized()
        
        dateController.allowToChooseNilDate = true
        dateController.shortcuts = [.today]
        dateController.doneHandler = { result in
            if let result = result{
                self.insuranceDateTextField.text = self.formatedDate(date: result)
            }else{
                self.insuranceDateTextField.text = ""
            }
        }
    }
    
    
    private func setInsuranceCellData(){
        dependentNameTextField.text = data.insurance_dependent_name ?? ""
        dependentIDTextField.text = data.insurance_dependent_number ?? ""
        insuranceNumberTextField.text = data.insurance_dependent_ins_no ?? ""
        insuranceDateTextField.text = data.insurance_dependent_date ?? ""
        if let relationshipIndex = Int(data.insurance_dependent_reaplationship ?? ""){
            selectedRelationship = relationshipIndex
            insuranceRelationshipTextField.text = relationshipData[relationshipIndex]
        }
    }
    
    
    @objc private func insuranceRelationshipAction(){
        dropDown.show()
        relationArrow.transform = .init(rotationAngle: .pi)
    }
    
    
    @IBAction func insuranceDateAction(_ sender: Any) {
        dateController.present(above: self)
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitAction(_ sender: Any) {
        updateInsuranceData()
    }
    
}


extension UpdateInsuranceViewController{
    private func updateInsuranceData(){
        var param:[String:Any] = [:]
        
        param["insurance_dependent_id"] = data.insurance_dependent_id ?? ""
        param["insurance_dependent_name"] = dependentNameTextField.text!
        param["insurance_dependent_number"] = dependentIDTextField.text!
        param["insurance_dependent_ins_no"] = insuranceNumberTextField.text!
        let reaplationshipId = selectedRelationship == nil ? "" : "\(selectedRelationship!)"
        param["insurance_dependent_reaplationship"] = reaplationshipId
        param["insurance_dependent_date"] = insuranceDateTextField.text!
        param["branch_id"] = ViewEmployeeDetailsVC.empData.data?.branch_id ?? ""
        param["id"] = ViewEmployeeDetailsVC.empData.data?.employee_number ?? ""
        param["employee_id_number"] = ViewEmployeeDetailsVC.empData.data?.employee_id_number ?? ""
        
        showLoadingActivity()
        APIController.shard.updateInsuranceDetails(body: param) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                var alertVC:UIAlertController!
                if let status = data.status,status{
                    alertVC = UIAlertController(title: "Success".localized(), message: data.msg, preferredStyle: .alert)
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

