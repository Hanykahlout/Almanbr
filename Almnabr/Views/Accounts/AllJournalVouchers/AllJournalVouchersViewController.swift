//
//  AllJournalVouchersViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 19/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
class AllJournalVouchersViewController: UIViewController {
 
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var branchSelectorStackView: UIStackView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emptyDataImageView: UIImageView!
    
    private var pageNumber = 1
    private var totalPages = 1
    private var data = [AllJournalVoucherRecord]()
    private var branchSelector:BranchSelection?
    private var branch_id = ""
    private var finance_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleHeaderView()
        setUpBranchSelector()
        setUpTableView()
        searchTextField.addTarget(self, action: #selector(searchAction), for: .editingChanged)
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
    
    private func setUpBranchSelector(){
        branchSelector = BranchSelection()
        branchSelector!.withFinancialYearSelection = true
        branchSelector!.branchSelectionAction = { [weak self] branch_id in
            self?.branch_id = branch_id
            self?.mainStackView.isHidden = branch_id == ""
            self?.getAllJournalVoucher(isFromBottom: false)
        }
        branchSelector?.financialYearSelectionAction = { [weak self] finance_id in
            self?.finance_id = finance_id
            self?.getAllJournalVoucher(isFromBottom: false)
        }
        branchSelectorStackView.addArrangedSubview(branchSelector!)
    }
    
    
    @objc private func searchAction(){
        getAllJournalVoucher(isFromBottom: false)
    }
}

extension AllJournalVouchersViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "AllJournalVouchersTableViewCell", bundle: nil), forCellReuseIdentifier: "AllJournalVouchersTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllJournalVouchersTableViewCell", for: indexPath) as! AllJournalVouchersTableViewCell
        cell.delegate = self
        cell.setData(data:data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1 {
            if pageNumber < totalPages{
                pageNumber += 1
                getAllJournalVoucher(isFromBottom: true)
            }
        }
    }
}

extension AllJournalVouchersViewController:AllJournalVouchersCellDelegate{
    func viewReceipt(journal_voucher_id: String) {
        let vc = ViewJournalVouchersViewController()
        vc.journalVoucherId = journal_voucher_id
        vc.branchId = branch_id
        vc.finance_id = finance_id
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func editReceipt(journal_voucher_id: String) {
        let vc = CreateJournalVoucherVC()
        vc.isEdit = true
        vc.branch_id = branch_id
        vc.journal_voucher_id = journal_voucher_id
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        panel?.center(nav)
    }
    
    func deleteReceipt(journal_voucher_id: String) {
        
    }
    
    func exportPDFReceipt(journal_voucher_id: String) {
        exportFile(url: "/accounts/exportdata/PDF/JRN/\(journal_voucher_id)/\(branch_id)")
    }
    
    func exportExcelReceipt(journal_voucher_id: String) {
        exportFile(url: "/accounts/exportdata/EXL/JRN/\(journal_voucher_id)/\(branch_id)")
    }
    
    func exportPDFToEmailReceipt(journal_voucher_id: String) {
        exportFile(url: "/accounts/exportdata/EPDF/JRN/\(journal_voucher_id)/\(branch_id)")
    }
    
    func exportExcelToEmailReceipt(journal_voucher_id: String) {
        exportFile(url: "/accounts/exportdata/EEXL/JRN/\(journal_voucher_id)/\(branch_id)")
    }
    
    
}


// MARK: - APIController
extension AllJournalVouchersViewController{
    private func getAllJournalVoucher(isFromBottom:Bool){
        if !isFromBottom{
            pageNumber = 1
        }
        showLoadingActivity()
        APIController.shard.getAllJournalVoucher(branchId: branch_id, finance_id: finance_id, searchKey: searchTextField.text!, pageNumber: String(pageNumber)) { data in
            DispatchQueue.main.async { [ weak self ] in
                self?.hideLoadingActivity()
                if data.status ?? false{
                    if isFromBottom{
                        self?.data.append(contentsOf: data.records ?? [])
                    }else{
                        self?.data = data.records ?? []
                    }
                }else{
                    if !isFromBottom{
                        self?.data.removeAll()
                    }
                }
                self?.totalPages = data.paging?.total_pages ?? 1
                self?.tableView.reloadData()
                self?.emptyDataImageView.isHidden = !(self?.data.isEmpty ?? true)
            }
        }
    }
    
    private func exportFile(url:String){
        showLoadingActivity()
        APIController.shard.exportFile(url: url) { data in
            DispatchQueue.main.async { [weak self] in
                self?.hideLoadingActivity()
                if data.status ?? false {
                    let vc = WebViewViewController()
                    vc.data = data
                    let nav = UINavigationController(rootViewController: vc)
                    self?.navigationController?.present(nav, animated: true)
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
            }
        }
    }
}
