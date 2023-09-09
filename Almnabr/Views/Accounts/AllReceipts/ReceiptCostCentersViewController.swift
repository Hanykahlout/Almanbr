//
//  ReceiptCostCentersViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 19/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
class ReceiptCostCentersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyDataImageView: UIImageView!
    
    
    private var data = [CardCostData]()
    var transactionId = ""
    var receiptId = ""
    var transactionHistoryId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        addNavigationBarTitle(navigationTitle: "Cost Center")
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        navigationItem.leftBarButtonItem = .init(customView:cancelButton)
        getData()
    }

    @objc private func cancelAction(){
        navigationController?.dismiss(animated: true)
    }


}

extension ReceiptCostCentersViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "ReceiptCostCentersTableViewCell", bundle: nil), forCellReuseIdentifier: "ReceiptCostCentersTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiptCostCentersTableViewCell", for: indexPath) as! ReceiptCostCentersTableViewCell
        cell.setData(data: data[indexPath.row])
        return cell
    }
    
}

// MARK: - API Controller
extension ReceiptCostCentersViewController{
    private func getData(){
        showLoadingActivity()
        APIController.shard.getReceiptCostCenters(transactionId: transactionId, receiptId: receiptId, transactionHistoryId: transactionHistoryId) { data in
            DispatchQueue.main.async { [weak self] in
                self?.hideLoadingActivity()
                if data.status ?? false{
                    self?.data = data.records ?? []
                }else{
                    self?.data.removeAll()
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
                self?.emptyDataImageView.isHidden = !(self?.data.isEmpty ?? true)
                self?.tableView.reloadData()
            }
        }
    }
}
