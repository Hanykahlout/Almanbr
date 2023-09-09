//
//  AllEmployeesVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 05/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit


class AllEmployeesVC: UIViewController {

    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var header: HeaderView!

    private var data = [AllEmployeeRecords]()
    private var pageNumber = 1
    private var totalPages:Int?
    private var body:[String:Any] = [:]
    private var filterInfo:FilterInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }
    
    private func initlization(){
        
        observeFilterAction()
        setUpTableView()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getALLEmployees(isNewPage: false)
        header.btnAction = {
            let language =  L102Language.currentAppleLanguage()
            if language == "ar"{
                self.panel?.openRight(animated: true)
            }else{
                self.panel?.openLeft(animated: true)
            }
        }
    }
    

    private func setUpView(){
        filterView.isUserInteractionEnabled = true
        filterView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(filterAction)))
    }
    
    private func observeFilterAction(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("FilterAction"), object: nil, queue: .main) { notifi in
            guard let arr = notifi.object as? [Any] else { return }
            if let body = arr.first as? [String:Any] , let filterInfo = arr.last as? FilterInfo{
                self.filterInfo = filterInfo
                self.body = body
                self.getALLEmployees(isNewPage: false)
            }
        }
    }


    @objc private func filterAction(){
        let vc = FilterViewController()
        vc.filterInfo = self.filterInfo
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
}

extension AllEmployeesVC:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "EmployeeTableViewCell", bundle: nil), forCellReuseIdentifier: "EmployeeTableViewCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell", for: indexPath) as! EmployeeTableViewCell
        cell.delegate = self
        cell.setData(data: data[indexPath.row],indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1 {
            if let totalPages = totalPages{
                if totalPages > pageNumber{
                    pageNumber = pageNumber + 1
                    getALLEmployees(isNewPage: true)
                }
            }
        }
    }

}

// MARK: - Cell Delegate

extension AllEmployeesVC:EmployeeTableViewCellDelegate{
    func goToViewVC(empID: String, branchId:String, empImage: String) {
        let vc:ViewEmployeeDetailsVC = AppDelegate.HRSB.instanceVC()
        vc.empId = empID
        vc.branchId = branchId
        vc.empImageString = empImage
        navigationController?.pushViewController(vc, animated: true)
    }

    func goToEdiVC(empID:String,empImage:String) {
        let vc:EditEmployeeDetailsVC = AppDelegate.HRSB.instanceVC()
        vc.empImageString = empImage
        vc.empId = empID
        navigationController?.pushViewController(vc, animated: true)
    }

    func deleteAction(id: String, indexPath: IndexPath) {
        self.deleteEmployee(id: id, indexPath: indexPath)
    }


}


// MARK: - Handling API Requests

extension AllEmployeesVC{

    private func getALLEmployees(isNewPage:Bool){
        showLoadingActivity()
        if !isNewPage{
            pageNumber = 1
        }
        APIController.shard.getAllEmployees(pageNumber:String(pageNumber),body: body) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status{
                    if status{
                        self.totalPages = data.page?.total_pages
                        if isNewPage{
                            self.data.append(contentsOf: data.records ?? [])
                        }else{
                            self.data = data.records ?? []
                        }
                    }else{
                        self.data.removeAll()
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }


    private func deleteEmployee(id:String,indexPath:IndexPath){
        APIController.shard.deleteEmployee(id: id) { data in
            DispatchQueue.main.async {
                if let status = data.status,status{
                    let alertVC = UIAlertController(title: "Success".localized(), message: data.msg, preferredStyle: .alert)
                    alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel,handler: { action in
                        self.data.remove(at: indexPath.row)
                        self.tableView.reloadData()
                    }))
                    self.present(alertVC, animated: true)

                }else{
                    let alertVC = UIAlertController(title: "error".localized(), message: data.error, preferredStyle: .alert)
                    alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel))
                    self.present(alertVC, animated: true)
                }
            }
        }
    }


}

