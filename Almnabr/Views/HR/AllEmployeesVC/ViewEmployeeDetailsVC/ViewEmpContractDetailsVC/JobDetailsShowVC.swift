//
//  JobDetailsVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 17/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView

class JobDetailsShowVC: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var empNum = ""
    var pageNumber = 1
    var totalPages = 1
    private var data = [JobDetailsRecord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    private func initialization(){
        setUpTableView()
        searchTextField.addTarget(self, action: #selector(searchAction), for: .editingChanged)
    }
    
    @objc private func searchAction(){
        getJobDetailsData(isFromBottom: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getJobDetailsData(isFromBottom: false)
        addNavigationBarTitle(navigationTitle: "Job Details")
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
}

extension JobDetailsShowVC: UITableViewDelegate , UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "JobDetailsShowTableViewCell", bundle: nil), forCellReuseIdentifier: "JobDetailsShowTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobDetailsShowTableViewCell", for: indexPath) as! JobDetailsShowTableViewCell
        cell.setData(data: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1{
            if pageNumber < totalPages{
                pageNumber += 1
                getJobDetailsData(isFromBottom: true)
            }
        }
    }
    
    
}

// MARK: - API Controller

extension JobDetailsShowVC{
    private func getJobDetailsData(isFromBottom:Bool) {
        if !isFromBottom {
            pageNumber = 1
        }
        showLoadingActivity()
        APIController.shard.getJobDetails(pageNumber: String(pageNumber), branch_id: ViewEmployeeDetailsVC.empData.data?.branch_id ?? "", empNum: empNum, searchKey: searchTextField.text!) { data in
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
                    self.data.removeAll()
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
                self.tableView.reloadData()
            }
        }
    }
    
    
}





