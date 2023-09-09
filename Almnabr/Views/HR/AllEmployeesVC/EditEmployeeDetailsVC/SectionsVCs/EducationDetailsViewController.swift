//
//  EducationDetailsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 08/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import Fastis

class EducationDetailsViewController: UIViewController {
    
    @IBOutlet weak var graduationTextField: UITextField!
    @IBOutlet weak var graduationArrow: UIImageView!
    
    @IBOutlet weak var lang_humanTextField: UITextField!
    @IBOutlet weak var lang_humanArrow: UIImageView!
    
    @IBOutlet weak var graduationYearTextField: UITextField!
    @IBOutlet weak var membershipNumberTextField: UITextField!
    
    @IBOutlet weak var membershipExpiryEnTextField: UITextField!
    @IBOutlet weak var membershipExpiryDateArTextField: UITextField!
    
    private var graduationDropDown = DropDown()
    private var lang_humanDropDown = DropDown()
    private let fastisController = FastisController(mode: .single)
    private var isDateAr = false
    private var selectedGraduation = ""
    private var selectedRatingDegree = ""
    
    private let graduationData = ["SL":"Below SSLC","SS":"SSLC","HS":"HSC","DP":"Diploma".localized(),"UG":"Bachelor Degree".localized(),"PG":"Master Degree".localized(),"DC":"Doctorate".localized()]
    
    private let ratingDegreesData = ["AE":"Associate engineer".localized(),"PE":"Professional engineer".localized(),"CE":"Consultant engineer".localized(),"O":"Other".localized()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    
    
    private func initlization(){
        setUpDropDownLists()
        setUpDatePicker()
        setUpArDatePicker()
        setEditBodyData()
        setUpObserver()
    }
    
    private func setUpObserver(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Submit4"), object: nil, queue: .main) { notifi in
            print("Submit4")
            
            EditEmployeeDetailsVC.editBody.primary_education_level = self.selectedGraduation
            EditEmployeeDetailsVC.editBody.rating_degree = self.selectedRatingDegree
            EditEmployeeDetailsVC.editBody.primary_graduation_year = self.graduationYearTextField.text!
            EditEmployeeDetailsVC.editBody.membership_number = self.membershipNumberTextField.text!
            EditEmployeeDetailsVC.editBody.membership_expiry_date_english = self.membershipExpiryEnTextField.text!
            EditEmployeeDetailsVC.editBody.membership_expiry_date_arabic = self.membershipExpiryDateArTextField.text!
            
        }
    }
    
    private func setEditBodyData(){
        self.selectedGraduation = EditEmployeeDetailsVC.editBody.primary_education_level
        if let graduation = self.graduationData[EditEmployeeDetailsVC.editBody.primary_education_level]{
            self.graduationTextField.text = graduation
        }
        
        self.selectedRatingDegree = EditEmployeeDetailsVC.editBody.rating_degree
        if let ratingDegree = self.ratingDegreesData[EditEmployeeDetailsVC.editBody.rating_degree]{
            self.lang_humanTextField.text = ratingDegree
        }
        
        
        self.membershipExpiryEnTextField.text = EditEmployeeDetailsVC.editBody.membership_expiry_date_english
        self.membershipExpiryDateArTextField.text = EditEmployeeDetailsVC.editBody.membership_expiry_date_arabic
        
        self.graduationYearTextField.text! = EditEmployeeDetailsVC.editBody.primary_graduation_year
        self.membershipNumberTextField.text! = EditEmployeeDetailsVC.editBody.membership_number
        
        
    }
    
    private func setUpArDatePicker(){
        let datePicker = UIDatePicker()
        datePicker.locale = .init(identifier: "ar")
        datePicker.datePickerMode = .date
        datePicker.calendar = Calendar(identifier: .islamicUmmAlQura)
        datePicker.addTarget(self, action: #selector(DatePickerAction(datePicker:)), for: .valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        membershipExpiryDateArTextField.inputView = datePicker
    }
    
    
    private func setUpDropDownLists(){
        
        graduationTextField.isUserInteractionEnabled = true
        lang_humanTextField.isUserInteractionEnabled = true
        graduationTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(graduationAction)))
        lang_humanTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(lang_humanAction)))
        
        
        // graduationDropDown
        graduationDropDown.anchorView = graduationTextField
        graduationDropDown.bottomOffset = CGPoint(x: 0, y:(graduationDropDown.anchorView?.plainView.bounds.height)!)
        graduationDropDown.dataSource = Array(graduationData.values)
        graduationDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            graduationArrow.transform = .init(rotationAngle: 0)
            self.graduationTextField.text = item
            self.selectedGraduation = self.graduationData.filter{$0.value == item}.first?.key ?? ""
        }
        
        graduationDropDown.cancelAction = { [unowned self] in
            graduationArrow.transform = .init(rotationAngle: 0)
        }
        
        // lang_humanDropDown
        lang_humanDropDown.anchorView = lang_humanTextField
        lang_humanDropDown.bottomOffset = CGPoint(x: 0, y:(lang_humanDropDown.anchorView?.plainView.bounds.height)!)
        lang_humanDropDown.dataSource = Array(ratingDegreesData.values)
        lang_humanDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            lang_humanArrow.transform = .init(rotationAngle: 0)
            self.lang_humanTextField.text = item
            self.selectedRatingDegree = self.ratingDegreesData.filter{$0.value == item}.first?.key ?? ""
        }
        
        lang_humanDropDown.cancelAction = { [unowned self] in
            lang_humanArrow.transform = .init(rotationAngle: 0)
        }
    }
    
    
    private func setUpDatePicker(){
        membershipExpiryEnTextField.isEnabled = false
        membershipExpiryDateArTextField.isEnabled = true
        fastisController.title = "Choose Date".localized()
        fastisController.allowToChooseNilDate = true
        fastisController.shortcuts = [.today]
        
        fastisController.doneHandler = { result in
            if let result = result{
                self.membershipExpiryEnTextField.text = self.formatedDate(date: result )
                self.membershipExpiryDateArTextField.text = self.convertDateToHijri(date: result)
            }else{
                self.membershipExpiryEnTextField.text = ""
                self.membershipExpiryDateArTextField.text = ""
            }
            
        }
    }
    
    
    @objc private func graduationAction(){
        graduationDropDown.show()
    }
    @objc private func lang_humanAction(){
        lang_humanDropDown.show()
    }
    
    @objc private func DatePickerAction(datePicker:UIDatePicker){
        self.membershipExpiryDateArTextField.text = convertDateToHijri(date: datePicker.date)
        self.membershipExpiryEnTextField.text = convertDateToGregorian(date: datePicker.date)
    }
    
    
    @IBAction func dateEnAction(_ sender: Any) {
        isDateAr = false
        fastisController.present(above: self)
    }
    
}

// MARK: - Handling Api Requests

extension EducationDetailsViewController{
    private func getGraduationData(){
        
    }
}
