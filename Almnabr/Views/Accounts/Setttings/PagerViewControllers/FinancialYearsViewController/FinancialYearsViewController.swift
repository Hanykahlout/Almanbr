//
//  FinancialYearsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 03/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class FinancialYearsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyDataImageView: UIImageView!
    
    private var data = [FinancialYearRecord]()
    private var observer:NSObjectProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        getFinancialYearData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFinancialYearData()
        observer = NotificationCenter.default.addObserver(forName: .init(.init("ReloadFinancialYears")), object: nil, queue: .main, using: { notify in
            self.getFinancialYearData()
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(observer!)
    }
    
}

extension FinancialYearsViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "FinancialYearsTableViewCell", bundle: nil), forCellReuseIdentifier: "FinancialYearsTableViewCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FinancialYearsTableViewCell", for: indexPath) as! FinancialYearsTableViewCell
        cell.setData(data: data[indexPath.row])
        return cell
    }
}

// MARK: - API Handling
extension FinancialYearsViewController{
    private func getFinancialYearData(){
        
        showLoadingActivity()
        APIController.shard.getFinancialYearData(branch_id: AccountSettingsViewController.branch_id) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    self.data = data.records ?? []
                }else{
                    self.data.removeAll()
                }
                self.emptyDataImageView.isHidden = !self.data.isEmpty
                self.tableView.reloadData()
            }
        }
        
    }
}
