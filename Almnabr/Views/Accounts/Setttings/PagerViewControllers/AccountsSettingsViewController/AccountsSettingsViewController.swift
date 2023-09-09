//
//  AccountsSettingsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 03/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
class AccountsSettingsViewController: UIViewController {

    @IBOutlet weak var filterTextField: UITextField!
    @IBOutlet weak var filterArrow: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyDataImageView: UIImageView!
    
    private var data = [AccountSettingsRecord]()
    private var searchTypes = [SearchBranchRecords]()
    private var pageNumber = 1
    private var totalPages = 1
    private var searchType = ""
    private var searchTypeDropDown = DropDown()
    
    private var observer:NSObjectProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        // Do any additional setup after loading the view.
    }

    private func initialization(){
        setUpTableView()
        setUpDropDown()
        searchTextField.addTarget(self, action: #selector(searchAction), for: .editingChanged)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getSearchTypes()
        getAccountSettings(isFromBottom: false)
        observer = NotificationCenter.default.addObserver(forName: .init("ReloadAccountsSettings"), object: nil, queue: .main) { notify in
            self.getAccountSettings(isFromBottom: false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(observer!)
    }
    
    private func setUpDropDown(){
        //  searchTypeDropDown
        
        searchTypeDropDown.anchorView = filterTextField
        searchTypeDropDown.bottomOffset = CGPoint(x: 0, y:(searchTypeDropDown.anchorView?.plainView.bounds.height)!)
        
        searchTypeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            filterArrow.transform = .init(rotationAngle: 0)
            if index != 0{
                let objc = searchTypes[index - 1]
                searchType = objc.value ?? ""
                self.filterTextField.placeholder = objc.label ?? ""
            }else{
                searchType = ""
                self.filterTextField.placeholder = item
            }
            self.getAccountSettings(isFromBottom: false)
        }
        
        searchTypeDropDown.cancelAction = { [unowned self] in
            filterArrow.transform = .init(rotationAngle: .pi)
        }
        
        filterTextField.addTapGesture {
            self.filterArrow.transform = .init(rotationAngle: .pi)
            self.searchTypeDropDown.show()
        }
    }
    
    @objc private func searchAction(){
        getAccountSettings(isFromBottom: false)
    }

}

extension AccountsSettingsViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "AccountsSettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountsSettingsTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountsSettingsTableViewCell",for: indexPath) as! AccountsSettingsTableViewCell
        cell.setData(data: data[indexPath.row],searchTypes:searchTypes)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1{
            if pageNumber < totalPages{
                pageNumber += 1
                getAccountSettings(isFromBottom: true)
            }
        }
    }
}


// MARK: - API Handling
extension AccountsSettingsViewController{
    private func getSearchTypes(){
        APIController.shard.getAccountSearchType { data in
            if let status = data.status,status{
                let records = data.records ?? []
                self.searchTypes = records
                self.searchTypeDropDown.dataSource = ["All"]
                self.searchTypeDropDown.dataSource.append(contentsOf: records.map{$0.label ?? ""})
                self.tableView.reloadData()
            }
        }
    }
    
    private func getAccountSettings(isFromBottom:Bool){
        if !isFromBottom {
            pageNumber = 1
        }
        showLoadingActivity()
        
        APIController.shard.getAccountSettings(pageNumber: String(pageNumber), branch_id: AccountSettingsViewController.branch_id, search_key: searchTextField.text!, search_type: searchType) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    if isFromBottom{
                        self.data.append(contentsOf: data.records ?? [])
                    }else{
                        self.data = data.records ?? []
                    }
                    self.emptyDataImageView.isHidden = true
                }else{
                    self.data.removeAll()
                    self.emptyDataImageView.isHidden = false
                }
                self.totalPages = data.page?.total_pages ?? 1
                self.tableView.reloadData()
            }
        }
    }
    
    
}


    
