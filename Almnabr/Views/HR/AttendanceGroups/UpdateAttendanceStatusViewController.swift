//
//  UpdateAttendanceStatusViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 02/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import Fastis
import SCLAlertView
class UpdateAttendanceStatusViewController: UIViewController {
    
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var statusArrow: UIImageView!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    private let userSelectionView = UsersSearchView(frame: .init())
    
    private var selectedUser:SearchBranchRecords?
    
    private let statusDropDown = DropDown()
    private let statusData = ["ok":"Ok","not_ok":"Not Ok","absent":"Absent","no_settings":"No Settings","record_missing":"Record Missing"]
    private var selectedStatus = ""
    
    private var fastisController = FastisController(mode: .single)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlizaiton()
        // Do any additional setup after loading the view.
    }
    
    private func initlizaiton(){
        adddUserSelectionView()
        setUpDropDownList()
        setUpDateSelector()
        statusTextField.addTapGesture {
            self.statusArrow.transform = .init(rotationAngle: .pi)
            self.statusDropDown.show()
        }
        dateTextField.addTapGesture {
            self.fastisController.present(above: self)
        }
    }
    
    private func setUpDropDownList(){
        //  statusDropDown
        statusDropDown.anchorView = statusTextField
        statusDropDown.bottomOffset = CGPoint(x: 0, y:(statusDropDown.anchorView?.plainView.bounds.height)!)
        statusDropDown.dataSource = Array(statusData.values)
        statusDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            statusArrow.transform = .init(rotationAngle: 0)
            selectedStatus = statusData.someKey(forValue: item) ?? ""
            self.statusTextField.text = item
        }
        
        statusDropDown.cancelAction = { [unowned self] in
            statusArrow.transform = .init(rotationAngle: .pi)
        }
        
    }
    
    private func setUpDateSelector() {
        fastisController.title = "Choose Date"
        
        fastisController.allowToChooseNilDate = false
        fastisController.shortcuts = [.today]
        fastisController.doneHandler = { result in
            if let date = result {
                DispatchQueue.main.async {
                    self.dateTextField.text = self.formatedDate(date: date)
                }
            }
        }
        
    }
    
    private func adddUserSelectionView(){
        userSelectionView.selectionType = .singleSelection
        userSelectionView.usersResult = { result in
            self.selectedUser = result.first
        }
        mainStackView.insertArrangedSubview(userSelectionView, at: 3)
    }
    
    
    @IBAction func closeAction(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        updateStatusAttendance()
    }
    
    
    
}

// MARK: - API Handling
extension UpdateAttendanceStatusViewController{
    private func updateStatusAttendance(){
        showLoadingActivity()
        APIController.shard.updateStatusAttendance(status: selectedStatus, userId: selectedUser?.value ?? "", date: dateTextField.text!) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status, status{
                    SCLAlertView().showSuccess("Success".localized(), subTitle: data.msg ?? "")
                    self.navigationController?.dismiss(animated: true)
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
            }
        }
    }
}



extension Dictionary where Value: Equatable {
    func someKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}
