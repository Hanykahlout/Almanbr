//
//  ViewEmpInsuranceDetailsVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 12/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
class ViewEmpInsuranceDetailsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var insuranceNumberLabel: UILabel!
    @IBOutlet weak var insuranceDateLabel: UILabel!
    @IBOutlet weak var insuranceTypeClassLabel: UILabel!
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterArrow: UIImageView!
    @IBOutlet weak var filterLabel: UILabel!
    
    @IBOutlet weak var attachmentPreviewView: UIView!
    
    @IBOutlet weak var searchTextField: UITextField!
    private var data = [InsuranceRecords]()
    private var pageNumber = 1
    private var totolPages = 1
    private var selectedSearchStatus:Int?
    
    private var dropDown = DropDown()
    private var filePath = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        
    }
    
    

    
    private func initlization(){
        setInsuranceData()
        setUpTableView()
        setUpDropDown()
        
        addObserver()
        filterView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(filterViewAction)))
        searchTextField.addTarget(self, action: #selector(searchAction(textField:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBarTitle(navigationTitle: "Insurance Details")
        navigationController?.setNavigationBarHidden(false, animated: true)
        getInsuranceData(isFromBottom: false)
        setUpAttachmentView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setUpAttachmentView(){
        let filePath = ViewEmployeeDetailsVC.empData.attachments?.ir0001
        if let filePath = filePath{
            self.filePath = filePath
            attachmentPreviewView.isHidden = false
        }else{
            attachmentPreviewView.isHidden = true
        }
    }
    
    private func addObserver(){
        NotificationCenter.default.addObserver(forName: .init(rawValue: "ReloadInsuranceDetails"), object: nil, queue: .main) { notify in
            self.getInsuranceData(isFromBottom: false)
        }
        NotificationCenter.default.addObserver(forName: .init(rawValue: "SetUpAttachReviewIR"), object: nil, queue: .main) { notify in
            self.setUpAttachmentView()
        }
    }
    
    
    private func setUpDropDown(){
        dropDown.anchorView = filterView
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        dropDown.dataSource = ["All".localized(),"Spouse".localized(),"Son".localized(),"Daugther".localized(),"Others".localized()]
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.filterArrow.transform = .init(rotationAngle: 0)
            self.filterLabel.text = item
            self.selectedSearchStatus = item == "All".localized() ? nil : index
            self.getInsuranceData(isFromBottom: false)
        }
        
        dropDown.cancelAction = { [unowned self] in
            self.filterArrow.transform = .init(rotationAngle: 0)
        }
    }
    
    
    
    private func setInsuranceData(){
        insuranceTypeClassLabel.text = ViewEmployeeDetailsVC.empData.data?.insurance_type_class ?? ""
        insuranceNumberLabel.text = ViewEmployeeDetailsVC.empData.data?.insurance_number ?? ""
        insuranceDateLabel.text = ViewEmployeeDetailsVC.empData.data?.insurance_date ?? ""
    }
    
    
    @objc private func searchAction(textField:UITextField){
        self.getInsuranceData(isFromBottom: false)
    }
    
    
    @objc private func filterViewAction(){
        self.filterArrow.transform = .init(rotationAngle: .pi)
        dropDown.show()
    }
    
    
    @IBAction func addAction(_ sender: Any) {
        let vc = AddInsuranceViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func uploadAction(_ sender: Any) {
        let vc = AddAttachmentViewController()
        vc.attachmentType = "IR0001"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func attachmentPreviewAction(_ sender: Any) {
        APIController.shard.getAttachmentPreview(filePath:filePath) { data in
            DispatchQueue.main.async {
                if let status = data.status , status{
                    let vc = WebViewViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    vc.data = data
                    self.navigationController?.present(nav, animated: true)
                }
            }
        }
    }
    
}


extension ViewEmpInsuranceDetailsVC:UITableViewDelegate, UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "InsuranceDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "InsuranceDetailsTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InsuranceDetailsTableViewCell", for: indexPath) as! InsuranceDetailsTableViewCell
        cell.delegate = self
        cell.setData(data:data[indexPath.row],indexPath:indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1{
            if pageNumber < totolPages{
                pageNumber += 1
                getInsuranceData(isFromBottom: true)
            }
        }
    }
    
}

// MARK: - Table View Cell Delegate
extension ViewEmpInsuranceDetailsVC:InsuranceDetailsCellDelegate{
    func deleteAction(id: String, indexPath: IndexPath) {
        self.deleteInsurant(key_id: id,indexPath:indexPath)
    }
    
    func updateAction(data: InsuranceRecords) {
        goToUpdateVC(data:data,isView: false)
    }
    
    func viewAction(data: InsuranceRecords) {
        goToUpdateVC(data:data,isView: true)
    }
    
    private func goToUpdateVC(data: InsuranceRecords,isView:Bool){
        let vc = UpdateInsuranceViewController()
        vc.data = data
        vc.isView = isView
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - API Handling


extension ViewEmpInsuranceDetailsVC{
    
    private func getInsuranceData(isFromBottom:Bool){
        var selectedStatusIndex = ""
        if let index = selectedSearchStatus{
            selectedStatusIndex = "\(index)"
        }
        if !isFromBottom{
            pageNumber = 1
        }
        
        let empId = ViewEmployeeDetailsVC.empData.data?.employee_number ?? ""
        let empIdNumber = ViewEmployeeDetailsVC.empData.data?.employee_id_number ?? ""
        let branchId = ViewEmployeeDetailsVC.empData.data?.branch_id ?? ""
        showLoadingActivity()
        APIController.shard.getInsuranceData(pageNumber: "\(pageNumber)", empId: empId, empIdNumber: empIdNumber, branchId: branchId, searchKey: searchTextField.text!, searchStatus: selectedStatusIndex) { data in
            DispatchQueue.main.async{
                self.hideLoadingActivity()
                if let status = data.status , status{
                    if isFromBottom{
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
    
    private func deleteInsurant(key_id:String,indexPath:IndexPath){
        let empId = ViewEmployeeDetailsVC.empData.data?.employee_number ?? ""
        let branchId = ViewEmployeeDetailsVC.empData.data?.branch_id ?? ""
        showLoadingActivity()
        APIController.shard.deleteInsuranceDetails(key_id: key_id, branchId: branchId, empId: empId) { data in
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
                alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel, handler: nil))
                self.present(alertVC, animated: true)
            }
        }
    }
    
}
