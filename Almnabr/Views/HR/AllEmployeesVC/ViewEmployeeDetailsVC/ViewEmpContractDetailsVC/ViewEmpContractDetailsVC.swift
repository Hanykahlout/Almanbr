//
//  ViewEmpContractDetailsVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 12/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ViewEmpContractDetailsVC: UIViewController {
    
    @IBOutlet weak var emptyDataImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    private var data = [ContractData]()
    private var pageNumber = 1
    private var totalPages = 1
    var id = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initlization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBarTitle(navigationTitle: "Contract Details")
        navigationController?.setNavigationBarHidden(false, animated: true)
        getContracts(isFromBottom: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func initlization(){
        setUpTableView()
    }
    
    
    
}


extension ViewEmpContractDetailsVC: UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "ContractTVCell", bundle: nil), forCellReuseIdentifier: "ContractTVCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContractTVCell", for: indexPath) as! ContractTVCell
        cell.setData(data: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1 && totalPages > pageNumber{
            pageNumber += 1
            getContracts(isFromBottom: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewContractVC()
        let obj = data[indexPath.row]
        vc.transaction_request_id = obj.transaction_request_id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


// API Handling
extension ViewEmpContractDetailsVC{
    private func getContracts(isFromBottom:Bool){
        if !isFromBottom{
            pageNumber = 1
        }
        showLoadingActivity()
        APIController.shard.getHRContracts(pageNumber: "\(pageNumber)", searchKey: searchTextField.text!, id: id) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status =  data.status , status{
                    if isFromBottom {
                        self.data.append(contentsOf: data.records ?? [])
                        
                    } else {
                        self.data = data.records ?? []
                        
                    }
                    
                    self.emptyDataImageView.isHidden = !self.data.isEmpty
                }else{
                    self.data.removeAll()
                    self.emptyDataImageView.isHidden = false
                }
                self.totalPages = data.page?.total_pages ?? 1
                self.tableView.reloadData()
            }
        }
    }
}


