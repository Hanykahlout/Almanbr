//
//  AddEmpEduDetailsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 16/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import Fastis
class AddEmpEduDetailsViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var educationTitleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    private var dateController = FastisController(mode: .single)
    private var isStartDate = true
    
    var data:EducationRecord?
    var isView = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }
    
    
    private func initlization(){
        if L102Language.currentAppleLanguage() == "ar"{
            backButton.transform = .init(rotationAngle: .pi)
        }
        
        setUpDateController()
        getData()
    }
    
    
    private func setUpDateController(){
        startDateTextField.isEnabled = false
        endDateTextField.isEnabled = false
        
        dateController.title = "Choose Date".localized()
        
        dateController.allowToChooseNilDate = true
        dateController.shortcuts = [.today]
        dateController.doneHandler = { result in
            if self.isStartDate{
                if let result = result{
                    self.startDateTextField.text = self.formatedDate(date: result)
                }else{
                    self.startDateTextField.text = ""
                }
            }else{
                if let result = result{
                    self.endDateTextField.text = self.formatedDate(date: result)
                }else{
                    self.endDateTextField.text = ""
                }
            }
        }
    }
    
    
    private func getData(){
        if let data = data {
            educationTitleTextField.text = data.education_title ?? ""
            descriptionTextView.text = data.education_descriptions ?? ""
            startDateTextField.text = data.education_start_date ?? ""
            endDateTextField.text = data.education_end_date ?? ""
        }
        
        submitButton.isHidden = isView
        educationTitleTextField.isEnabled = !isView
        descriptionTextView.isEditable = !isView
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        
        var param:[String:Any] = [:]
        param["education_id"] = data?.education_id ?? ""
        param["education_title"] = educationTitleTextField.text!
        param["education_descriptions"] = descriptionTextView.text!
        param["education_start_date"] = startDateTextField.text!
        param["education_end_date"] = endDateTextField.text!
        //        param["education_certification_file"] = ""
        param["branch_id"] = ViewEmployeeDetailsVC.empData.data?.branch_id ?? ""
        param["id"] = ViewEmployeeDetailsVC.empData.data?.employee_number ?? ""
        param["employee_id_number"] = ViewEmployeeDetailsVC.empData.data?.employee_id_number ?? ""
        
        showLoadingActivity()
        APIController.shard.addPositionOrEducation(url: data != nil ? "update_education" : "create_education",body: param) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    let alertVC = UIAlertController(title: "Success".localized(), message: data.msg, preferredStyle: .alert)
                    alertVC.addAction(.init(title: "ok".localized(), style: .default, handler: { action in
                        NotificationCenter.default.post(name: NSNotification.Name("LoadingEducation"), object: nil)
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
    
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func startDateAction(_ sender: Any) {
        isStartDate = true
        dateController.present(above: self)
    }
    
    @IBAction func endDateAction(_ sender: Any) {
        isStartDate = false
        dateController.present(above: self)
    }
    
}


