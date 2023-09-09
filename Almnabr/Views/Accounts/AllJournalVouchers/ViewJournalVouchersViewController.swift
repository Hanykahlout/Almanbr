//
//  ViewJournalVouchersViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 19/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
class ViewJournalVouchersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var journalNumberLabel: UILabel!
    @IBOutlet weak var requestNumberLabel: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var journalDateLabel: UILabel!
    @IBOutlet weak var creditTotalLabel: UILabel!
    @IBOutlet weak var debitTotalLabel: UILabel!
    @IBOutlet weak var totalRecordsLable: UILabel!
    @IBOutlet weak var financialDateLabel: UILabel!
    @IBOutlet weak var writerLable: UILabel!
    @IBOutlet weak var onDateLabel: UILabel!
    @IBOutlet weak var onUpdatedLabel: UILabel!
    
    private var transactionData = [ReceiptTransaction]()
    var journalVoucherId = ""
    var branchId = ""
    var finance_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        addNavigationBarTitle(navigationTitle: "View Journal Voucher")
        getData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @IBAction func exportPDFAction(_ sender: Any) {
        exportPDF()
    }
    
    @IBAction func historyAction(_ sender: Any) {
        let vc = AccountHistoryViewController()
        vc.id = journalVoucherId
        vc.account_operation = "JOURNAL_VOUCHERS"
        let nav = UINavigationController(rootViewController: vc)
        navigationController?.present(nav, animated: true)
    }
}

// MARK: - TableView Delegate And DataSource
extension ViewJournalVouchersViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "ViewJournalVouchersTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewJournalVouchersTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewJournalVouchersTableViewCell", for: indexPath) as! ViewJournalVouchersTableViewCell
        cell.setData(data:transactionData[indexPath.row])
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
            vc.branch_id = self?.branchId ?? ""
            vc.finance_id = self?.finance_id ?? ""
            vc.selectedAccountFrom = .init(label: self?.transactionData[indexPath.row].account_name ?? "", value: self?.transactionData[indexPath.row].account_masters_id ?? "")
            vc.selectedAccountTo = .init(label: self?.transactionData[indexPath.row].account_name ?? "", value: self?.transactionData[indexPath.row].account_masters_id ?? "")
            vc.isShowingDirectly = true
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true
            self?.panel?.center(nav)
        }
        
        return cell
    }
}

// MARK: - API Handling
extension ViewJournalVouchersViewController{
    private func getData(){
        showLoadingActivity()
        APIController.shard.viewJournalVoucherData(journalVoucherId: journalVoucherId, branchId: branchId, finance_id: finance_id) { data in
            DispatchQueue.main.async { [weak self] in
                self?.hideLoadingActivity()
                if data.status ?? false{
                    self?.journalNumberLabel.text = data.records?.journal_system_code ?? "----"
                    self?.requestNumberLabel.text = data.records?.transaction_id ?? "----"
                    self?.branchLabel.text = data.records?.branch_name ?? "----"
                    self?.journalDateLabel.text = data.records?.journal_voucher_date ?? "----"
                    self?.creditTotalLabel.text = data.records?.journal_voucher_credit_total ?? "----"
                    self?.debitTotalLabel.text = data.records?.journal_voucher_debit_total ?? "----"
                    self?.totalRecordsLable.text = data.records?.journal_voucher_no_of_records ?? "----"
                    self?.financialDateLabel.text = data.financial_year?.label ?? "----"
                    self?.writerLable.text = data.records?.writer_name ?? "----"
                    self?.onDateLabel.text = data.records?.transaction_created_date ?? "----"
                    self?.onUpdatedLabel.text = data.records?.journal_voucher_updated_date ?? "----"
                    self?.transactionData = data.transactions ?? []
                 }else{
                     self?.transactionData.removeAll()
                     SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
                self?.tableView.reloadData()
            }
        }
    }
    
    private func exportPDF(){
        showLoadingActivity()
        APIController.shard.exportFile(url: "/accounts/exportdata/PDF/JRN/\(journalVoucherId)/\(branchId)") { data in
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
