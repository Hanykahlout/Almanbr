//
//  CreateJournalVoucherVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 12/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import Fastis
import SCLAlertView
import FAPanels

class CreateJournalVoucherVC: UIViewController {
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var branchSelectorStackView: UIStackView!
    @IBOutlet weak var journalNumberTextField: UITextField!
    
    @IBOutlet weak var journalNumberView: UIView!
    @IBOutlet weak var journalDateTextField: UITextField!
    
    @IBOutlet weak var debitTotalTextField: UITextField!
    
    @IBOutlet weak var creditTotalTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private var branchSelector:BranchSelection?
    var branch_id = ""
    var finance_id = ""
    var journal_voucher_id = ""
    private var fastisController = FastisController(mode: .single)
    private var journalVoucherData = [JournalVoucherData]()
    
    var isEdit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        // Do any additional setup after loading the view.
    }
    
    private func initialization(){
        handleHeaderView()
        if !isEdit {
            setUpBranchSelector()
        }
        setUpFastisController()
        journalDateTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(journalDateAction)))
        setUpTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getEditJournalVoucherData()
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
    
    private func setUpFastisController(){
        fastisController.title = "Choose Date".localized()
        fastisController.allowToChooseNilDate = true
        fastisController.shortcuts = [.today]
        fastisController.doneHandler = { [weak self] result in
            if let result = result {
                self?.journalDateTextField.text = self?.formatedDate(date: result)
            }
        }
    }
    
    private func setUpBranchSelector(){
        branchSelector = BranchSelection()
        branchSelector!.withFinancialYearSelection = true
        branchSelector!.branchSelectionAction = { [weak self] branch_id in
            self?.branch_id = branch_id
            self?.mainStackView.isHidden = false
        }
        branchSelector?.financialYearSelectionAction = { [weak self] finance_id in
            self?.finance_id = finance_id
            
        }
        branchSelectorStackView.addArrangedSubview(branchSelector!)
    }
    
    
    private func addJournalVoucherDataAction(_ data:JournalVoucherData,_ index:Int?){
        if let index = index{
            journalVoucherData[index] = data
        }else{
            journalVoucherData.append(data)
        }
        calculateCardsTotal()
        tableView.reloadData()
    }
    
    private func calculateCardsTotal(){
        var debitCount:Double = 0.0
        var creditCount:Double = 0.0
        _ = journalVoucherData.map{
            debitCount += Double($0.debitAmount ?? "0.0")!
            creditCount += Double($0.creditAmount ?? "0.0")!
        }
        debitTotalTextField.text = String(debitCount)
        creditTotalTextField.text = String(creditCount)
    }
    
    private func goToAllJournalVouchers(){
        let vc = AllJournalVouchersViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        panel?.center(nav)
    }
    
    
    @objc private func journalDateAction(){
        fastisController.present(above: self)
    }
    

    @IBAction func addAction(_ sender: Any) {
        let vc = AddJournalVoucherDataVC()
        vc.addAction = addJournalVoucherDataAction
        vc.branchId = branch_id
        vc.finance_id = finance_id
        let nav = UINavigationController(rootViewController: vc)
        navigationController?.present(nav, animated: true)
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        createJournalVoucher()
    }
    
    
}

extension CreateJournalVoucherVC:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "CreateJournalVoucherTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateJournalVoucherTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journalVoucherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreateJournalVoucherTableViewCell", for: indexPath) as! CreateJournalVoucherTableViewCell
        cell.setData(data:journalVoucherData[indexPath.row])
        cell.didSelectOnDelete = { [weak self] in
            self?.journalVoucherData.remove(at: indexPath.row)
            self?.tableView.reloadData()
            self?.calculateCardsTotal()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddJournalVoucherDataVC()
        vc.index = indexPath.row
        vc.data = journalVoucherData[indexPath.row]
        vc.addAction = addJournalVoucherDataAction
        vc.branchId = branch_id
        vc.finance_id = finance_id
        let nav = UINavigationController(rootViewController: vc)
        navigationController?.present(nav, animated: true)
    }
    
}

// MARK: - API Handling
extension CreateJournalVoucherVC{
    
    private func createJournalVoucher(){
        var body = [
            "branch_id": branch_id,
            "finance_id": finance_id,
            "journal_voucher_date": journalDateTextField.text!,
            "journal_voucher_debit_total": debitTotalTextField.text!,
            "journal_voucher_credit_total": creditTotalTextField.text!,
        ]
        
        for index in 0..<journalVoucherData.count{
            let data = journalVoucherData[index]
            body["journal_records[\(index)][account_masters_id]"] = data.accountCode?.value ?? ""
            body["journal_records[\(index)][credit_amount]"] = data.creditAmount ?? ""
            body["journal_records[\(index)][debit_amount]"] = data.debitAmount ?? ""
            body["journal_records[\(index)][transaction_history_description]"] = data.description ?? ""
            body["journal_records[\(index)][transaction_history_notes]"] = data.notes ?? ""
            body["journal_records[\(index)][transaction_history_ref_number]"] = data.referenceNo ?? ""
            for i in 0..<(data.costCenter?.count ?? 0){
                body["journal_records[\(index)][cost_center_ids][\(i)][cid]"] = data.costCenter?[i].card?.value ?? ""
                body["journal_records[\(index)][cost_center_ids][\(i)][amount]"] = data.costCenter?[i].amount ?? ""
            }
        }
        showLoadingActivity()
        APIController.shard.createJournalVoucher(journal_voucher_id: journal_voucher_id, isEdit: isEdit, body: body) { data in
            DispatchQueue.main.async { [weak self] in
                self?.hideLoadingActivity()
                if data.status ?? false{
                    SCLAlertView().showSuccess("Sucess", subTitle: data.msg ?? "")
                    self?.goToAllJournalVouchers()
                }else{
                    SCLAlertView().showError("Error", subTitle: data.error ?? "")
                }
            }
        }
    }
    
    private func getEditJournalVoucherData(){
        showLoadingActivity()
        APIController.shard.getEditJournalVoucherData(journal_voucher_id:journal_voucher_id , branch_id: branch_id) { data in
            DispatchQueue.main.async { [weak self] in
                self?.hideLoadingActivity()
                if data.status ?? false{
                    self?.setUpBranchSelector()
                    self?.branchSelector?.selecetdBranchId = self?.branch_id ?? ""
                    self?.branchSelector?.selecetdfinancialYear = data.financial_year?.finance_id ?? ""
                    self?.journalDateTextField.text = data.record?.journal_voucher_date ?? ""
                    self?.journalNumberView.isHidden = false
                    self?.journalNumberTextField.text = data.record?.journal_voucher_id ?? ""
                    self?.debitTotalTextField.text = data.record?.journal_voucher_debit_total ?? ""
                    self?.creditTotalTextField.text = data.record?.journal_voucher_credit_total ?? ""
                    for item in data.record?.journal_records ?? []{
                        let obj = JournalVoucherData(
                            accountCode: .init(label: item.account_name ?? "", value: item.account_masters_id ?? ""),
                            debitAmount:item.debit_amount ?? "",
                            creditAmount: item.credit_amount ?? "",
                            description: item.transaction_history_description ?? "",
                            costCenter: [],
                            referenceNo:item.transaction_history_ref_number ?? "",
                            notes: item.transaction_history_notes ?? ""
                        )
                        self?.journalVoucherData.append(obj)
                    }
                }else{
                    self?.journalVoucherData.removeAll()
                }
                self?.tableView.reloadData()
            }
        }
    }
    
    
}


