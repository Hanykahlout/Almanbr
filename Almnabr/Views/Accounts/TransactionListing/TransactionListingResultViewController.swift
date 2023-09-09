//
//  TransactionListingResultViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 07/03/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class TransactionListingResultViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyDataLabel: UILabel!
    
    var transactionButtonAction:((_ data:ReceiptTransaction)->Void)?
    var body:[String:Any] = [:]
    
    private var data = [ReceiptTransaction]()
    
    
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
        
        getTransactionList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc private func cancelAction(){
        navigationController?.dismiss(animated: true)
    }
    
}
// MARK: - Table View Delegate And DataSource
extension TransactionListingResultViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "TransactionListingResultTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionListingResultTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionListingResultTableViewCell", for: indexPath) as! TransactionListingResultTableViewCell
        cell.setData(data:data[indexPath.row])
        cell.transactionButtonAction = {
            self.transactionButtonAction?(self.data[indexPath.row])
        }
        return cell
    }
    
    
}

// MARK: - API Controller
extension TransactionListingResultViewController{
    private func getTransactionList(){
        showLoadingActivity()
        APIController.shard.getTransactionList(body: body) { data in
            DispatchQueue.main.async { [weak self] in
                self?.hideLoadingActivity()
                if data?.status ?? false{
                    self?.data = data?.transactions ?? []
                }else{
                    self?.data.removeAll()
                }
                self?.tableView.reloadData()
                self?.emptyDataLabel.isHidden = !(self?.data.isEmpty ?? true)
            }
        }
    }
}
