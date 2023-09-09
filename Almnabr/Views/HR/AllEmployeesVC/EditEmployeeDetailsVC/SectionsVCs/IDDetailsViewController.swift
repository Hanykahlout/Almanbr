//
//  IDDetailsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 08/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import Fastis

class IDDetailsViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var idNumberTextField: UITextField!
    
    @IBOutlet weak var branchTextField: UITextField!
    @IBOutlet weak var branchArrow: UIImageView!
    
    @IBOutlet weak var firstNameEnTextField: UITextField!
    @IBOutlet weak var firstNameArTextField: UITextField!
    
    @IBOutlet weak var secondNameEnTextFiled: UITextField!
    @IBOutlet weak var secondNameArTextField: UITextField!
    
    @IBOutlet weak var ThirdNameEnTextField: UITextField!
    @IBOutlet weak var thirdNameArTextField: UITextField!
    
    @IBOutlet weak var lastNameEnTextField: UITextField!
    @IBOutlet weak var lastNameArTextField: UITextField!
    
    
    @IBOutlet weak var maritalStatusTextField: UITextField!
    @IBOutlet weak var maritalStatusArrow: UIImageView!
    
    @IBOutlet weak var religionTextField: UITextField!
    
    @IBOutlet weak var iDExpiryDateEnglishTextField: UITextField!
    @IBOutlet weak var iDExpiryDateArabicTextFiled: UITextField!
    @IBOutlet weak var birthDateEnglishTextField: UITextField!
    @IBOutlet weak var birthDateArabicTextField: UITextField!
    
    
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var genderArrow: UIImageView!
    
    @IBOutlet weak var copyNumberTextField: UITextField!
    
    @IBOutlet weak var employeeTitleTextField: UITextField!
    @IBOutlet weak var employeeTitleArrow: UIImageView!
    
    
    @IBOutlet weak var nationalityTextField: UITextField!
    @IBOutlet weak var nationalityArrow: UIImageView!
    
    
    @IBOutlet weak var jopTitleTextField: UITextField!
    
    @IBOutlet weak var groupNameEnglishTextField: UITextField!
    @IBOutlet weak var groupNameEnArrow: UIImageView!
    
    
    @IBOutlet weak var workDomainTextField: UITextField!
    @IBOutlet weak var workLocationTextField: UITextField!
    
    
    @IBOutlet weak var workTypeTextField: UITextField!
    @IBOutlet weak var workTypeArrow: UIImageView!
    
    private var branchsData = [SearchBranchRecords]()
    private var nationalityData = [SearchBranchRecords]()
    private var employeeTitle = [SearchBranchRecords]()
    private var groupNameData = [SearchBranchRecords]()
    
    private var branchDropDown = DropDown()
    private var maritalStatusDropDown = DropDown()
    private var genderDropDown = DropDown()
    private var nationalityDropDown = DropDown()
    private var workTypeDropDown = DropDown()
    private var groupNameDropDown = DropDown()
    private var employeeTitleDropDown = DropDown()
    private var calenderType:CalendarType = .iDExpiryEn
    private let fastisController = FastisController(mode: .single)
    
    public var empImageString = ""
    private let workTypeData = ["Full Time".localized(),"Part Time".localized(),"Contract".localized(),"Others".localized()]
    private var selectedBranchID = ""
    private var selectedNationality = ""
    private var selectedWorkType = ""
    private var selectedEmpTitle = ""
    private var selectedGroupID = ""
    private var selectedGender = ""
    private var selectedMaritalStatus = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        
    }
    
    
    private func initlization(){
        setEditBodyData()
        addSubmitObserver()
        setUpViews()
        setUpDatePicker()
        getDropDownData()
        setUpArDatePicker()
        getGroupNameEnglishData()
        setEmpImage()
    }
    
    
    private func setUpArDatePicker(){
        let datePicker = UIDatePicker()
        datePicker.locale = .init(identifier: "ar")
        datePicker.datePickerMode = .date
        datePicker.calendar = Calendar(identifier: .islamicUmmAlQura)
        datePicker.addTarget(self, action: #selector(DatePickerBirthDateAction(datePicker:)), for: .valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        birthDateArabicTextField.inputView = datePicker
        
        let datePicker2 = UIDatePicker()
        datePicker2.locale = .init(identifier: "ar")
        datePicker2.datePickerMode = .date
        datePicker2.calendar = Calendar(identifier: .islamicUmmAlQura)
        datePicker2.addTarget(self, action: #selector(DatePickerExpiryDateAction(datePicker:)), for: .valueChanged)
        datePicker2.frame.size = CGSize(width: 0, height: 300)
        datePicker2.preferredDatePickerStyle = .wheels
        
        iDExpiryDateArabicTextFiled.inputView = datePicker2
    }
    
    
    
    private func setEmpImage(){
        if let index = empImageString.firstIndex(of: ","){
            empImageString.removeSubrange(empImageString.startIndex...index)
            if let image = convertBase64StringToImage(imageBase64String: empImageString){
                userImageView.image = image
            }
        }else{
            userImageView.image = UIImage(named: "default1")!
        }
    }
    
    
    private func convertBase64StringToImage (imageBase64String:String) -> UIImage? {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        if let imageData = imageData {
            let image = UIImage(data: imageData)
            return image
        }
        
        return nil
    }
    
    
    private func addSubmitObserver(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Submit1"), object: nil, queue: .main) { notifi in
            print("Submit1")
                EditEmployeeDetailsVC.editBody.employee_id_number = self.idNumberTextField.text!
                EditEmployeeDetailsVC.editBody.branch_id = self.selectedBranchID
                EditEmployeeDetailsVC.editBody.firstname_english = self.firstNameEnTextField.text!
                EditEmployeeDetailsVC.editBody.firstname_arabic = self.firstNameArTextField.text!
                EditEmployeeDetailsVC.editBody.secondname_english = self.secondNameEnTextFiled.text!
                EditEmployeeDetailsVC.editBody.secondname_arabic = self.secondNameArTextField.text!
                EditEmployeeDetailsVC.editBody.thirdname_english = self.ThirdNameEnTextField.text!
                EditEmployeeDetailsVC.editBody.thirdname_arabic = self.thirdNameArTextField.text!
                EditEmployeeDetailsVC.editBody.lastname_english = self.lastNameEnTextField.text!
                EditEmployeeDetailsVC.editBody.lastname_arabic = self.lastNameArTextField.text!
                
                EditEmployeeDetailsVC.editBody.iqama_expiry_date_english = self.iDExpiryDateEnglishTextField.text!
                EditEmployeeDetailsVC.editBody.iqama_expiry_date_arabic = self.iDExpiryDateArabicTextFiled.text!
                EditEmployeeDetailsVC.editBody.birth_date_arabic = self.birthDateArabicTextField.text!
                EditEmployeeDetailsVC.editBody.birth_date_english = self.birthDateEnglishTextField.text!
                
                EditEmployeeDetailsVC.editBody.copy_number = self.copyNumberTextField.text!
                EditEmployeeDetailsVC.editBody.gender = self.selectedGender
                EditEmployeeDetailsVC.editBody.nationality = self.selectedNationality
                EditEmployeeDetailsVC.editBody.job_title_iqama = self.jopTitleTextField.text!
                EditEmployeeDetailsVC.editBody.religion = self.religionTextField.text!
                EditEmployeeDetailsVC.editBody.work_domain = self.workDomainTextField.text!
                EditEmployeeDetailsVC.editBody.work_location = self.workLocationTextField.text!
                EditEmployeeDetailsVC.editBody.employee_title = self.selectedEmpTitle
                EditEmployeeDetailsVC.editBody.group_id = self.selectedGroupID
                EditEmployeeDetailsVC.editBody.marital_status = self.selectedMaritalStatus
                EditEmployeeDetailsVC.editBody.work_type = self.selectedWorkType
                EditEmployeeDetailsVC.editBody.profile_image = ""
        }
    }
    
    private func setEditBodyData(){
        self.idNumberTextField.text! = EditEmployeeDetailsVC.editBody.employee_id_number
        EditEmployeeDetailsVC.editBody.employee_id_number_old =  EditEmployeeDetailsVC.editBody.employee_id_number
        self.selectedBranchID = EditEmployeeDetailsVC.editBody.branch_id
        self.branchTextField.text = self.branchsData.filter{$0.value ?? "" == EditEmployeeDetailsVC.editBody.branch_id}.first?.label ?? ""
        
        self.genderTextField.text = EditEmployeeDetailsVC.editBody.gender == "M" ? "Male".localized() : "FeMale".localized()
        self.selectedGender = EditEmployeeDetailsVC.editBody.gender
        
        self.selectedNationality = EditEmployeeDetailsVC.editBody.nationality
        self.nationalityTextField.text = self.nationalityData.filter{$0.value == EditEmployeeDetailsVC.editBody.nationality}.first?.label ?? ""
        
        self.firstNameEnTextField.text! = EditEmployeeDetailsVC.editBody.firstname_english
        self.firstNameArTextField.text! = EditEmployeeDetailsVC.editBody.firstname_arabic
        self.secondNameEnTextFiled.text! = EditEmployeeDetailsVC.editBody.secondname_english
        self.secondNameArTextField.text! = EditEmployeeDetailsVC.editBody.secondname_arabic
        self.ThirdNameEnTextField.text! = EditEmployeeDetailsVC.editBody.thirdname_english
        self.thirdNameArTextField.text! = EditEmployeeDetailsVC.editBody.thirdname_arabic
        self.lastNameEnTextField.text! = EditEmployeeDetailsVC.editBody.lastname_english
        self.lastNameArTextField.text! = EditEmployeeDetailsVC.editBody.lastname_arabic
        
        self.iDExpiryDateEnglishTextField.text = EditEmployeeDetailsVC.editBody.iqama_expiry_date_english
        self.iDExpiryDateArabicTextFiled.text = EditEmployeeDetailsVC.editBody.iqama_expiry_date_arabic
        self.birthDateEnglishTextField.text = EditEmployeeDetailsVC.editBody.birth_date_english
        self.birthDateArabicTextField.text = EditEmployeeDetailsVC.editBody.birth_date_arabic
        
        self.copyNumberTextField.text! = EditEmployeeDetailsVC.editBody.copy_number
        
        self.jopTitleTextField.text!   = EditEmployeeDetailsVC.editBody.job_title_iqama
        self.religionTextField.text!   = EditEmployeeDetailsVC.editBody.religion
        self.workDomainTextField.text!   = EditEmployeeDetailsVC.editBody.work_domain
        self.workLocationTextField.text!   = EditEmployeeDetailsVC.editBody.work_location
        
        self.selectedEmpTitle = EditEmployeeDetailsVC.editBody.employee_title
        self.employeeTitleTextField.text = self.employeeTitle.filter{$0.value == EditEmployeeDetailsVC.editBody.employee_title}.first?.label ?? ""
        
        
        self.selectedGroupID = EditEmployeeDetailsVC.editBody.group_id
        self.groupNameEnglishTextField.text = self.groupNameData.filter{$0.value == EditEmployeeDetailsVC.editBody.group_id}.first?.label ?? ""
        
        self.selectedWorkType = EditEmployeeDetailsVC.editBody.work_type
        
        if let number = Int(EditEmployeeDetailsVC.editBody.work_type) , number < self.workTypeData.count{
            self.workTypeTextField.text = self.workTypeData[number + 1]
        }
        
        self.selectedMaritalStatus = EditEmployeeDetailsVC.editBody.marital_status
        if EditEmployeeDetailsVC.editBody.marital_status == "S"{
            self.maritalStatusTextField.text = "Single".localized()
        }else if EditEmployeeDetailsVC.editBody.marital_status == "M"{
            self.maritalStatusTextField.text = "Married".localized()
        }else if EditEmployeeDetailsVC.editBody.marital_status == "D"{
            self.maritalStatusTextField.text = "Diversed".localized()
        }else{
            self.maritalStatusTextField.text = "Others".localized()
        }
        
    }
    
    private func setUpViews(){
        
        setUpTextFieldsAction()
        
        // branchDropDown
        branchDropDown.anchorView = branchTextField
        branchDropDown.bottomOffset = CGPoint(x: 0, y:(branchDropDown.anchorView?.plainView.bounds.height)!)
        
        branchDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            branchArrow.transform = .init(rotationAngle: 0)
            self.branchTextField.text = item
            self.selectedBranchID = branchsData[index].value ?? ""
        }
        
        branchDropDown.cancelAction = { [unowned self] in
            branchArrow.transform = .init(rotationAngle: 0)
        }
        
        // maritalStatusDropDown
        maritalStatusDropDown.anchorView = maritalStatusTextField
        
        maritalStatusDropDown.dataSource = ["Single".localized(),"Married".localized(),"Diversed".localized(),"Others".localized()]
        
        maritalStatusDropDown.bottomOffset = CGPoint(x: 0, y:(maritalStatusDropDown.anchorView?.plainView.bounds.height)!)
        
        maritalStatusDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            maritalStatusArrow.transform = .init(rotationAngle: 0)
            self.maritalStatusTextField.text = item
            switch index {
            case 0:
                self.selectedMaritalStatus = "S"
            case 1:
                self.selectedMaritalStatus = "M"
            case 2:
                self.selectedMaritalStatus = "D"
            case 3:
                self.selectedMaritalStatus = "O"
            default:
                break
            }
        }
        
        
        maritalStatusDropDown.cancelAction = { [unowned self] in
            maritalStatusArrow.transform = .init(rotationAngle: 0)
        }
        
        
        // genderDropDown
        genderDropDown.anchorView = genderTextField
        genderDropDown.dataSource = ["Male".localized(),"FeMale".localized()]
        genderDropDown.bottomOffset = CGPoint(x: 0, y:(genderDropDown.anchorView?.plainView.bounds.height)!)
        
        genderDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            genderArrow.transform = .init(rotationAngle: 0)
            self.genderTextField.text = item
            self.selectedGender = index == 0 ? "M" : "F"
            
        }

        
        genderDropDown.cancelAction = { [unowned self] in
            genderArrow.transform = .init(rotationAngle: 0)
        }
        
        
        
        // nationalityDropDown
        nationalityDropDown.anchorView = nationalityTextField
        nationalityDropDown.bottomOffset = CGPoint(x: 0, y:(nationalityDropDown.anchorView?.plainView.bounds.height)!)
        
        nationalityDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            nationalityArrow.transform = .init(rotationAngle: 0)
            self.nationalityTextField.text = item
            self.selectedNationality = self.nationalityData[index].value ?? ""
        }
        
        nationalityDropDown.cancelAction = { [unowned self] in
            nationalityArrow.transform = .init(rotationAngle: 0)
        }
        
        
        // workTypeDropDown
        workTypeDropDown.anchorView = workTypeTextField
        workTypeDropDown.dataSource = workTypeData
        workTypeDropDown.bottomOffset = CGPoint(x: 0, y:(workTypeDropDown.anchorView?.plainView.bounds.height)!)
        
        workTypeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            workTypeArrow.transform = .init(rotationAngle: 0)
            self.workTypeTextField.text = item
            self.selectedWorkType = "\(index + 1)"
        }
        
        workTypeDropDown.cancelAction = { [unowned self] in
            workTypeArrow.transform = .init(rotationAngle: 0)
        }
        
        
        // groupNameDropDown
        groupNameDropDown.anchorView = groupNameEnglishTextField
        groupNameDropDown.bottomOffset = CGPoint(x: 0, y:(groupNameDropDown.anchorView?.plainView.bounds.height)!)
        groupNameDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            groupNameEnArrow.transform = .init(rotationAngle: 0)
            self.groupNameEnglishTextField.text = item
            self.selectedGroupID = groupNameData[index].value ?? ""
        }
        
        groupNameDropDown.cancelAction = { [unowned self] in
            groupNameEnArrow.transform = .init(rotationAngle: 0)
        }
        
        
        // employeeTitleDropDown
        employeeTitleDropDown.anchorView = employeeTitleTextField
        employeeTitleDropDown.bottomOffset = CGPoint(x: 0, y:(employeeTitleDropDown.anchorView?.plainView.bounds.height)!)
        employeeTitleDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            employeeTitleArrow.transform = .init(rotationAngle: 0)
            self.employeeTitleTextField.text = item
            self.selectedEmpTitle = employeeTitle[index].value ?? ""
        }
        
        employeeTitleDropDown.cancelAction = { [unowned self] in
            employeeTitleArrow.transform = .init(rotationAngle: 0)
        }
        
    }
    
    private func setUpTextFieldsAction(){
        branchTextField.isUserInteractionEnabled = true
        maritalStatusTextField.isUserInteractionEnabled = true
        genderTextField.isUserInteractionEnabled = true
        nationalityTextField.isUserInteractionEnabled = true
        workTypeTextField.isUserInteractionEnabled = true
        groupNameEnglishTextField.isUserInteractionEnabled = true
        employeeTitleTextField.isUserInteractionEnabled = true
        
        branchTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(branchTextFieldAction)))
        maritalStatusTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(maritalStatusTextFieldAction)))
        genderTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(genderTextFieldAction)))
        nationalityTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nationalityTextFieldAction)))
        workTypeTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(workTypeTextFieldAction)))
        groupNameEnglishTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(groupNameEnglishTextFieldAction)))
        employeeTitleTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(employeeTitleTextFieldAction)))
        
    }
    
    
    private func setUpDatePicker(){
        fastisController.title = "Choose Date".localized()
        fastisController.allowToChooseNilDate = true
        
        fastisController.shortcuts = [.today]
        fastisController.doneHandler = { result in
            
            switch self.calenderType {
            case .iDExpiryEn:
                if let result = result{
                    self.iDExpiryDateEnglishTextField.text = self.formatedDate(date:result)
                    self.iDExpiryDateArabicTextFiled.text = self.convertDateToHijri(date: result)
                }else{
                    self.iDExpiryDateEnglishTextField.text = ""
                    self.iDExpiryDateArabicTextFiled.text = ""
                }
            case .birthDateEn:
                if let result = result{
                    self.birthDateEnglishTextField.text = self.formatedDate(date:result)
                    self.birthDateArabicTextField.text = self.convertDateToHijri(date:result)
                }else{
                    self.birthDateEnglishTextField.text = ""
                    self.birthDateArabicTextField.text = ""
                    
                }
            }
        }
    }
    
    
    
    @objc private func branchTextFieldAction(){
        branchDropDown.show()
    }
    
    @objc private func maritalStatusTextFieldAction(){
        
        maritalStatusDropDown.show()
        
    }
    
    @objc private func genderTextFieldAction(){
        
        genderDropDown.show()
        
    }
    
    @objc private func nationalityTextFieldAction(){
        
        nationalityDropDown.show()
        
    }
    
    @objc private func workTypeTextFieldAction(){
        
        workTypeDropDown.show()
        
    }
    
    
    @objc private func groupNameEnglishTextFieldAction(){
        groupNameDropDown.show()
    }
    
    
    @objc private func employeeTitleTextFieldAction(){
        employeeTitleDropDown.show()
        
    }
    
    
    
    @objc private func DatePickerBirthDateAction(datePicker:UIDatePicker){
        self.birthDateEnglishTextField.text = self.convertDateToGregorian(date:datePicker.date)
        self.birthDateArabicTextField.text = self.convertDateToHijri(date: datePicker.date)
    }
    
    @objc private func DatePickerExpiryDateAction(datePicker:UIDatePicker){
        self.iDExpiryDateEnglishTextField.text = self.convertDateToGregorian(date:datePicker.date)
        self.iDExpiryDateArabicTextFiled.text = self.convertDateToHijri(date: datePicker.date)
    }
    
    
    @IBAction func iDExpiryEnCalenderAction(_ sender: Any) {
        calenderType = .iDExpiryEn
        fastisController.present(above: self)
    }
    
    @IBAction func birthDateEnCalenderAction(_ sender: Any) {
        calenderType = .birthDateEn
        fastisController.present(above: self)
    }
    
    
    
    @IBAction func cameriaAction(_ sender: Any) {
        let alertVC = UIAlertController(title: "Take a photo from".localized(), message: "", preferredStyle: .actionSheet)
        alertVC.addAction(.init(title: "Gallery".localized(), style: .default,handler: { action in
            self.setImageBy(source: .photoLibrary)
        }))
        alertVC.addAction(.init(title: "Camera".localized(), style: .default,handler: { action in
            self.setImageBy(source: .camera)
        }))
        present(alertVC, animated: true)
    }
    
    
}



// MARK: - API Handling

extension IDDetailsViewController{
    func getDropDownData(){
        APIController.shard.getDropDownData { data in
            if let status = data.status,status{
                self.branchsData = data.branches ?? []
                self.branchDropDown.dataSource = (data.branches ?? []).map{$0.label ?? ""}
                
                self.nationalityData = data.countries ?? []
                self.nationalityDropDown.dataSource = (data.countries ?? []).map{$0.label ?? ""}
                
                self.employeeTitle = data.titles ?? []
                self.employeeTitleDropDown.dataSource = (data.titles ?? []).map{$0.label ?? ""}
            }
        }
    }
    
    func getGroupNameEnglishData(){
        APIController.shard.getGroupNameEnglish { data in
            if let status = data.status,status{
                self.groupNameData = data.grouplists ?? []
                self.groupNameDropDown.dataSource = (data.grouplists ?? []).map{$0.label ?? ""}
            }
        }
    }
    
}


extension IDDetailsViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    private func setImageBy(source:UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editingImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            userImageView.image = editingImage
        }else if let orginalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userImageView.image = orginalImage
        }
        
        EditEmployeeDetailsVC.empImage = userImageView.image!
        dismiss(animated: true, completion: nil)
    }
    
}


enum CalendarType{
    case iDExpiryEn,
         birthDateEn
}




extension UIViewController{
    func convertDateToHijri(date:Date)->String{
        let islamic = NSCalendar(identifier:NSCalendar.Identifier(rawValue: NSCalendar.Identifier.islamicCivil.rawValue))!
        let components = islamic.components(NSCalendar.Unit(rawValue: UInt.max), from: date)
        let month = "\(components.month ?? 0)".count == 1 ? "0\(components.month ?? 0)" : "\(components.month ?? 0)"
        let day = "\(components.day ?? 0)".count == 1 ? "0\(components.day ?? 0)" : "\(components.day ?? 0)"
        return "\(components.year ?? 0)/\(month)/\(day)"
    }
    
    func convertDateToGregorian(date:Date)->String{
        let gregorian = NSCalendar(identifier:NSCalendar.Identifier(rawValue: NSCalendar.Identifier.gregorian.rawValue))!
        let components = gregorian.components(NSCalendar.Unit(rawValue: UInt.max), from: date)
        let month = "\(components.month ?? 0)".count == 1 ? "0\(components.month ?? 0)" : "\(components.month ?? 0)"
        let day = "\(components.day ?? 0)".count == 1 ? "0\(components.day ?? 0)" : "\(components.day ?? 0)"
        return "\(components.year ?? 0)/\(month)/\(day)"
    }
    
}
