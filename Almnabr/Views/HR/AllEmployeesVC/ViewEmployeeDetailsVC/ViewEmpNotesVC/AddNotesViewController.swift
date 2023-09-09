//
//  AddNotesViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 20/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import Fastis
class AddNotesViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var reminderStatusTextField: UITextField!
    @IBOutlet weak var reminderStatusArrow: UIImageView!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var remainderDateTextField: UITextField!
    @IBOutlet weak var statusArrow: UIImageView!
    @IBOutlet weak var linkListTextField: UITextField!
    @IBOutlet weak var linkListArrow: UIImageView!
    
    @IBOutlet weak var calenderButton: UIButton!
    
    private var reminderStatusDropDown = DropDown()
    private var statusDropDown = DropDown()
    private var linkListDropDown = DropDown()
    private var dateController = FastisController(mode:.single)
    private var reminderStatusSelection = "0"
    private var statusSelection = "0"
    private var linkListSelection = "0"
    var data:NoteRecords?
    var isView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }
    
    private func initlization(){
        if L102Language.currentAppleLanguage() == "ar"{
            backButton.transform = .init(rotationAngle: .pi)
        }
        setUpDropDownLists()
        setUpDateController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        descriptionTextView.isEditable = !isView
        reminderStatusTextField.isEnabled = !isView
        statusTextField.isEnabled = !isView
        linkListTextField.isEnabled = !isView
        submitButton.isHidden = isView
        if let data = data {
            
            descriptionTextView.text = data.note_description ?? ""
            
            reminderStatusSelection = data.note_remainder_status ?? ""
            reminderStatusTextField.text = reminderStatusSelection == "1" ? "Yes".localized() : "No".localized()
            
            remainderDateTextField.isHidden = reminderStatusSelection != "1"
            calenderButton.isHidden = reminderStatusSelection != "1"
            remainderDateTextField.text = data.note_remainder_date ?? ""
            
            statusSelection = data.show_status ?? ""
            statusTextField.text = statusSelection == "1" ? "Public".localized() : "Private".localized()
            
            linkListSelection = data.link_with_view_list ?? ""
            linkListTextField.text = linkListSelection == "1" ? "Yes".localized() : "No".localized()

        }
        
        
        
        
    }
    
    private func setUpDateController(){
        dateController.title = "Choose Date".localized()
        
        dateController.allowToChooseNilDate = true
        dateController.shortcuts = [.today]
        dateController.doneHandler = { result in
            if let result = result{
                self.remainderDateTextField.text = self.formatedDate(date: result)
            }else{
                self.remainderDateTextField.text = ""
            }
        }
    }
    
    
    private func setUpDropDownLists(){
        //  reminderStatusDropDown
        reminderStatusDropDown.anchorView = reminderStatusTextField
        
        reminderStatusDropDown.bottomOffset = CGPoint(x: 0, y:(reminderStatusDropDown.anchorView?.plainView.bounds.height)!)
        reminderStatusDropDown.dataSource = ["Yes".localized(),"No".localized()]
        reminderStatusDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.reminderStatusArrow.transform = .init(rotationAngle: 0)
            self.reminderStatusTextField.text = item
            let isNo = item == "No".localized()
            self.calenderButton.isHidden = isNo
            self.remainderDateTextField.isHidden = isNo
            self.reminderStatusSelection = isNo ? "0" : "1"
            
        }
        
        reminderStatusDropDown.cancelAction = { [unowned self] in
            self.reminderStatusArrow.transform = .init(rotationAngle: 0)
        }
        reminderStatusTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(reminderStatusAction)))
        
        // statusDropDown
        
        statusDropDown.anchorView = statusTextField
        statusDropDown.dataSource = ["Public".localized(),"Private".localized()]
        statusDropDown.bottomOffset = CGPoint(x: 0, y:(statusDropDown.anchorView?.plainView.bounds.height)!)
        statusDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.statusArrow.transform = .init(rotationAngle: 0)
            self.statusTextField.text = item
            let isPrivate = item == "Private".localized()
            self.statusSelection = isPrivate ? "0" : "1"
        }
        
        statusDropDown.cancelAction = { [unowned self] in
            self.statusArrow.transform = .init(rotationAngle: 0)
        }
        statusTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(statusAction)))
        
        
        // linkListDropDown
        linkListDropDown.anchorView = linkListTextField
        linkListDropDown.dataSource = ["Yes".localized(),"No".localized()]
        linkListDropDown.bottomOffset = CGPoint(x: 0, y:(linkListDropDown.anchorView?.plainView.bounds.height)!)
        
        linkListDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.linkListArrow.transform = .init(rotationAngle: 0)
            self.linkListTextField.text = item
            let isNo = item == "No".localized()
            self.linkListSelection = isNo ? "0" : "1"
        }
        
        linkListDropDown.cancelAction = { [unowned self] in
            self.linkListArrow.transform = .init(rotationAngle: 0)
        }
        linkListTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(linkListAction)))
        
    }
    
    @objc private func reminderStatusAction(){
        reminderStatusArrow.transform = .init(rotationAngle: .pi)
        reminderStatusDropDown.show()
    }
    
    @objc private func statusAction(){
        statusArrow.transform = .init(rotationAngle: .pi)
        statusDropDown.show()
    }
    
    @objc private func linkListAction(){
        linkListArrow.transform = .init(rotationAngle: .pi)
        linkListDropDown.show()
    }
    
    @IBAction func backAciton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func calenderAction(_ sender: Any) {
        dateController.present(above: self)
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        addNote()
    }
    
}

// MARK: - API Handling
extension AddNotesViewController{
    private func addNote(){
        let description = descriptionTextView.text!
        let reminderDate = remainderDateTextField.text!
        let empId = ViewEmployeeDetailsVC.empData.data?.employee_number ?? ""
        showLoadingActivity()
        APIController.shard.addNote(note_id:data?.note_id,description: description, reminderStatusSelection: reminderStatusSelection, reminderDate: reminderDate, statusSelection: statusSelection, linkListSelection: linkListSelection, empId: empId) { data in
            DispatchQueue.main.async{
                self.hideLoadingActivity()
                var alertVC:UIAlertController!
                if let status = data.status,status{
                    alertVC = UIAlertController(title: "Success".localized(), message: data.msg, preferredStyle: .alert)
                    alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel,handler: { action in
                        NotificationCenter.default.post(name: .init(rawValue: "ReloadNotes"), object: nil)
                        self.navigationController?.popViewController(animated: true)
                    }))
                }else{
                    alertVC = UIAlertController(title: "error".localized(), message: data.error, preferredStyle: .alert)
                    alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel))
                }
                self.present(alertVC, animated: true)
            }
        }
    }
}


