//
//  ViewEmpModulesVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 12/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown

class ViewEmpModulesVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchTextFild: UITextField!
    
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterArrow: UIImageView!
    
    private var dropDown = DropDown()
    private var data = [AllModulesRecords]()
    private var filterData = [ModulesRecords]()
    private var selectedFilterModule:ModulesRecords?
    private var pageNumber = 1
    private var totalPages = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    
    private func initlization(){
        filterLabel.text = "All".localized()
        addCellObserver()
        setUpTableView()
        setUpDropDownList()
        getModules()
        searchTextFild.addTarget(self, action: #selector(searchViewAction), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllModules(isFromBottom: false)
    }
    
    private func addCellObserver(){
        NotificationCenter.default.addObserver(forName: .init(rawValue: "GoToUsersVC"), object: nil, queue: .main) { notify in
            guard let data = notify.object as? AllModulesRecords else { return }
            let vc = UsersViewController()
            vc.module = data
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func setUpDropDownList(){
        dropDown.anchorView = filterView
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.filterArrow.transform = .init(rotationAngle: 0)
            filterLabel.text = item
            if index != filterData.count{
                self.selectedFilterModule = filterData[index]
            }else{
                self.selectedFilterModule = nil
            }
            getAllModules(isFromBottom: false)
        }
        dropDown.cancelAction = { [unowned self] in
            self.filterArrow.transform = .init(rotationAngle: 0)
        }
        filterView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(filterViewAction)))
    }
    
    @objc private func searchViewAction(){
        getAllModules(isFromBottom: false)
    }
    
    @objc private func filterViewAction(){
        self.filterArrow.transform = .init(rotationAngle: .pi)
        dropDown.show()
    }
    
}

extension ViewEmpModulesVC:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "ModulesTableViewCell", bundle: nil), forCellReuseIdentifier: "ModulesTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ModulesTableViewCell", for: indexPath) as! ModulesTableViewCell
        cell.setData(data:data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1{
            if pageNumber < totalPages{
                pageNumber += 1
                getAllModules(isFromBottom: true)
            }
        }
    }
}

// MARK: - API Handling
extension ViewEmpModulesVC{
    private func getModules(){
        APIController.shard.getModulesFilter { data in
            if let status = data.status,status{
                self.filterData = data.records ?? []
                self.dropDown.dataSource = self.filterData.map{$0.module_phrase_val ?? ""}
                self.dropDown.dataSource.append("All".localized())
            }
        }
    }
    
    private func getAllModules(isFromBottom:Bool){
        if !isFromBottom{
            pageNumber = 1
        }
        let empId = ViewEmployeeDetailsVC.empData.data?.employee_number ?? ""
        showLoadingActivity()
        APIController.shard.getModules(pageNumber: "\(pageNumber)", searchKey: searchTextFild.text!, module_name: selectedFilterModule?.module_key ?? "", empId: empId) { data in
            DispatchQueue.main.async{
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
                }
                self.tableView.reloadData()
            }
        }
    }
    
    
}
