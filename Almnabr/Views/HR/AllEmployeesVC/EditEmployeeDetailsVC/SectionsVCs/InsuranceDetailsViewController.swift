//
//  InsuranceDetailsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 08/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import Fastis
class InsuranceDetailsViewController: UIViewController {

    @IBOutlet weak var insuranceNumberTextField: UITextField!
    @IBOutlet weak var insuranceDateTextField: UITextField!
    @IBOutlet weak var insuranceTypeClassTextField: UITextField!
    
    private var fastisController = FastisController(mode: .single)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    
    
    private func initlization(){
        setUpDatePicker()
        setEditBodyData()
        addSubmitObserver()
    }
    
    private func addSubmitObserver(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Submit6"), object: nil, queue: .main) { notifi in
            print("Submit6")
            EditEmployeeDetailsVC.editBody.insurance_number = self.insuranceNumberTextField.text!
            EditEmployeeDetailsVC.editBody.insurance_date = self.insuranceDateTextField.text!
            EditEmployeeDetailsVC.editBody.insurance_type_class = self.insuranceTypeClassTextField.text!
        }
    }
    
    private func setEditBodyData(){
        self.insuranceNumberTextField.text! = EditEmployeeDetailsVC.editBody.insurance_number
        self.insuranceDateTextField.text = EditEmployeeDetailsVC.editBody.insurance_date
        self.insuranceTypeClassTextField.text! = EditEmployeeDetailsVC.editBody.insurance_type_class
    }
    
    private func setUpDatePicker(){
        insuranceDateTextField.isEnabled = false
        fastisController.title = "Choose Date".localized()
        fastisController.allowToChooseNilDate = true
        fastisController.shortcuts = [.today]
        fastisController.doneHandler = { result in
            if let result = result{
                self.insuranceDateTextField.text = self.formatedDate(date: result)
            }else{
                self.insuranceDateTextField.text = ""
            }
        }
    }

    
    @IBAction func insuranceDateAction(_ sender: Any) {
        fastisController.present(above: self)
    }
    

}
