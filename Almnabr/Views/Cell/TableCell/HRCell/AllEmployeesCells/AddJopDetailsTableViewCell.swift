//
//  AddJopDetailsTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 14/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import Fastis

protocol AddJopDetailsCellDelegate{
    func deleteCell(indexPath:IndexPath)
}

typealias AddJopDetailsDelegate = UIViewController & AddJopDetailsCellDelegate

class AddJopDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var licenceNameTextField: UITextField!
    @IBOutlet weak var licenceNumberTextField: UITextField!
    @IBOutlet weak var issueDateEnTextField: UITextField!
    @IBOutlet weak var issueDateArTextField: UITextField!
    @IBOutlet weak var expiryDateEnTextField: UITextField!
    @IBOutlet weak var expiryDateArTextField: UITextField!
    private var fastisController = FastisController(mode: .single)
    private var isIssueData = true
    var delegate:AddJopDetailsDelegate?
    private var indexPath:IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        licenceNameTextField.isEnabled = false
        setUpCalenderController()
        setUpArDatePicker()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setUpCalenderController(){
        issueDateEnTextField.isEnabled = false
        expiryDateEnTextField.isEnabled = false
        
        fastisController.title = "Choose Date"
        fastisController.allowToChooseNilDate = true
        fastisController.shortcuts = [.today]
        
        fastisController.doneHandler = { result in
            if self.isIssueData{
                if let result = result{
                    self.issueDateEnTextField.text = self.delegate?.formatedDate(date: result)
                    self.issueDateArTextField.text = self.delegate?.convertDateToHijri(date: result)
                }else{
                    self.issueDateEnTextField.text = ""
                    self.issueDateArTextField.text = ""
                }
            }else{
                if let result = result{
                    self.expiryDateEnTextField.text = self.delegate?.formatedDate(date: result)
                    self.expiryDateArTextField.text = self.delegate?.convertDateToHijri(date: result)
                }else{
                    self.expiryDateEnTextField.text = ""
                    self.expiryDateArTextField.text = ""
                }
            }
        }
    }
    
    private func setUpArDatePicker(){
        let datePicker = UIDatePicker()
        datePicker.locale = .init(identifier: "ar")
        datePicker.datePickerMode = .date
        datePicker.calendar = Calendar(identifier: .islamicUmmAlQura)
        datePicker.addTarget(self, action: #selector(issueDateArTextFieldAction(datePicker:)), for: .valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        issueDateArTextField.inputView = datePicker
        
        let datePicker2 = UIDatePicker()
        datePicker2.locale = .init(identifier: "ar")
        datePicker2.datePickerMode = .date
        datePicker2.calendar = Calendar(identifier: .islamicUmmAlQura)
        datePicker2.addTarget(self, action: #selector(expiryDateArTextFieldAction(datePicker:)), for: .valueChanged)
        datePicker2.frame.size = CGSize(width: 0, height: 300)
        datePicker2.preferredDatePickerStyle = .wheels
        expiryDateArTextField.inputView = datePicker2
    }
    
    
    
    @objc private func issueDateArTextFieldAction(datePicker:UIDatePicker){
        self.issueDateEnTextField.text = self.delegate?.formatedDate(date: datePicker.date)
        self.issueDateArTextField.text = self.delegate?.convertDateToHijri(date: datePicker.date)
    }
    
    
    
    @objc private func expiryDateArTextFieldAction(datePicker:UIDatePicker){
        self.expiryDateEnTextField.text = self.delegate?.formatedDate(date: datePicker.date)
        self.expiryDateArTextField.text = self.delegate?.convertDateToHijri(date: datePicker.date)
    }
    
    
    func setData(isView:Bool,data:Licenses,indexPath:IndexPath){
        
        licenceNumberTextField.isEnabled = !isView
        issueDateArTextField.isEnabled = !isView
        expiryDateArTextField.isEnabled = !isView

        self.indexPath = indexPath
        licenceNameTextField.text = data.licence_name ?? ""
        licenceNumberTextField.text = data.licence_number ?? ""
        issueDateEnTextField.text = data.licence_issue_date_english ?? ""
        issueDateArTextField.text = data.licence_issue_date_arabic ?? ""
        expiryDateEnTextField.text = data.licence_expiry_date_english ?? ""
        expiryDateArTextField.text = data.licence_expiry_date_arabic ?? ""
    }
    
    
    @IBAction func deleteAction(_ sender: Any) {
        delegate?.deleteCell(indexPath: indexPath)
    }
    
    
    @IBAction func issueDateEnAction(_ sender: Any) {
        isIssueData = true
        fastisController.present(above: delegate!.self)
    }
    
    
    @IBAction func expiryDateEnAction(_ sender: Any) {
        isIssueData = false
        fastisController.present(above: delegate!.self)
    }
    
    
}



