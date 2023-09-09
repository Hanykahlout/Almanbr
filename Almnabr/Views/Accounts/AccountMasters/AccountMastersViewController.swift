//
//  Account MastersViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 12/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
import FAPanels

class AccountMastersViewController: UIViewController {
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var bracnhSelectorStackView: UIStackView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyDataImageView: UIImageView!

    @IBOutlet weak var mainStackView: UIStackView!
    
    
    private var refreshControl = UIRefreshControl()
    private var branchSelector:BranchSelection!
    var data = [AccountMastersRecord]()
    private var temp = [AccountMastersRecord]()
    private var branch_id = ""
    private var selectedFinancialId = ""
    private var observer:NSObjectProtocol?
    var isChild = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerView.isHidden = isChild
        branchSelector.isHidden = isChild
        searchTextField.isHidden = isChild
        navigationController?.setNavigationBarHidden(!isChild, animated: true)
        if !isChild{
            getAccountMasters(branch_id: branch_id, finance_id: selectedFinancialId)
            branchSelector.selecetdfinancialYear = selectedFinancialId == "" ? nil : selectedFinancialId
            branchSelector.selecetdBranchId = branch_id == "" ? nil : branch_id
        }
    }
    
    
    private func initialization(){
        
        navigationController?.navigationBar.tintColor = maincolor
        setUpTableView()
        handleHeaderView()
        addBrachSelector()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        searchTextField.addTarget(self, action: #selector(searchAction), for: .editingChanged)
        observer = NotificationCenter.default.addObserver(forName: .init("ReloadAccountManagerData"), object: nil, queue: .main) { [weak self] notify in
            self?.getAccountMasters(branch_id: self?.branch_id ?? "", finance_id: self?.selectedFinancialId ?? "")
        }
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(observer!)
    }
    
    
    private func handleHeaderView(){
        headerView.btnAction = {
            let language =  L102Language.currentAppleLanguage()
            if language == "ar"{
                self.panel?.openRight(animated: true)
            }else{
                self.panel?.openLeft(animated: true)
            }
        }
    }
    
    private func addBrachSelector(){
        branchSelector = BranchSelection()
        branchSelector.withFinancialYearSelection = true
        branchSelector.branchSelectionAction = { selectedBranch in
            self.branch_id = selectedBranch
        }
        
        branchSelector.financialYearSelectionAction = { [weak self] selectedYear in
            self?.selectedFinancialId = selectedYear
            self?.getAccountMasters(branch_id: self?.branch_id ?? "", finance_id: selectedYear)
            self?.mainStackView.isHidden = false
        }
        
        bracnhSelectorStackView.addArrangedSubview(branchSelector)
    }
    
    
    @objc private func searchAction(){
        if searchTextField.text! == ""{
            data = temp
        }else{
            if data.isEmpty{
                data = temp
            }
            data = data.filter{($0.name ?? "").hasPrefix(searchTextField.text!)}
            
        }
        tableView.reloadData()
    }
    
    
    @objc private func refresh(){
        getAccountMasters(branch_id: branch_id, finance_id: selectedFinancialId)
    }
    
    
}
// MARK: - Table View Delegate and DataSource
extension AccountMastersViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        if !isChild{
            tableView.refreshControl = refreshControl
        }
        tableView.register(.init(nibName: "AccountMastersTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountMastersTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountMastersTableViewCell", for: indexPath) as! AccountMastersTableViewCell
        let object = data[indexPath.row]
        cell.setData(data: object)
        
        cell.addButtonAction = { [weak self] in
            let vc = AddAccountMastersViewController()
            vc.data = object
            vc.index = indexPath.row
            vc.dismissAction = { [weak self] in
                self?.backToParent()
            }
            vc.isEdit = false
            let nav = UINavigationController(rootViewController: vc)
            nav.setNavigationBarHidden(true, animated: true)
            nav.modalPresentationStyle = .overCurrentContext
            self?.navigationController?.present(nav, animated: true)
        }
        
        
        cell.editButtonAction = { [weak self] in
            let vc = AddAccountMastersViewController()
            vc.data = object
            vc.index = indexPath.row
            vc.dismissAction = { [weak self] in
                self?.backToParent()
            }
            vc.isEdit = true
            let nav = UINavigationController(rootViewController: vc)
            nav.setNavigationBarHidden(true, animated: true)
            nav.modalPresentationStyle = .overCurrentContext
            self?.navigationController?.present(nav, animated: true)
        }
        
        cell.deleteButtonAction = { [weak self] in
            self?.deleteAccoutMaster(indexPath: indexPath, accountMasterId: object.account_masters_id ?? "")
        }
        
        cell.branchesButtonAction = { [weak self] in
            let vc = AccountMastersViewController()
            vc.data = object.children ?? []
            vc.branch_id = self?.branch_id ?? ""
            vc.selectedFinancialId = self?.selectedFinancialId ?? ""
            vc.isChild = true
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
    private func backToParent(){
        let vc = AccountMastersViewController()
        vc.branch_id = self.branch_id
        vc.selectedFinancialId = self.selectedFinancialId
        vc.isChild = false
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        panel?.center(nav)
    }
    
}


// MARK: - API Handling
extension AccountMastersViewController{
    private func getAccountMasters(branch_id:String,finance_id:String){
        showLoadingActivity()
        APIController.shard.getAccountMasters(branch_id: branch_id, finance_id: finance_id) { [weak self] data in
            DispatchQueue.main.async {
                self?.hideLoadingActivity()
                if let status = data.status,status{
                    self?.data = data.records ?? []
                    self?.temp = data.records ?? []
                }else{
                    self?.data.removeAll()
                }
                self?.emptyDataImageView.isHidden = !(self?.data.isEmpty ?? true)
                self?.tableView.reloadData()
                
                if self?.refreshControl.isRefreshing ?? false{
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    
    private func deleteAccoutMaster(indexPath:IndexPath,accountMasterId:String){
        showLoadingActivity()
        APIController.shard.deleteAccountMaster(branch_id: branch_id, accountMasterId: accountMasterId) { data in
            DispatchQueue.main.async { [weak self] in
                self?.hideLoadingActivity()
                if data.status ?? false{
                    SCLAlertView().showSuccess("Success".localized(), subTitle: data.msg ?? "")
                    self?.data.remove(at: indexPath.row)
                    self?.tableView.deleteRows(at: [indexPath], with: .automatic)
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
            }
        }
    }
    
}

