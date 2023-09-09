//
//  OpeningBalanceViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 30/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class OpeningBalanceViewController: UIViewController {
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var totalDebitAmountLabel: UILabel!
    @IBOutlet weak var totalCreditAmountLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var branchSelectionStackView: UIStackView!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var emptyDataImageView: UIImageView!
    
    private var branchSelector:BranchSelection?
    private var data = [OpeningBalanceRecord]()
    private var branchId = ""
    private var financialId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    
    private func initialization(){
        handleHeaderView()
        setUpBranchSelector()
        setUpTableView()
        searchTextField.addTarget(self, action: #selector(searchAction), for: .editingChanged)
    }
    
    private func setUpBranchSelector(){
        branchSelector = BranchSelection()
        branchSelectionStackView.addArrangedSubview(branchSelector!)
        branchSelector!.withFinancialYearSelection = true
        branchSelector!.financialYearSelectionAction = { [weak self] financialId in
            self?.financialId = financialId
            self?.getData(fromSearch: false)
        }
        
        branchSelector!.branchSelectionAction = { [weak self] branchId in
            self?.branchId = branchId
            self?.getData(fromSearch: false)
        }
        
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
        getData(fromSearch: true)
    }
    
}

extension OpeningBalanceViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "OpeningBalanceTableViewCell", bundle: nil), forCellReuseIdentifier: "OpeningBalanceTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OpeningBalanceTableViewCell", for: indexPath) as! OpeningBalanceTableViewCell
        cell.setData(data: data[indexPath.row])
        return cell
    }
}


// MARK: - API Controller
extension OpeningBalanceViewController{
    private func getData(fromSearch:Bool){
        showLoadingActivity()
        APIController.shard.getOpeningBalanceData(branch_id: branchId, finance_id: financialId, search_key: searchTextField.text!) { data in
            DispatchQueue.main.async { [weak self] in
                self?.hideLoadingActivity()
                if data.status ?? false{
                    self?.data = data.records ?? []
                    
                    var totalDebit = 0.0
                    _ = (data.records ?? []).map{totalDebit += Double($0.debit_amount ?? "0.0") ?? 0.0}
                    var totalCredit = 0.0
                    _ = (data.records ?? []).map{totalCredit += Double($0.credit_amount ?? "0.0") ?? 0.0}
                    
                    self?.totalDebitAmountLabel.text = String(totalDebit)
                    self?.totalCreditAmountLabel.text = String(totalCredit)
                    self?.mainStackView.isHidden = false
                }else{
                    self?.data.removeAll()
                    if !fromSearch {
                        self?.mainStackView.isHidden = true
                    }
                }
                self?.emptyDataImageView.isHidden = !(self?.data.isEmpty ?? true)
                self?.tableView.reloadData()
            }
        }
    }
}




