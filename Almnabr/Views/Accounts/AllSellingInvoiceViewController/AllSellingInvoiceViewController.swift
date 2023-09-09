//
//  AllSellingInvoiceViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 22/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView

class AllSellingInvoiceViewController: UIViewController {
    
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var branchSelectorStackView: UIStackView!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var emptyDataImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var isPurchase = false
    
    
    private var branchSelector:BranchSelection?
    private var branch_id = ""
    private var finance_id = ""
    private var pageNumber = 1
    private var totalPages = 1
    private var data = [SellingInvoiceRecord]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleHeaderView()
        setUpBranchSelector()
        setUpTableView()
        searchTextField.addTarget(self, action: #selector(searchAction), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerTitleLabel.text = isPurchase ? "Purchase Invoices" : "Selling Invoices"
    }
    private func setUpBranchSelector(){
        branchSelector = BranchSelection()
        branchSelector!.withFinancialYearSelection = true
        branchSelector!.branchSelectionAction = { [weak self] branch_id in
            self?.branch_id = branch_id
            self?.mainStackView.isHidden = branch_id == ""
            self?.getSellingInvoices(isFromBottom: false)
        }
        branchSelector?.financialYearSelectionAction = { [weak self] finance_id in
            self?.finance_id = finance_id
            self?.getSellingInvoices(isFromBottom: false)
        }
        branchSelectorStackView.addArrangedSubview(branchSelector!)
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
    
    @objc private func searchAction(){
        getSellingInvoices(isFromBottom: false)
    }
}

extension AllSellingInvoiceViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "SellingInvoiceTableViewCell", bundle: nil), forCellReuseIdentifier: "SellingInvoiceTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SellingInvoiceTableViewCell", for: indexPath) as! SellingInvoiceTableViewCell
        cell.delegate = self
        cell.setData(data:data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1 {
            if pageNumber < totalPages{
                pageNumber += 1
                getSellingInvoices(isFromBottom: true)
            }
        }
    }
}

extension AllSellingInvoiceViewController:SellingInvoiceCellDelegate{
    func viewReceipt(invoice_id: String) {
        let vc = ViewSellingInvoiceViewController()
        vc.invoice_id = invoice_id
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func exportPDFReceipt(invoice_id: String) {
        export(url: "/accounts/exportdata/PDF/\(isPurchase ? "PINV" : "SINV")/\(invoice_id)/\(branch_id)")
    }
    
    func exportExcelReceipt(invoice_id: String) {
        export(url: "/accounts/exportdata/EXL/\(isPurchase ? "PINV" : "SINV")/\(invoice_id)/\(branch_id)")
    }
    
    func exportPDFToEmailReceipt(invoice_id: String) {
        export(url: "/accounts/exportdata/EPDF/\(isPurchase ? "PINV" : "SINV")/\(invoice_id)/\(branch_id)")
    }
    
    func exportExcelToEmailReceipt(invoice_id: String) {
        export(url: "/accounts/exportdata/EEXL/\(isPurchase ? "PINV" : "SINV")/\(invoice_id)/\(branch_id)")
    }
    
    
}

extension AllSellingInvoiceViewController{
    private func getSellingInvoices(isFromBottom:Bool){
        if !isFromBottom{
            pageNumber = 1
        }
        showLoadingActivity()
        APIController.shard.getSellingInvoices(isPurchase:isPurchase,pageNumber: String(pageNumber), search_key: searchTextField.text!, finance_id: finance_id, branch_id: branch_id) { data in
            DispatchQueue.main.async { [weak self] in
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
    
    private func export(url:String){
        showLoadingActivity()
        APIController.shard.exportFile(url:url) { data in
            DispatchQueue.main.async { [weak self] in
                self?.hideLoadingActivity()
                if data.status ?? false{
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
