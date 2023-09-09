//
//  BalanceSheetsResultViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 04/03/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
class BalanceSheetsResultViewController: UIViewController {
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var emptyDataLabel: UILabel!
    
    private var assetsStatementsView:StatementsView?
    private var assetsPreviousStatementsView:StatementsView?
    private var liabilitiesStatementsView:StatementsView?
    private var liabilitiesPreviousStatementsView:StatementsView?
    private var currentLiabilitiesStatementsView:StatementsView?
    private var currentLiabilitiesPreviousStatementsView:StatementsView?
    
    var transactionButtonAction: ((_ data:AssetsRecord) -> Void)?
    var branch_id = ""
    var finance_id = ""
    var url = ""
    var body:[String:Any] = [:]
    var isComparePreviousYear = false
    var isBalanceSheets = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        navigationItem.leftBarButtonItem = .init(customView:cancelButton)
        removeAllSubViews()
        getBalanceSheetsData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func removeAllSubViews(){
        for view in self.mainStackView.subviews{
            view.removeFromSuperview()
        }
    }
    
    
    @objc private func cancelAction(){
        navigationController?.dismiss(animated: true)
    }
    
}

// MARK: - API Handling
extension BalanceSheetsResultViewController{
    private func getBalanceSheetsData(){
        showLoadingActivity()
        APIController.shard.getBalanceSheetsData(url: url, body: body) { data in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.hideLoadingActivity()
                if data?.status ?? false{
                    self.mainStackView.isHidden = false
                    self.emptyDataLabel.isHidden = true
                    
                    if self.isBalanceSheets{
                        self.assetsStatementsView = StatementsView()
                        self.assetsStatementsView?.titleLabel.text = "Assets Statements"
                        self.assetsStatementsView!.data = data?.current_year_records?.assets_records ?? []
                        
                        self.liabilitiesStatementsView = StatementsView()
                        self.liabilitiesStatementsView?.titleLabel.text = "Liabilities Statements"
                        self.liabilitiesStatementsView!.data = data?.current_year_records?.liabilities_records ?? []
                        
                        self.currentLiabilitiesStatementsView = StatementsView()
                        self.currentLiabilitiesStatementsView?.titleLabel.text = "Current Liabilities Statements"
                        self.currentLiabilitiesStatementsView!.data = data?.current_year_records?.capital_records ?? []
                        
                        self.mainStackView.addArrangedSubview(self.assetsStatementsView!)
                        self.mainStackView.addArrangedSubview(self.liabilitiesStatementsView!)
                        self.mainStackView.addArrangedSubview(self.currentLiabilitiesStatementsView!)
                    }else{
                        self.assetsStatementsView = StatementsView()
                        self.assetsStatementsView?.titleLabel.text = "Income Statements"
                        self.assetsStatementsView!.data = data?.current_year_records?.income_records ?? []
                        
                        self.liabilitiesStatementsView = StatementsView()
                        self.liabilitiesStatementsView?.titleLabel.text = "Expense Statements"
                        self.liabilitiesStatementsView!.data = data?.current_year_records?.expenses_records ?? []
                        
                        self.mainStackView.addArrangedSubview(self.assetsStatementsView!)
                        self.mainStackView.addArrangedSubview(self.liabilitiesStatementsView!)
                    }
                    
                    if self.isComparePreviousYear{
                        if  self.isBalanceSheets{
                            self.assetsPreviousStatementsView = StatementsView()
                            self.assetsPreviousStatementsView?.titleLabel.text = "Assets Previous Statements"
                            self.assetsPreviousStatementsView!.data = data?.previous_year_records?.assets_records ?? []
                            
                            self.liabilitiesPreviousStatementsView = StatementsView()
                            self.liabilitiesPreviousStatementsView?.titleLabel.text = "Liabilities Previous Statements"
                            self.liabilitiesPreviousStatementsView!.data = data?.previous_year_records?.liabilities_records ?? []
                            
                            self.currentLiabilitiesPreviousStatementsView = StatementsView()
                            self.currentLiabilitiesPreviousStatementsView?.titleLabel.text = "Current Liabilities Previous Statements"
                            self.currentLiabilitiesPreviousStatementsView!.data = data?.previous_year_records?.capital_records ?? []
                            
                            
                            self.mainStackView.addArrangedSubview(self.assetsPreviousStatementsView!)
                            self.mainStackView.addArrangedSubview(self.liabilitiesPreviousStatementsView!)
                            self.mainStackView.addArrangedSubview(self.currentLiabilitiesPreviousStatementsView!)
                        }else{
                            
                            self.assetsPreviousStatementsView = StatementsView()
                            self.assetsPreviousStatementsView?.titleLabel.text = "Income Previous Statements"
                            self.assetsPreviousStatementsView!.data = data?.previous_year_records?.income_records ?? []
                            
                            self.liabilitiesPreviousStatementsView = StatementsView()
                            self.liabilitiesPreviousStatementsView?.titleLabel.text = "Expense Previous Statements"
                            self.liabilitiesPreviousStatementsView!.data = data?.previous_year_records?.expenses_records ?? []
                            
                            self.mainStackView.addArrangedSubview(self.assetsPreviousStatementsView!)
                            self.mainStackView.addArrangedSubview(self.liabilitiesPreviousStatementsView!)
                        }
                        
                    }
                    
                    self.assetsStatementsView?.trasactionCellButtonAction = self.transactionButtonAction
                    self.assetsPreviousStatementsView?.trasactionCellButtonAction = self.transactionButtonAction
                    self.liabilitiesStatementsView?.trasactionCellButtonAction = self.transactionButtonAction
                    self.liabilitiesPreviousStatementsView?.trasactionCellButtonAction = self.transactionButtonAction
                    self.currentLiabilitiesStatementsView?.trasactionCellButtonAction = self.transactionButtonAction
                    self.currentLiabilitiesPreviousStatementsView?.trasactionCellButtonAction = self.transactionButtonAction
                    
                }else{
                    self.mainStackView.isHidden = true
                    self.emptyDataLabel.isHidden = false
                }
            }
            
        }
    }
    
}


