//
//  ViewReceiptViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 05/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
import FAPanels
class ViewReceiptViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var receiptNoLabel: UILabel!
    @IBOutlet weak var receiptNoTitleLabel: UILabel!
    @IBOutlet weak var requestNumberLabel: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var receiptDateLabel: UILabel!
    @IBOutlet weak var receiptDateTitleLabel: UILabel!
    @IBOutlet weak var receiptFromLabel: UILabel!
    @IBOutlet weak var receiptFromTitleLabel: UILabel!
    @IBOutlet weak var receiptModeLabel: UILabel!
    @IBOutlet weak var receiptModeTitleLabel: UILabel!
    @IBOutlet weak var debitAccountLabel: UILabel!
    @IBOutlet weak var debitCostLabel: UILabel!
    @IBOutlet weak var creditAccountLabel: UILabel!
    @IBOutlet weak var creditCostLabel: UILabel!
    @IBOutlet weak var receiptAmountLabel: UILabel!
    @IBOutlet weak var receiptAmountTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var documentNoLabel: UILabel!
    @IBOutlet weak var documentDateLabel: UILabel!
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var onDateLabel: UILabel!
    @IBOutlet weak var onUpdatedLabel: UILabel!
    @IBOutlet weak var financialDateLabel: UILabel!
    
    var branch_id = ""
    var finance_id = ""
    var payment_receipt_id = ""
    private var transactionsData = [ReceiptTransaction]()
    var isPayment = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBarTitle(navigationTitle: isPayment ? "Payments" : "Receipts")
        navigationController?.setNavigationBarHidden(false, animated: true)
        getReceiptData()
        if isPayment {
            receiptNoTitleLabel.text = isPayment ? "Payment No" : "Receipt No"
            receiptDateTitleLabel.text = isPayment ? "Payment Date" : "Receipt Date"
            receiptFromTitleLabel.text = isPayment ? "Payment From" : "Receipt From"
            receiptModeTitleLabel.text = isPayment ? "Payment Mode" : "Receipt Mode"
            receiptAmountTitleLabel.text = isPayment ? "Payment Amount" : "Receipt Amount"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }

    @IBAction func historyAction(_ sender: Any) {
        let vc = AccountHistoryViewController()
        vc.id = payment_receipt_id
        vc.account_operation = isPayment ? "PAYMENT" : "RECEIPT"
        let nav = UINavigationController(rootViewController: vc)
        navigationController?.present(nav, animated: true)
    }
}


extension ViewReceiptViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "ViewReceiptTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewReceiptTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewReceiptTableViewCell", for: indexPath) as! ViewReceiptTableViewCell
        cell.setData(data: transactionsData[indexPath.row])
        cell.costCenterButtonAction = { [weak self] transactionId,receiptId,transactionHistoryId in
            let vc = ReceiptCostCentersViewController()
            vc.transactionId = transactionId
            vc.receiptId = receiptId
            vc.transactionHistoryId = transactionHistoryId
            let nav = UINavigationController(rootViewController: vc)
            self?.navigationController?.present(nav, animated: true)
        }
        
        cell.transactionButtonAction = { [weak self] in
            let vc = StatementAccountsViewController()
            vc.branch_id = self?.branch_id ?? ""
            vc.finance_id = self?.finance_id ?? ""
            vc.selectedAccountFrom = .init(label: self?.transactionsData[indexPath.row].account_name ?? "", value: self?.transactionsData[indexPath.row].account_masters_id ?? "")
            vc.selectedAccountTo = .init(label: self?.transactionsData[indexPath.row].account_name ?? "", value: self?.transactionsData[indexPath.row].account_masters_id ?? "")
            vc.isShowingDirectly = true
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true
            self?.panel?.center(nav)
        }
        
        return cell
    }
}


extension ViewReceiptViewController{
    private func getReceiptData(){
        let url = "/\(isPayment ? "viewpayment" : "viewreceipt")/\(branch_id)/\(payment_receipt_id)?finance_id=\(finance_id)"
        showLoadingActivity()
        APIController.shard.viewReceipt(url:url) { data in
            DispatchQueue.main.async { [weak self] in
                self?.hideLoadingActivity()
                if data.status ?? false{
                    self?.transactionsData = data.transactions ?? []
                    self?.receiptNoLabel.text = data.records?.payreceipt_system_code ?? "----"
                    self?.requestNumberLabel.text = data.records?.transaction_id ?? "----"
                    self?.branchLabel.text = data.records?.branch_name ?? "----"
                    self?.receiptDateLabel.text = data.records?.transaction_date ?? "----"
                    self?.receiptFromLabel.text = data.records?.payment_receipt_to_from ?? "----"
                    self?.receiptModeLabel.text = data.records?.payment_receipt_mode ?? "----"
                    self?.debitAccountLabel.text = data.records?.debit_account ?? "----"
                    self?.debitCostLabel.text = data.records?.debit_cost ?? "----"
                    self?.creditAccountLabel.text = data.records?.credit_account ?? "----"
                    self?.creditCostLabel.text = data.records?.credit_cost ?? "----"
                    self?.receiptAmountLabel.text = data.records?.payment_receipt_amount ?? "----"
                    self?.descriptionLabel.text = data.records?.payment_receipt_description ?? "----"
                    self?.notesLabel.text = data.records?.payment_receipt_notes ?? "----"
                    self?.documentNoLabel.text = data.records?.payment_receipt_document_number ?? "----"
                    self?.documentDateLabel.text = data.records?.payment_receipt_document_date ?? "----"
                    self?.bankNameLabel.text = data.records?.payment_receipt_bank_name ?? "----"
                    self?.writerLabel.text = data.records?.writer_name ?? "----"
                    self?.onDateLabel.text = data.records?.transaction_created_date ?? "----"
                    self?.onUpdatedLabel.text = data.records?.payment_receipt_updated_date ?? "----"
                    self?.financialDateLabel.text = data.financial_year?.label ?? "----"
                }else{
                    self?.transactionsData.removeAll()
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
                self?.tableView.reloadData()
            }
        }
    }
}
