//
//  StatementAccountsResultViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 26/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class StatementAccountsResultViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyDataLabel: UILabel!

    
    private var data = [StatementAccountsRecord]()
    private var ledgerData = [GeneralLedgerRecord]()
    
    private var totalPages = 1
    private var pageNumber = 1
    var requestBody:[String:Any] = [:]
    var type:StatmentType = .account
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        navigationItem.leftBarButtonItem = .init(customView:cancelButton)
        
        getStatementAccountsData(isFromBottom: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    @objc private func cancelAction(){
        navigationController?.dismiss(animated: true)
    }
    
}

// MARK: - Table View Delegate and Data Source
extension StatementAccountsResultViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        if type == .ledger{

            tableView.register(.init(nibName: "GeneralLedgerTableViewCell", bundle: nil), forCellReuseIdentifier: "GeneralLedgerTableViewCell")
        }else{
            tableView.register(.init(nibName: "StatementAccountsResultTableViewCell", bundle: nil), forCellReuseIdentifier: "StatementAccountsResultTableViewCell")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return type == .ledger ? ledgerData.count : data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if type == .ledger{
            let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralLedgerTableViewCell", for: indexPath) as! GeneralLedgerTableViewCell
            cell.setData(data:ledgerData[indexPath.row])
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatementAccountsResultTableViewCell", for: indexPath) as! StatementAccountsResultTableViewCell
        cell.setData(data:data[indexPath.row])
        return cell
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row == data.count - 1 {
//            if prageNumber < totalPages{
//                pageNumber += 1
//                getStatementAccountsData(isFromBottom: true)
//            }
//        }
//    }
}


// MARK: - API Controller
extension StatementAccountsResultViewController{
    private func getStatementAccountsData(isFromBottom:Bool){
        if isFromBottom {
            pageNumber = 1
        }
        var url = ""
        switch type{
        case .account:
            url = "stmtofacc"
        case .cost:
            url = "stmtofcost"
        case .ledger:
            url = "general_ledger"
        }
        showLoadingActivity()
        if type == .ledger{
            APIController.shard.getStatementAccountsData(url:url,body: requestBody) { data  in
                DispatchQueue.main.async { [weak self] in
                    self?.hideLoadingActivity()
                    if data.status ?? false{
                        if isFromBottom{
                            self?.ledgerData.append(contentsOf: data.records ?? [])
                        }else{
                            self?.ledgerData = data.records ?? []
                        }
                    }else{
                        if !isFromBottom{
                            self?.ledgerData.removeAll()
                        }
                    }
                    self?.tableView.reloadData()
                    self?.emptyDataLabel.isHidden = !(self?.ledgerData.isEmpty ?? true)
                }
            }
        }else{
            APIController.shard.getStatementAccountsData(url:url,body: requestBody) { data  in
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
                    self?.tableView.reloadData()
                    self?.emptyDataLabel.isHidden = !(self?.data.isEmpty ?? true)
                }
            }
        }
    }
    
    
    
}
