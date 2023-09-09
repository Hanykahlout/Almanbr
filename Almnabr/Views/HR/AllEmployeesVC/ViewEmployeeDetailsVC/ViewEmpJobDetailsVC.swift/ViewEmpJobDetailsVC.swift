//
//  ViewEmpJobDetailsVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 12/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ViewEmpJobDetailsVC: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    private var data = [JopDetailsRecords]()
    private var pageNumber:Int = 1
    private var totalPages:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }
    
    private func initlization(){
        addObserver()
        setUpTableView()
        setUpTextField()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getJopDetailsData(isFromBottom: false)
    }
    
    
    private func addObserver(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("LoadingPositions"), object: nil, queue: .main) { notifi in
            self.getJopDetailsData(isFromBottom: false)
        }
    }

    private func setUpTextField(){
        self.searchTextField.isUserInteractionEnabled = true
        self.searchTextField.addTarget(self, action: #selector(searchAction), for: .editingChanged)
    }
    
    
    @objc private func searchAction(){
        getJopDetailsData(isFromBottom: false)
    }
    
    @IBAction func addAction(_ sender: Any) {
        let vc = AddJopDetailsViewController()
        vc.isView = false
        vc.isUpload = false
        vc.empId = ViewEmployeeDetailsVC.empData.data?.employee_number ?? ""
        navigationController!.pushViewController(vc, animated: true)
    }
    
    
}

extension ViewEmpJobDetailsVC:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "JopDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "JopDetailsTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JopDetailsTableViewCell", for: indexPath) as! JopDetailsTableViewCell
        cell.delegate = self
        cell.setData(data: data[indexPath.row],indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1 {
            if let totalPages = totalPages{
                if totalPages > pageNumber{
                    pageNumber += 1
                    getJopDetailsData(isFromBottom: true)
                }
            }
        }
    }
    
    
    
}
// MARK: - Table View Cell Delegate

extension ViewEmpJobDetailsVC:JopDetailsCellDelegate{
    func goToUpdateVC(isView:Bool,positionId: String) {
        let vc = AddJopDetailsViewController()
        vc.isUpload = true
        vc.isView = isView
        vc.empId = ViewEmployeeDetailsVC.empData.data?.employee_number ?? ""
        vc.positionId = positionId
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func deleteCell(id: String,indexPath:IndexPath) {
        let alertVC = UIAlertController(title: "Confirmation !!!".localized(), message: "Are you sure !?".localized(), preferredStyle: .alert)
        alertVC.addAction(.init(title: "Yes".localized(), style: .default, handler: { action in
            let branchId = ViewEmployeeDetailsVC.empData.data?.branch_id ?? ""
            self.showLoadingActivity()
            APIController.shard.deleteJopDetails(key_id: id,branchId:branchId ,empId: ViewEmployeeDetailsVC.empData.data?.employee_number ?? "") { data in
                DispatchQueue.main.async{
                    self.hideLoadingActivity()
                    if let status = data.status , status{
                        self.data.remove(at: indexPath.row)
                        self.tableView.reloadData()
                    }
                }
            }
        }))
        
        alertVC.addAction(.init(title: "No".localized(), style: .default))
        present(alertVC, animated: true)
    }
}


// MARK: - API Handling

extension ViewEmpJobDetailsVC{
    private func getJopDetailsData(isFromBottom:Bool){
        if !isFromBottom{
            pageNumber = 1
        }
        showLoadingActivity()
        APIController.shard.getJopDetails(pageNumber:pageNumber,branchId: ViewEmployeeDetailsVC.empData.data?.branch_id ?? "", id: ViewEmployeeDetailsVC.empData.data?.employee_number ?? "", searchKey: searchTextField.text!) { data in
            DispatchQueue.main.async{
                self.hideLoadingActivity()
                if let status = data.status, status{
                    if isFromBottom{
                        self.data.append(contentsOf: data.records ?? [])
                    }else{
                        self.data = data.records ?? []
                    }
                    self.tableView.reloadData()
                    self.totalPages = data.page?.total_pages
                }
            }
        }
    }
}

