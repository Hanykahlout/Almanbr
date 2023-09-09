//
//  AddPermissionMentionsVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 04/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown

class AddPermissionMentionsVC: UIViewController {
    
    @IBOutlet weak var branchView: UIView!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var branchArrow: UIImageView!
    
    @IBOutlet weak var groupView: UIView!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var groupsArrow: UIImageView!
    
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userArrow: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var branchDropDown = DropDown()
    private var groupDropDown = DropDown()
    private var userDropDown = DropDown()
    
    private var branchsData = [SearchBranchRecords]()
    private var groupsData = [SearchBranchRecords]()
    private var usersData = [SearchBranchRecords]()
    private var selectedUsersData = [SearchBranchRecords]()
    
    private var selectedBranchIndex = -1
    private var selectedGroupIndex = -1
    private var selectedUserIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    
    private func initlization(){
        if L102Language.currentAppleLanguage() == "ar" {
            backButton.transform = .init(rotationAngle: .pi)
        }
        userLabel.isHidden = false
        getBranchsMenu()
        getGroupMenu()
        getUsersMenu()
        setUpDropDownLists()
        setUpCollectionView()
        setUpViews()
    }
    
    
    private func setUpData(){
        
    }
    
    
    private func setUpViews(){
        branchView.isUserInteractionEnabled = true
        branchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(branchViewAction)))
        groupView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(groupViewAction)))
        userView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userViewAction)))
    }
    
    
    private func setUpDropDownLists(){
        // Search Drop Down List
        branchDropDown.anchorView = branchView
        
        branchDropDown.bottomOffset = CGPoint(x: 0, y:(branchDropDown.anchorView?.plainView.bounds.height)!)
        
        branchDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            branchArrow.transform = .init(rotationAngle: 0)
            self.branchLabel.text = item
            self.selectedBranchIndex = index
            
        }
        branchDropDown.cancelAction = { [unowned self] in
            branchArrow.transform = .init(rotationAngle: 0)
        }
        
        // Group Drop Down List
        groupDropDown.anchorView = groupView
        groupDropDown.bottomOffset = CGPoint(x: 0, y:(groupDropDown.anchorView?.plainView.bounds.height)!)
        groupDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            groupsArrow.transform = .init(rotationAngle: 0)
            self.groupLabel.text = item
            self.selectedGroupIndex = index
        }
        
        groupDropDown.cancelAction = { [unowned self] in
            groupsArrow.transform = .init(rotationAngle: 0)
        }
        
        
        // Users Drop Down List
        userDropDown.anchorView = userView
        userDropDown.bottomOffset = CGPoint(x: 0, y:(userDropDown.anchorView?.plainView.bounds.height)!)
        userDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            userArrow.transform = .init(rotationAngle: 0)
            userLabel.text = item
            self.selectedUserIndex = index
            self.selectedUsersData.append(self.usersData[index])
            self.userLabel.isHidden = true
            self.collectionView.reloadData()
        }
        
        userDropDown.cancelAction = { [unowned self] in
            userArrow.transform = .init(rotationAngle: 0)
        }
    }
    
    @objc private func branchViewAction(){
        branchDropDown.show()
    }
    
    @objc private func groupViewAction(){
        groupDropDown.show()
    }
    
    @objc private func userViewAction(){
        userDropDown.show()
    }
    
    
    
    @IBAction func submitAction(_ sender: Any) {
        let selecteBranch = branchsData[selectedBranchIndex]
        let selecteGroup = groupsData[selectedGroupIndex]
        var selectedUsers = ""
        for item in selectedUsersData{
            if !selectedUsers.isEmpty{
                selectedUsers = "\(selectedUsers),\(item.value!)"
            }else{
                selectedUsers = "\(item.value!)"
            }
        }
        
        addRequest(branch_id: selecteBranch.value ?? "", group_id: selecteGroup.value ?? "", users_id: selectedUsers)
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
// MARK: - API Handling

extension AddPermissionMentionsVC{
    
    
    private func addRequest(branch_id:String,group_id:String,users_id:String){
        APIController.shard.addPermissionMentionsData(branch_id: branch_id, group_id: group_id, users_id: users_id) { data in
            if let status = data.status{
                if status{
                    let alertVC = UIAlertController(title: "Success".localized(), message: data.msg ?? "" , preferredStyle: .alert)
                    alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel,handler: { action in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alertVC, animated: true)
                }else{
                    let alertVC = UIAlertController(title: "error".localized().localized(), message: data.error ?? "" , preferredStyle: .alert)
                    alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel))
                    self.present(alertVC, animated: true)
                }
            }
        }
    }
    
    private func getBranchsMenu(){
        APIController.shard.getSearchBranchMenu { data in
            if let status = data.status , status{
                var arr = [String]()
                arr.append(contentsOf: data.records?.map{$0.label ?? "nil"} ?? [])
                self.branchDropDown.dataSource = arr
                self.branchsData = data.records ?? []
            }
        }
    }
    
    private func getGroupMenu(){
        APIController.shard.getGroupsMenu { data in
            if let status = data.status , status{
                var arr = [String]()
                arr.append(contentsOf: data.records?.map{$0.label ?? "nil"} ?? [])
                self.groupDropDown.dataSource = arr
                self.groupsData = data.records ?? []
            }
        }
        
    }
    
    private func getUsersMenu(){
        APIController.shard.getUsersMenu { data in
            if let status = data.status , status{
                var arr = [String]()
                arr.append(contentsOf: data.records?.map{$0.label ?? "nil"} ?? [])
                self.userDropDown.dataSource = arr
                self.usersData = data.records ?? []
            }
        }
        
    }
    
}

extension AddPermissionMentionsVC:UICollectionViewDelegate,UICollectionViewDataSource{
    private func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(.init(nibName: "UsersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UsersCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedUsersData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsersCollectionViewCell", for: indexPath) as! UsersCollectionViewCell
        cell.delegate = self
        cell.setData(data: selectedUsersData[indexPath.row],indexPath:indexPath)
        return cell
    }
    
    
    
}

extension AddPermissionMentionsVC:UsersCollectionViewCellDelegate{
  
    func removeAction(indexPath: IndexPath) {
        selectedUsersData.remove(at: indexPath.row)
        collectionView.reloadData()
        if selectedUsersData.isEmpty{
            userLabel.isHidden = false
        }
    }
    
    
}
