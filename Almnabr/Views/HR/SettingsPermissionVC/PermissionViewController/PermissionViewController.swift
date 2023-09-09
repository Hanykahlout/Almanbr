//
//  SettingsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 01/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import FAPanels
import DropDown

class PermissionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var sortStackView: UIStackView!
    
    @IBOutlet weak var seachView: UIView!
    @IBOutlet weak var groupsView: UIView!
    @IBOutlet weak var usersView: UIView!
    
    @IBOutlet weak var selectedBranchLabel: UILabel!
    @IBOutlet weak var selectedGroupLabel: UILabel!
    @IBOutlet weak var selectedUserLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var searchArrow: UIImageView!
    @IBOutlet weak var groupsArrow: UIImageView!
    @IBOutlet weak var usersArrow: UIImageView!
    
    @IBOutlet weak var permissionMentionsStackView: UIStackView!
    
    private var refrechControl = UIRefreshControl()
    private var dropDownSearch = DropDown()
    private var dropDownGroups = DropDown()
    private var dropDownUsers = DropDown()
    
    private var data = [Records]()
    private var searchBranchsData = [SearchBranchRecords]()
    private var GroupsData = [SearchBranchRecords]()
    private var userData = [SearchBranchRecords]()
    
    private var searchBranchId = ""
    private var groupId = ""
    private var userId = ""
    private var pageNumber = 1
    private var totalPages:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    
    
    private func initlization(){
        
        
        setUpTableView()
        confgDropDowns()
        setUpViewsActions()
        
        getPermissionMentionsData(isNewPage: false)
        getSearchMenu()
        getGroupMenu()
        getUsersMenu()
        
    }
    
    
    private func setUpViewsActions(){
        
        refrechControl.addTarget(self, action: #selector(refrech), for: .valueChanged)
        
        seachView.isUserInteractionEnabled = true
        seachView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchAction)))
        
        groupsView.isUserInteractionEnabled = true
        groupsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(groupsAction)))
        
        
        usersView.isUserInteractionEnabled = true
        usersView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(usersAction)))
        
        
    }
    
    
    
    private func confgDropDowns(){
        
        // Search Drop Down List
        dropDownSearch.anchorView = seachView
        
        dropDownSearch.bottomOffset = CGPoint(x: 0, y:(dropDownSearch.anchorView?.plainView.bounds.height)!)
        dropDownSearch.width = sortStackView.bounds.width
        dropDownSearch.selectionAction = { [unowned self] (index: Int, item: String) in
            searchArrow.transform = .init(rotationAngle: 0)
            
            if index != 0{
                let selectedItem = searchBranchsData[index-1]
                selectedBranchLabel.text = selectedItem.label ?? ""
                self.searchBranchId = selectedItem.value ?? ""
            }else{
                self.searchBranchId = ""
                selectedBranchLabel.text = "Search By Branches".localized()
            }
            
            self.getPermissionMentionsData(isNewPage: false)
        }
        dropDownSearch.cancelAction = { [unowned self] in
            searchArrow.transform = .init(rotationAngle: 0)
        }
        
        // Group Drop Down List
        dropDownGroups.anchorView = groupsView
        dropDownGroups.bottomOffset = CGPoint(x: 0, y:(dropDownGroups.anchorView?.plainView.bounds.height)!)
        dropDownGroups.width = sortStackView.bounds.width
        dropDownGroups.selectionAction = { [unowned self] (index: Int, item: String) in
            groupsArrow.transform = .init(rotationAngle: 0)
            
            
            if index != 0{
                let selectedItem = GroupsData[index-1]
                selectedGroupLabel.text = selectedItem.label ?? ""
                self.groupId = selectedItem.value ?? ""
            }else{
                self.groupId = ""
                selectedGroupLabel.text = "Groups".localized()
            }
            self.getPermissionMentionsData(isNewPage: false)
            
        }
        
        
        dropDownGroups.cancelAction = { [unowned self] in
            groupsArrow.transform = .init(rotationAngle: 0)
        }
        
        
        // Users Drop Down List
        dropDownUsers.anchorView = usersView
        dropDownUsers.bottomOffset = CGPoint(x: 0, y:(dropDownUsers.anchorView?.plainView.bounds.height)!)
        dropDownUsers.width = sortStackView.bounds.width
        dropDownUsers.selectionAction = { [unowned self] (index: Int, item: String) in
            
            usersArrow.transform = .init(rotationAngle: 0)
            if index != 0{
                let selectedItem = userData[index-1]
                selectedUserLabel.text = selectedItem.label ?? ""
                self.userId = selectedItem.value ?? ""
            }else{
                self.userId = ""
                selectedUserLabel.text = "Users".localized()
            }
            
            self.getPermissionMentionsData(isNewPage: false)
        }
        
        dropDownUsers.cancelAction = { [unowned self] in
            usersArrow.transform = .init(rotationAngle: 0)
        }
    }
    
    
    @objc private func refrech(){
        getPermissionMentionsData(isNewPage: false)
    }
    
    
    @objc private func searchAction(){
        searchArrow.transform = .init(rotationAngle: .pi)
        dropDownSearch.show()
    }
    
    @objc private func groupsAction(){
        groupsArrow.transform = .init(rotationAngle: .pi)
        dropDownGroups.show()
    }
    
    @objc private func usersAction(){
        usersArrow.transform = .init(rotationAngle: .pi)
        dropDownUsers.show()
    }
    
}


extension PermissionViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
        tableView.refreshControl = refrechControl
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        cell.delegate = self
        cell.setDate(data: data[indexPath.row],indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1{
            if let totalPages = totalPages{
                if totalPages > pageNumber{
                    pageNumber = pageNumber + 1
                    getPermissionMentionsData(isNewPage:true)
                }
            }
        }
    }
    
    
}


// MARK: - GET Data From API

extension PermissionViewController{
    private func getPermissionMentionsData(isNewPage:Bool){
        showLoadingActivity()
        if !isNewPage{
            pageNumber = 1
        }
        APIController.shard.getPermissionMentionsData(pageNumber:String(pageNumber),searchBranchId: searchBranchId, groupId: groupId, userId: userId) { data in
            self.hideLoadingActivity()
            DispatchQueue.main.async {
                if self.refrechControl.isRefreshing{
                    self.refrechControl.endRefreshing()
                }
                if let status = data.status , status{
                    self.totalPages = data.page?.total_pages
                    self.messageLabel.isHidden = true
                    if isNewPage{
                        self.data.append(contentsOf: data.records ?? [])
                    }else{
                        self.data = data.records ?? []
                    }
                    self.tableView.reloadData()
                    
                }else{
                    self.data.removeAll()
                    self.tableView.reloadData()
                    self.messageLabel.isHidden = false
                    self.messageLabel.text = data.error ?? ""
                }
            }
        }
    }
    
    private func getSearchMenu(){
        APIController.shard.getSearchBranchMenu { data in
            if let status = data.status , status{
                var arr = [String]()
                arr.append("All".localized())
                arr.append(contentsOf: data.records?.map{$0.label ?? "nil"} ?? [])
                self.dropDownSearch.dataSource = arr
                self.searchBranchsData = data.records ?? []
            }
        }
    }
    
    private func getGroupMenu(){
        APIController.shard.getGroupsMenu { data in
            if let status = data.status , status{
                var arr = [String]()
                arr.append("All".localized())
                arr.append(contentsOf: data.records?.map{$0.label ?? "nil"} ?? [])
                self.dropDownGroups.dataSource = arr
                self.GroupsData = data.records ?? []
            }
        }
        
    }
    
    private func getUsersMenu(){
        APIController.shard.getUsersMenu { data in
            if let status = data.status , status{
                var arr = [String]()
                arr.append("All".localized())
                arr.append(contentsOf: data.records?.map{$0.label ?? "nil"} ?? [])
                self.dropDownUsers.dataSource = arr
                self.userData = data.records ?? []
            }
        }
    }
    
}


extension PermissionViewController:SettingsTableViewCellDelegate{
    func deleteAction(indexPath: IndexPath) {
        showLoadingActivity()
        APIController.shard.deletePermissionMentionsData(id: data[indexPath.row].mention_id ?? "") { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status{
                    if status{
                        let alertVC = UIAlertController(title: "Success".localized(), message: data.msg ?? "", preferredStyle: .alert)
                        alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel,handler: { action in
                            self.data.remove(at: indexPath.row)
                            self.tableView.reloadData()
                        }))
                        self.present(alertVC, animated: true)
                    }else{
                        let alertVC = UIAlertController(title: "error".localized(), message: data.error ?? "", preferredStyle: .alert)
                        alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel))
                        self.present(alertVC, animated: true)
                    }
                }
            }
        }
        
        
    }
    
}
