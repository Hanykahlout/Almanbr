//
//  BlockAccountsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 03/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class BlockAccountsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyDataImageView: UIImageView!
    
    private var pageNumber = 1
    private var totalPages = 1
    private var data = [BlockAccountsRecord]()
    private var observer:NSObjectProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        // Do any additional setup after loading the view.
    }
    
    private func initialization(){
        setUpTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBlockAccountsData(isFromBottom: false)
        observer = NotificationCenter.default.addObserver(forName: .init("ReloadBlockAccounts"), object: nil, queue: .main) { notify in
            self.getBlockAccountsData(isFromBottom: false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(observer!)
    }
}

extension BlockAccountsViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "BlockAccountsTableViewCell", bundle: nil), forCellReuseIdentifier: "BlockAccountsTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlockAccountsTableViewCell", for: indexPath) as! BlockAccountsTableViewCell
        cell.setData(data: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1{
            if pageNumber < totalPages{
                pageNumber += 1
                getBlockAccountsData(isFromBottom: true)
            }
        }
    }
}

// MARK: - API Handlling
extension BlockAccountsViewController{
    private func getBlockAccountsData(isFromBottom:Bool){
        if !isFromBottom {
            pageNumber = 1
        }
        showLoadingActivity()
        APIController.shard.getBlockAccountsData(branch_id: AccountSettingsViewController.branch_id, finance_id: AccountSettingsViewController.finance_id, pageNumber: String(pageNumber)) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    if isFromBottom{
                        self.data.append(contentsOf: data.records ?? [])
                    }else{
                        self.data = data.records ?? []
                    }
                    self.totalPages = data.page?.total_pages ?? 1
                }else{
                    if !isFromBottom{
                        self.data.removeAll()
                    }
                }
                self.emptyDataImageView.isHidden = !self.data.isEmpty
                self.tableView.reloadData()
            }
        }
    }
}
