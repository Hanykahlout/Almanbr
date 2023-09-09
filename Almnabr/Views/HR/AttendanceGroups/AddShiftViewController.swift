//
//  AddShiftViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 02/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import SCLAlertView
class AddShiftViewController: UIViewController {
    
    @IBOutlet weak var titleEnTextField: UITextField!
    
    
    @IBOutlet weak var titleArTextField: UITextField!
    
    @IBOutlet weak var emptySelectionGroupsLabel: UILabel!
    @IBOutlet weak var selectGroupView: UIView!
    @IBOutlet weak var groupsArrow: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var submitButton: UIButton!
    
    
    var data:ShiftsRecords?
    private var groupDropDown = DropDown()
    private var groups = [SearchBranchRecords]()
    private var selectedGroups = [SearchBranchRecords]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    
    private func initlization(){
        setUpDropDownList()
        setUpCollectionView()
        selectGroupView.addTapGesture {
            self.groupsArrow.transform = .init(rotationAngle: .pi)
            self.groupDropDown.show()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getShiftsGroups()
        
    }
    
    
    private func receiveDate(){
        if let data = data{
            submitButton.setTitle("Update".localized(), for: .normal)
            titleEnTextField.text = data.shift_title_english ?? ""
            titleArTextField.text = data.shift_title_arabic ?? ""
            
            for group in data.groups!{
                if let selectedGroup = self.groups.filter({$0.value == group.group_id}).first{
                    self.selectedGroups.append(selectedGroup)
                }
            }
            self.collectionView.reloadData()
        }else{
            submitButton.setTitle("Save".localized(), for: .normal)
        }
    }
    
    
    private func setUpDropDownList(){
        //        groupDropDown
        groupDropDown.anchorView = selectGroupView
        groupDropDown.bottomOffset = CGPoint(x: 0, y:(groupDropDown.anchorView?.plainView.bounds.height)!)
        
        groupDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if !self.groups.isEmpty{
                groupsArrow.transform = .init(rotationAngle: 0)
                let objc = self.groups[index]
                if !self.selectedGroups.contains(where: {$0.value == objc.value}){
                    self.selectedGroups.append(objc)
                    self.collectionView.reloadData()
                    self.collectionView.isHidden = false
                    emptySelectionGroupsLabel.isHidden = true
                }
            }
        }
        
        groupDropDown.cancelAction = { [unowned self] in
            self.groupsArrow.transform = .init(rotationAngle: .pi)
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
    @IBAction func submitAction(_ sender: Any) {
        createShift()
    }
    
}


// MARK: - Collection View Delegate
extension AddShiftViewController: UICollectionViewDelegate , UICollectionViewDataSource{
    private func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(.init(nibName: "UsersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UsersCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsersCollectionViewCell", for: indexPath) as! UsersCollectionViewCell
        let objc = selectedGroups[indexPath.row]
        cell.indexPath = indexPath
        cell.titleLabel.text = objc.label ?? ""
        cell.delegate = self
        return cell
    }
}

// MARK: - Collection View Cell Delegate
extension AddShiftViewController: UsersCollectionViewCellDelegate{
    func removeAction(indexPath: IndexPath) {
        selectedGroups.remove(at: indexPath.row)
        collectionView.reloadData()
        emptySelectionGroupsLabel.isHidden = !selectedGroups.isEmpty
    }
}

// MARK: - API Controller
extension AddShiftViewController {
    private func getShiftsGroups(){
        showLoadingActivity()
        APIController.shard.getShiftsGroups { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status ,status{
                    self.groups = data.records ?? []
                    self.groupDropDown.dataSource = self.groups.map{$0.label ?? ""}
                    self.receiveDate()
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
            }
        }
    }
    
    private func createShift(){
        
        var body = [
            "shift_title_english":titleEnTextField.text!,
            "shift_title_arabic":titleArTextField.text!
        ]
        
        for index in 0..<selectedGroups.count{
            body["groups[\(index)]"] = selectedGroups[index].value ?? ""
        }
        
        showLoadingActivity()
        APIController.shard.createShiftGroups(url:data == nil ? "/at/create_shifts": "/at/update_shifts/\(data!.shift_id ?? "")",body: body) { data in
            DispatchQueue.main.async{
                self.hideLoadingActivity()
                if let status = data.status, status{
                    SCLAlertView().showSuccess("Success".localized(), subTitle: data.msg ?? "")
                    NotificationCenter.default.post(name: .init("UpdateShiftsGroups"), object: nil)
                    self.navigationController?.dismiss(animated: true)
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
            }
        }
    }
    
    
}
