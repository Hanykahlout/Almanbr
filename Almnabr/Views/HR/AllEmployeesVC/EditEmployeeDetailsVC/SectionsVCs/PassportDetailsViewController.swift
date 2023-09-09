//
//  PassportDetailsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 08/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import Fastis

class PassportDetailsViewController: UIViewController {
    
    @IBOutlet weak var passportNumberTextField: UITextField!
    
    @IBOutlet weak var issueDateEnTextField: UITextField!
    @IBOutlet weak var issueDateArTextField: UITextField!
    
    @IBOutlet weak var expiryDateEnTextField: UITextField!
    @IBOutlet weak var expiryDateArTextField: UITextField!
    
    @IBOutlet weak var issuePlaceTextField: UITextField!
    
    
    private let fastisController = FastisController(mode: .single)
    private var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        
    }
    
    
    private func initlization(){
        setUpDatePicker()
        setUpArDatePicker()
        setEditBodyData()
        setUpObserver()
    }
    
    
    private func setUpObserver(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Submit5"), object: nil, queue: .main) { notifi in
            print("Submit5")
            
            EditEmployeeDetailsVC.editBody.passport_number = self.passportNumberTextField.text!
            EditEmployeeDetailsVC.editBody.passport_issue_place = self.issuePlaceTextField.text!
            EditEmployeeDetailsVC.editBody.passport_issue_date_english = self.issueDateEnTextField.text!
            EditEmployeeDetailsVC.editBody.passport_issue_date_arabic = self.issueDateArTextField.text!
            EditEmployeeDetailsVC.editBody.passport_expiry_date_english = self.expiryDateEnTextField.text!
            EditEmployeeDetailsVC.editBody.passport_expiry_date_arabic = self.expiryDateArTextField.text!
            
        }
    }
    
    private func setEditBodyData(){
        self.passportNumberTextField.text! = EditEmployeeDetailsVC.editBody.passport_number
        self.issuePlaceTextField.text! = EditEmployeeDetailsVC.editBody.passport_issue_place
        
        self.issueDateEnTextField.text = EditEmployeeDetailsVC.editBody.passport_issue_date_english
        self.issueDateArTextField.text = EditEmployeeDetailsVC.editBody.passport_issue_date_arabic
        self.expiryDateEnTextField.text = EditEmployeeDetailsVC.editBody.passport_expiry_date_english
        self.expiryDateArTextField.text = EditEmployeeDetailsVC.editBody.passport_expiry_date_arabic
    }
    
    
    private func setUpArDatePicker(){
        let datePicker = UIDatePicker()
        datePicker.locale = .init(identifier: "ar")
        datePicker.datePickerMode = .date
        datePicker.calendar = Calendar(identifier: .islamicUmmAlQura)
        datePicker.addTarget(self, action: #selector(issueDateArAction(datePicker:)), for: .valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        issueDateArTextField.inputView = datePicker
        
        let datePicker2 = UIDatePicker()
        datePicker2.locale = .init(identifier: "ar")
        datePicker2.datePickerMode = .date
        datePicker2.calendar = Calendar(identifier: .islamicUmmAlQura)
        datePicker2.addTarget(self, action: #selector(expiryDateArAction(datePicker:)), for: .valueChanged)
        datePicker2.frame.size = CGSize(width: 0, height: 300)
        datePicker2.preferredDatePickerStyle = .wheels
        expiryDateArTextField.inputView = datePicker2
        
    }
    
    
    
    private func setUpDatePicker(){
        issueDateEnTextField.isEnabled = false
        issueDateArTextField.isEnabled = true
        expiryDateEnTextField.isEnabled = false
        expiryDateArTextField.isEnabled = true
        
        fastisController.title = "Choose Date".localized()
        fastisController.allowToChooseNilDate = true
        fastisController.shortcuts = [.today]
        
        fastisController.doneHandler = { result in
            switch self.index{
            case 0:
                if let result = result{
                    self.issueDateEnTextField.text = self.formatedDate(date: result )
                    self.issueDateArTextField.text = self.convertDateToHijri(date: result)
                }else{
                    self.issueDateEnTextField.text = ""
                    self.issueDateArTextField.text = ""
                }
            case 1:
                if let result = result{
                    self.expiryDateEnTextField.text = self.formatedDate(date: result )
                    self.expiryDateArTextField.text = self.convertDateToHijri(date: result)
                }else{
                    self.expiryDateEnTextField.text = ""
                    self.expiryDateArTextField.text = ""
                }
            default:
                break
            }
        }
    }
    
    
    @objc private func issueDateArAction(datePicker:UIDatePicker){
        issueDateEnTextField.text = convertDateToGregorian(date: datePicker.date)
        issueDateArTextField.text = convertDateToHijri(date: datePicker.date)
        
    }
    
    
    @objc private func expiryDateArAction(datePicker:UIDatePicker){
        expiryDateEnTextField.text = convertDateToGregorian(date: datePicker.date)
        expiryDateArTextField.text = convertDateToHijri(date: datePicker.date)
        
    }
    
    
    
    @IBAction func issueDateEnAction(_ sender: Any) {
        index = 0
        fastisController.present(above: self)
    }
    
    
    
    @IBAction func expiryDateEnAction(_ sender: Any) {
        index = 1
        fastisController.present(above: self)
    }
    
    
    
}


