//
//  ViewEmpContactDetailsVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 12/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ViewEmpContactDetailsVC: UIViewController {
    
    
    @IBOutlet weak var primaryMobileLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private var data = [ContactRecords]()
    private var pageNumber = 0
    private var totalPages = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlizaiton()
        
    }
    
    private func initlizaiton(){
        setUpTableView()
        setUpTextField()
        setContactDetails()
        
        addObserver()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllContacts(isFromBottom: false)
    }
    
    
    private func setUpTextField(){
        searchTextField.addTarget(self, action: #selector(searchAction(textField:)), for: .editingChanged)
    }
    
    private func setContactDetails(){
        primaryMobileLabel.text = ViewEmployeeDetailsVC.empData.data?.primary_mobile ?? ""
        emailAddressLabel.text = ViewEmployeeDetailsVC.empData.data?.primary_address ?? ""
        addressLabel.text = ViewEmployeeDetailsVC.empData.data?.primary_address ?? ""
    }
    
    private func addObserver(){
        NotificationCenter.default.addObserver(forName: .init(rawValue: "LoadingContacts"), object: nil,queue: .main) { notifi in
            self.getAllContacts(isFromBottom: false)
        }
    }
    
    @objc private func searchAction(textField:UITextField){
        getAllContacts(isFromBottom: false)
    }
    
    @IBAction func addAction(_ sender: Any) {
        let vc = AddEmpContactViewController()
        vc.isView = false
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewEmpContactDetailsVC:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "ContactDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactDetailsTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactDetailsTableViewCell", for: indexPath) as! ContactDetailsTableViewCell
        cell.delegate = self
        cell.setData(data:data[indexPath.row],indexPath:indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1 {
            if pageNumber < totalPages{
                pageNumber += 1
                getAllContacts(isFromBottom: true)
            }
        }
    }
    
}
// MARK: - Table View Cell Delegate
extension ViewEmpContactDetailsVC:ContactDetailsCellDelegate{
    func deleteCellAction(id:String,indexPath: IndexPath) {
        deleteContact(id: id, indexPath: indexPath)
    }
    
    func viewAction(data:ContactRecords) {
        let vc = AddEmpContactViewController()
        vc.data = data
        vc.isView = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateAction(data:ContactRecords) {
        let vc = AddEmpContactViewController()
        vc.data = data
        vc.isView = false
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - API Handling

extension ViewEmpContactDetailsVC{
    private func getAllContacts(isFromBottom:Bool){
        if !isFromBottom { pageNumber = 1 }
        showLoadingActivity()
        APIController.shard.getAllContactDetails(pageNumber: "\(pageNumber)",searchKey: searchTextField.text!, branch_id: ViewEmployeeDetailsVC.empData.data?.branch_id ?? "", id: ViewEmployeeDetailsVC.empData.data?.employee_number ?? "", employee_id_number: ViewEmployeeDetailsVC.empData.data?.employee_id_number ?? "") { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    if isFromBottom{
                        self.data.append(contentsOf: data.records ?? [])
                    }else{
                        self.data = data.records ?? []
                    }
                    self.totalPages = data.page?.total_pages ?? 0
                }else{
                    self.data.removeAll()
                }
                self.tableView.reloadData()
            }
        }
    }
    
    
    func deleteContact(id:String,indexPath:IndexPath){
        showLoadingActivity()
        let branchId = ViewEmployeeDetailsVC.empData.data?.branch_id ?? ""
        APIController.shard.deleteEmpContact(key_id: id, branchId: branchId ,empId: ViewEmployeeDetailsVC.empData.data?.employee_number ?? "") { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    let alertVC = UIAlertController(title: "Success".localized(), message: data.msg, preferredStyle: .alert)
                    alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel, handler: { action in
                        self.data.remove(at: indexPath.row)
                        self.tableView.reloadData()
                    }))
                    self.present(alertVC, animated: true)
                }else{
                    let alertVC = UIAlertController(title: "error".localized(), message: data.error, preferredStyle: .alert)
                    alertVC.addAction(.init(title: "cancel".localized(), style: .cancel, handler: nil))
                    self.present(alertVC, animated: true)
                }
            }
        }
    }
}
