//
//  OutgoingHistoryViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 27/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class OutgoingHistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!
    private var data = [TransactionsContractRecord]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initlziation()
        // Do any additional setup after loading the view.
    }
    
    
    private func initlziation(){
        setUpTableView()
        self.data = ViewOutgoingViewController.data?.transactions_records?.records ?? []
        messageLabel.text = "There Are No Data !!!".localized()
        messageLabel.isHidden = !data.isEmpty
    }
    
    
}

extension OutgoingHistoryViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "OutgoingHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "OutgoingHistoryTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OutgoingHistoryTableViewCell", for: indexPath) as! OutgoingHistoryTableViewCell
        cell.setData(data: data[indexPath.row])
        return cell
    }
}


