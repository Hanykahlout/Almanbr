//
//  TransactionViewerViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 23/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class TransactionViewerViewController: UIViewController {

    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var branchSelectorStackView: UIStackView!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var numberFilterTextField: UITextField!
    @IBOutlet weak var numberFilterArrow: UIImageView!
    @IBOutlet weak var requestNumberLabel: UILabel!
    @IBOutlet weak var transactionNumberTitleLabel: UILabel!
    @IBOutlet weak var transactionNumberLabel: UILabel!
    @IBOutlet weak var transactionTypeLabel: UILabel!
    @IBOutlet weak var transactionDateLabel: UILabel!
    @IBOutlet weak var debitTotalLabel: UILabel!
    @IBOutlet weak var creditTotalLabel: UILabel!
    @IBOutlet weak var totalRecordsLable: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var emptyDataImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    private var branch_id = ""
    private var finance_id = ""
    private var branchSelector:BranchSelection?
    private var data = [ReceiptTransaction]()
    private var totalPages = 1
    private var pickerVC :PickerVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleHeaderView()
        setUpBranchSelector()
        setUpTableView()
        numberFilterTextField.addTapGesture { [weak self] in
            guard let pickerVC = self?.pickerVC else { return }
            self?.numberFilterArrow.transform = .init(rotationAngle: .pi)
            self?.present(pickerVC, animated: true, completion: nil)
        }
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
        }
        branchSelector?.financialYearSelectionAction = { [weak self] finance_id in
            self?.finance_id = finance_id
            
            self?.getTransactionViewerData()
        }
        branchSelectorStackView.addArrangedSubview(branchSelector!)
    }

    private func setUpPickerView(){
        pickerVC = AppDelegate.mainSB.instanceVC()
        var number = 1
        pickerVC!.arr_data = []
        while number <= totalPages{
            pickerVC!.arr_data.append(String(number))
            number += 1
        }
        pickerVC!.isModalInPresentation = true
        pickerVC!.modalPresentationStyle = .overFullScreen
        pickerVC!.definesPresentationContext = true
        pickerVC!.delegate = { [weak self] name , index in
            self?.numberFilterArrow.transform = .init(rotationAngle: 0)
            self?.numberFilterTextField.text = name
            self?.getTransactionViewerData()
        }
    }
    
    @objc private func searchAction(){
        getTransactionViewerData()
    }
    
}

extension TransactionViewerViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "TransactionViewerTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionViewerTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionViewerTableViewCell", for: indexPath) as! TransactionViewerTableViewCell
        cell.setData(data:data[indexPath.row])
        return cell
    }
    
}


extension TransactionViewerViewController{
    private func getTransactionViewerData(){
        showLoadingActivity()
        APIController.shard.getTransactionViewerData(branch_id: branch_id, numberFilter: numberFilterTextField.text!, search_key: searchTextField.text!, finance_id: finance_id) { data in
            DispatchQueue.main.async { [weak self] in
                self?.hideLoadingActivity()
                if data.status ?? false{
                    self?.data = data.transactions ?? []
                    self?.requestNumberLabel.text = data.records?.transaction_id ?? "----"
                    switch data.records?.transaction_listing{
                    case "RECEIPT":
                        self?.transactionNumberTitleLabel.text = "Receipt"
                    case "SINVOICE":
                        self?.transactionNumberTitleLabel.text = "Selling Invoice"
                    case "PINVOICE":
                        self?.transactionNumberTitleLabel.text = "Purchase Invoice"
                    case "JOURNAL":
                        self?.transactionNumberTitleLabel.text = "Journal"
                    case "PAYMENT":
                        self?.transactionNumberTitleLabel.text = "Payment"
                    case "REVERSE":
                        self?.transactionNumberTitleLabel.text = "Reverse"
                     case "ADDMORE":
                        self?.transactionNumberTitleLabel.text = "Add more"
                    default:
                        break
                    }
                    self?.transactionNumberTitleLabel.text! += " Number"
                    self?.transactionNumberLabel.text = data.records?.request_id ?? "----"
                    self?.transactionTypeLabel.text = data.records?.transaction_type ?? "----"
                    self?.transactionDateLabel.text = data.records?.transaction_date ?? "----"
                    self?.debitTotalLabel.text = data.records?.total_debit ?? "----"
                    self?.creditTotalLabel.text = data.records?.total_credit ?? "----"
                    self?.totalRecordsLable.text = data.records?.no_of_records ?? "----"
                    self?.writerLabel.text = data.records?.writer_name ?? "----"
                    self?.totalPages = data.paging?.total_pages ?? 1
                    self?.setUpPickerView()
                    self?.mainStackView.isHidden = self?.branch_id == ""
                    self?.numberFilterArrow.isHidden = self?.branch_id == ""
                }else{
                    self?.data.removeAll()
                }
                self?.tableView.reloadData()
                self?.emptyDataImageView.isHidden = !(self?.data.isEmpty ?? true)
            }
        }
    }
}


