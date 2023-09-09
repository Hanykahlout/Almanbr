//
//  UpdateShiftViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 03/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import Fastis
import SCLAlertView
class UpdateShiftViewController: UIViewController {

    @IBOutlet weak var shiftStartTimeView: UIView!
    @IBOutlet weak var shiftEndTimeView: UIView!
    @IBOutlet weak var checkInStartView: UIView!
    @IBOutlet weak var checkInEndView: UIView!
    @IBOutlet weak var checkOutStartView: UIView!
    @IBOutlet weak var checkOutEndView: UIView!
    
    
    @IBOutlet weak var shiftStartTimeTextField: UITextField!
    @IBOutlet weak var shiftEndTimeTextField: UITextField!
    @IBOutlet weak var checkInStartTextField: UITextField!
    @IBOutlet weak var checkInEndTextField: UITextField!
    @IBOutlet weak var checkOutStartTextField: UITextField!
    @IBOutlet weak var checkOutEndTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var usersStackView: UIStackView!
    @IBOutlet weak var mainStackView: UIStackView!
    
    private let fastisController = FastisController(mode: .single)
    private var selectedUsers = [SearchBranchRecords]()
    private let pickerStackView = UIStackView()
    private let timePicker = UIDatePicker()
    private var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func initialization(){
        setUpTimePicker()
        addUserSelectionTextField()
        shiftStartTimeTextField.isEnabled = false
        shiftEndTimeTextField.isEnabled = false
        checkInStartTextField.isEnabled = false
        checkInEndTextField.isEnabled = false
        checkOutStartTextField.isEnabled = false
        checkOutEndTextField.isEnabled = false
        shiftStartTimeView.addTapGesture {
            self.selectedIndex = 0
            self.pickerStackView.isHidden = false
        }
        
        shiftEndTimeView.addTapGesture {
            self.selectedIndex = 1
            self.pickerStackView.isHidden = false
        }
        
        checkInStartView.addTapGesture {
            self.selectedIndex = 2
            self.pickerStackView.isHidden = false
        }
        
        checkInEndView.addTapGesture {
            self.selectedIndex = 3
            self.pickerStackView.isHidden = false
        }
        
        checkOutStartView.addTapGesture {
            self.selectedIndex = 4
            self.pickerStackView.isHidden = false
        }
        
        checkOutEndView.addTapGesture {
            self.selectedIndex = 5
            self.pickerStackView.isHidden = false
        }
        
        dateTextField.addTapGesture {
            self.fastisController.present(above: self)
        }
        setUpDatePickerController()
    }

    
    private func addUserSelectionTextField(){
        let usersSelector = UsersSearchView(frame: .init())
        usersSelector.selectionType = .multiSelection
        usersSelector.usersResult = { users in
            self.selectedUsers = users
        }
        usersStackView.insertArrangedSubview(usersSelector, at: 0)
    }

    private func setUpDatePickerController(){
            fastisController.title = "Choose Date"
            
            fastisController.allowToChooseNilDate = false
            fastisController.shortcuts = [.today]
            fastisController.doneHandler = { resultRange in
                self.dateTextField.text = self.formatedDate(date: resultRange)
            }
    }
    
    private func setUpTimePicker()  {
        
        pickerStackView.corner_radius = 10
        pickerStackView.clipsToBounds = true
        pickerStackView.backgroundColor = maincolor
        pickerStackView.axis = .vertical
        pickerStackView.spacing = 10
        
        let buttonView = UIView()
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.backgroundColor = .clear
        buttonView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        let doneButton = UIButton()
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.addTarget(self, action: #selector(doneTimePickerAction), for: .touchUpInside)
        doneButton.setTitle("Done", for: .normal)
        doneButton.clipsToBounds = true
        doneButton.corner_radius = 10
        doneButton.setTitleColor(maincolor, for: .normal)
        doneButton.backgroundColor = .white

        buttonView.addSubview(doneButton)
        doneButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor, constant: 0).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor, constant: -15).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        
        timePicker.datePickerMode = .countDownTimer
        timePicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        pickerStackView.addArrangedSubview(buttonView)
        pickerStackView.addArrangedSubview(timePicker)
        
        mainStackView.addArrangedSubview(pickerStackView)
        pickerStackView.isHidden = true
    }
    
    
    @objc private func doneTimePickerAction(){
        let time = formattedTime(date: timePicker.date)
        switch selectedIndex{
        case 0:
            self.shiftStartTimeTextField.text = time
        case 1:
            self.shiftEndTimeTextField.text = time
        case 2:
            self.checkInStartTextField.text = time
        case 3:
            self.checkInEndTextField.text = time
        case 4:
            self.checkOutStartTextField.text = time
        case 5:
            self.checkOutEndTextField.text = time
        default:
            break
        }
        self.pickerStackView.isHidden = true
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        updateShift()
    }
    

}

extension UpdateShiftViewController{
    private func updateShift(){
        var body = [
            "shift_start_time": shiftStartTimeTextField.text!,
            "shift_end_time": shiftEndTimeTextField.text!,
            "check_in_start": checkInStartTextField.text!,
            "check_in_end": checkInEndTextField.text!,
            "check_out_start":checkOutStartTextField.text!,
            "check_out_end": checkOutEndTextField.text!,
            "date[0]": dateTextField.text!
        ]
        
        for index in 0..<selectedUsers.count{
            body["user_id[\(index)]"] = selectedUsers[index].value ?? ""
        }
        
        showLoadingActivity()
        APIController.shard.createShiftGroups(url: "/at/update_shift_seetings", body: body) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    self.navigationController?.popViewController(animated: true)
                    SCLAlertView().showSuccess("Success".localized(), subTitle: data.msg ?? "")
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.msg ?? "")
                }
            }
        }
    }
}
