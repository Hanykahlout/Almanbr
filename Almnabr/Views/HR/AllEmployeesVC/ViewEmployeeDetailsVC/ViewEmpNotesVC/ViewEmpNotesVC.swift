//
//  ViewEmpNotesVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 12/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
class ViewEmpNotesVC: UIViewController {
    
    @IBOutlet weak var filterStackView: UIStackView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterArrow: UIImageView!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private var pageNumber = 1
    private var totalPages = 1
    private var data = [NoteRecords]()
    private var dropDown = DropDown()
    private var selectedFilterIndex = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    
    private func initlization(){
        setUpTableView()
        setUpDropDownList()
        
        searchTextField.addTarget(self, action: #selector(searchAction), for: .editingChanged)
        addObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllNotes(isFromBottom: false)
    }
    
    private func addObserver(){
        NotificationCenter.default.addObserver(forName: .init("ReloadNotes"), object: nil, queue: .main) { notify in
            self.getAllNotes(isFromBottom: false)
        }
    }
    private func setUpDropDownList(){
        dropDown.anchorView = filterView
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.width = filterStackView.bounds.width
        dropDown.dataSource = ["All".localized(),"Public".localized(),"Private".localized()]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.filterArrow.transform = .init(rotationAngle: 0)
            self.filterLabel.text = item
            switch item{
            case "Public".localized():
                selectedFilterIndex = "1"
            case "Private".localized():
                selectedFilterIndex = "0"
            default:
                selectedFilterIndex = ""
            }
            self.getAllNotes(isFromBottom: false)
        }
        
        dropDown.cancelAction = { [unowned self] in
            self.filterArrow.transform = .init(rotationAngle: 0)
        }
        filterView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(filterAction)))
    }
    
    @objc private func searchAction(){
        getAllNotes(isFromBottom: false)
    }
    
    @objc private func filterAction(){
        filterArrow.transform = .init(rotationAngle: .pi)
        dropDown.show()
    }
    
    
    @IBAction func addAction(_ sender: Any) {
        let vc = AddNotesViewController()
        vc.isView = false
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewEmpNotesVC:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as! NoteTableViewCell
        cell.delegate = self
        cell.setData(data:data[indexPath.row],indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1 {
            if pageNumber < totalPages{
                pageNumber += 1
                getAllNotes(isFromBottom: true)
            }
        }
    }
}

// MARK: - Table View Cell Delegate
extension ViewEmpNotesVC:NoteCellDelegate{
    func updateAction(isView: Bool, data: NoteRecords) {
        let vc = AddNotesViewController()
        vc.isView = isView
        vc.data = data
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func deleteAction(id: String, indexPath: IndexPath) {
        deleteNote(id: id, indexPath: indexPath)
    }
}


// MARK: - API Handling

extension ViewEmpNotesVC{
    private func getAllNotes(isFromBottom:Bool){
        if !isFromBottom {
            pageNumber = 1
        }
        let empID = ViewEmployeeDetailsVC.empData.data?.employee_number ?? ""
        let branchId = ViewEmployeeDetailsVC.empData.data?.branch_id ?? ""
        showLoadingActivity()
        APIController.shard.getAllNotes(pageNumber: "\(pageNumber)", empId: empID, branchId: branchId, searchKey: searchTextField.text!, searchStatus: selectedFilterIndex) { data in
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
                }
                self.tableView.reloadData()
            }
        }
    }
    
    private func deleteNote(id:String,indexPath:IndexPath){
        let empID = ViewEmployeeDetailsVC.empData.data?.employee_number ?? ""
        let branchId = ViewEmployeeDetailsVC.empData.data?.branch_id ?? ""
        showLoadingActivity()
        APIController.shard.deleteNote(key_id: id, branchId: branchId, empId: empID) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                var alertVC:UIAlertController!
                if let status = data.status,status{
                    alertVC = UIAlertController(title: "Success".localized(), message: data.msg, preferredStyle: .alert)
                    self.data.remove(at: indexPath.row)
                    self.tableView.reloadData()
                }else{
                    alertVC = UIAlertController(title: "error".localized(), message: data.error, preferredStyle: .alert)
                }
                alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel))
                self.present(alertVC, animated: true)
            }
        }
    }
    
}


