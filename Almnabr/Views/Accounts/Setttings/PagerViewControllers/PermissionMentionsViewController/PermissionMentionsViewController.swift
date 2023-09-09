//
//  PermissionMentionsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 03/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
import DropDown
class PermissionMentionsViewController: UIViewController {
    
    @IBOutlet weak var usersTextField: UITextField!
    @IBOutlet weak var groupsTextField: UITextField!
    @IBOutlet weak var groupsArrow: UIImageView!
    @IBOutlet weak var usersArrow: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyImageView: UIImageView!
    
    private var data = [Records]()
    private let groupsDropDown = DropDown()
    private let usersDropDown = DropDown()
    private var groups = [SearchBranchRecords]()
    private var users = [SearchBranchRecords]()
    private var usersSearchResult = [SearchBranchRecords]()
    private var observer:NSObjectProtocol!
    private var pageNumber = 1
    private var totalPages = 1
    private var group_id = ""
    private var user_id = ""
    private var isFromSearching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        // Do any additional setup after loading the view.
    }
    
    
    private func initialization(){
        setUpDropDown()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getGroups()
        getUsers()
        getPermissionMentionsRecords(isFromBottom: false)
        observer = NotificationCenter.default.addObserver(forName: .init("ReloadPermissionMentions"), object: nil, queue: .main) { notify in
            self.getUsers()
            self.getPermissionMentionsRecords(isFromBottom: false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(observer!)
    }
    
    private func setUpDropDown(){
        //  groupsDropDown
        
        groupsDropDown.anchorView = groupsTextField
        groupsDropDown.bottomOffset = CGPoint(x: 0, y:(groupsDropDown.anchorView?.plainView.bounds.height)!)
        
        groupsDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            groupsArrow.transform = .init(rotationAngle: 0)
            if index != 0{
                let objc = groups[index - 1]
                group_id = objc.value ?? ""
                self.groupsTextField.placeholder = objc.label ?? ""
            }else{
                group_id = ""
                self.groupsTextField.placeholder = item
            }
            self.getPermissionMentionsRecords(isFromBottom: false)
        }
        
        groupsDropDown.cancelAction = { [unowned self] in
            groupsArrow.transform = .init(rotationAngle: .pi)
        }
        
        groupsTextField.addTapGesture {
            self.groupsArrow.transform = .init(rotationAngle: .pi)
            self.groupsDropDown.show()
        }
        
        //  usersDropDown
        
        usersDropDown.anchorView = usersTextField
        usersDropDown.bottomOffset = CGPoint(x: 0, y:(usersDropDown.anchorView?.plainView.bounds.height)!)
        
        usersDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            usersArrow.transform = .init(rotationAngle: 0)
            if index != 0 {
                let objc =  isFromSearching ? usersSearchResult[index - 1] : users[index - 1]
                user_id = objc.value ?? ""
                self.usersTextField.text = ""
                self.usersTextField.placeholder = objc.label ?? ""
            }else{
                user_id = ""
                self.usersTextField.text = ""
                self.usersTextField.placeholder = item
            }
            self.getPermissionMentionsRecords(isFromBottom: false)
        }
        
        usersDropDown.cancelAction = { [unowned self] in
            usersArrow.transform = .init(rotationAngle: .pi)
        }
        usersTextField.delegate = self
        usersTextField.addTarget(self, action: #selector(searchForUsers), for: .editingChanged)
    }
    
    
    
    @objc private func searchForUsers(){
        usersSearchResult = users.filter({($0.label ?? "").hasPrefix(usersTextField.text!)})
        usersDropDown.dataSource = ["Users"]
        usersDropDown.dataSource.append(contentsOf: usersSearchResult.map{$0.label ?? ""})
        isFromSearching = true
        usersDropDown.show()
    }
    
}

extension PermissionMentionsViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "PermissionMentionsTableViewCell", bundle: nil), forCellReuseIdentifier: "PermissionMentionsTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PermissionMentionsTableViewCell", for: indexPath) as! PermissionMentionsTableViewCell
        cell.setData(data: data[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1{
            if pageNumber < totalPages{
                pageNumber += 1
                getPermissionMentionsRecords(isFromBottom: true)
            }
        }
    }
}
extension PermissionMentionsViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        usersDropDown.show()
    }
}
// MARK: - API Controller
extension PermissionMentionsViewController{
    private func getGroups(){
        showLoadingActivity()
        APIController.shard.getAccountGroups { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    let groups = data.records ?? []
                    self.groups = groups
                    self.groupsDropDown.dataSource = ["Groups"]
                    self.groupsDropDown.dataSource.append(contentsOf: groups.map{$0.label ?? ""})
                }
            }
        }
    }
    
    private func getUsers(){
        showLoadingActivity()
        APIController.shard.getAccountUsers(branch_id: AccountSettingsViewController.branch_id) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    let users = data.records ?? []
                    self.isFromSearching = false
                    self.users = users
                    self.usersDropDown.dataSource = ["Users"]
                    self.usersDropDown.dataSource.append(contentsOf: users.map{$0.label ?? ""})
                }
            }
        }
    }
    
    private func getPermissionMentionsRecords(isFromBottom:Bool){
        if !isFromBottom{
            pageNumber = 1
        }
        let bracnh_id = AccountSettingsViewController.branch_id
        showLoadingActivity()
        APIController.shard.getPermissionMentions(pageNumber: String(pageNumber), branch_id: bracnh_id , group_key: group_id, user_id: user_id) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    self.emptyImageView.isHidden = true
                    if isFromBottom{
                        self.data.append(contentsOf: data.records ?? [])
                    }else{
                        self.data = data.records ?? []
                    }
                }else{
                    self.emptyImageView.isHidden = false
                    self.data.removeAll()
                }
                self.tableView.reloadData()
            }
        }
    }
    
    
}
