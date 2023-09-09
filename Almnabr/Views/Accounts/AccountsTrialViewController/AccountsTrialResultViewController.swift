//
//  AccountsTrialResultViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 02/03/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class AccountsTrialResultViewController: UIViewController {
    
    @IBOutlet weak var emptyDataLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var transactionButtonAction:((_ data:GeneralLedgerRecord)->Void)?
    private var data = [GeneralLedgerRecord]()
    var url = ""
    var body:[String:Any] = [:]
    var finance_id = ""
    var branch_id = ""
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
        getAccountsTrialData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    @objc private func cancelAction(){
        navigationController?.dismiss(animated: true)
    }
    
}

// MARK: - Table View Delegate
extension AccountsTrialResultViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "AccountsTrialResultTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountsTrialResultTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountsTrialResultTableViewCell",for: indexPath) as! AccountsTrialResultTableViewCell
        cell.setData(data:data[indexPath.row])
        cell.transactionButtonAction = { [weak self] in
            self?.transactionButtonAction?(self!.data[indexPath.row])
        }
        return cell
    }
    
}
// MARK: - API Handling
extension AccountsTrialResultViewController{
    private func getAccountsTrialData(){
        showLoadingActivity()
        APIController.shard.getAccountsTrialData(url:url,body: body) { data in
            DispatchQueue.main.async { [weak self] in
                self?.hideLoadingActivity()
                if data.status ?? false{
                    self?.data = data.records ?? []
                }else{
                    self?.data.removeAll()
                }
                self?.tableView.reloadData()
                self?.emptyDataLabel.isHidden = !(self?.data.isEmpty ?? true)
            }
        }
    }
}
