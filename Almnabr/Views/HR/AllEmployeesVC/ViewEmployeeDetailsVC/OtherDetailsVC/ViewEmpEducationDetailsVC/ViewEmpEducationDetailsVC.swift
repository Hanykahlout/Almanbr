//
//  ViewEmpEducationDetailsVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 12/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ViewEmpEducationDetailsVC: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var membershipNumberLabel: UILabel!
    @IBOutlet weak var graduationYearLabel: UILabel!
    @IBOutlet weak var graduationLabel: UILabel!
    @IBOutlet weak var expiryDateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var attachmentPreviewView: UIView!
    private var pageNumber = 1
    private var totalPages = 1
    private var data = [EducationRecord]()
    private var filePath = ""
    private let graduationData = ["SL":"Below SSLC","SS":"SSLC","HS":"HSC","DP":"Diploma".localized(),"UG":"Bachelor Degree".localized(),"PG":"Master Degree".localized(),"DC":"Doctorate".localized()]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }

    private func initlization(){
        setUpTableView()
        searchTextField.addTarget(self, action: #selector(searchAction(textField:)), for: .editingChanged)
        addObserver()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBarTitle(navigationTitle: "Education Details")
        navigationController?.setNavigationBarHidden(false, animated: true)
        getAllEducationDetails(isFromBottom: false)
        setUpAttachmentPreview()
        setEduData()
    }
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    
    private func setUpAttachmentPreview(){
        let filePath = ViewEmployeeDetailsVC.empData.attachments?.en0001
        if let filePath = filePath {
            self.filePath = filePath
            attachmentPreviewView.isHidden = false
        }else{
            attachmentPreviewView.isHidden = true
        }
    }
    
    
    private func setEduData(){
        membershipNumberLabel.text = ViewEmployeeDetailsVC.empData.data?.membership_number ?? "-----"
        graduationYearLabel.text = ViewEmployeeDetailsVC.empData.data?.primary_graduation_year ?? "-----"
        graduationLabel.text = graduationData[ViewEmployeeDetailsVC.empData.data?.primary_education_level ?? ""] ?? "-----"
        expiryDateLabel.text = ViewEmployeeDetailsVC.empData.data?.passport_expiry_date_english ?? "-----"
    }
    
    private func addObserver(){
        NotificationCenter.default.addObserver(forName: .init("LoadingEducation"), object: nil, queue: .main) { notify in
            self.getAllEducationDetails(isFromBottom: false)
        }
        NotificationCenter.default.addObserver(forName: .init("SetUpAttachReviewEN"), object: nil, queue: .main) { notify in
            self.setUpAttachmentPreview()
        }
    }
    
    @objc private func searchAction(textField:UITextField){
        getAllEducationDetails(isFromBottom: false)
    }
    
    
    @IBAction func addAction(_ sender: Any) {
        goToAddVC(isView: false, data: nil)
    }
    
    
    @IBAction func uploadAction(_ sender: Any) {
        let vc = AddAttachmentViewController()
        vc.attachmentType = "EN0001"
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


extension ViewEmpEducationDetailsVC:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "EducationDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "EducationDetailsTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EducationDetailsTableViewCell", for: indexPath) as! EducationDetailsTableViewCell
        cell.delegate = self
        cell.setData(data: data[indexPath.row],indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1{
            if pageNumber < totalPages{
                pageNumber += 1
                getAllEducationDetails(isFromBottom: true)
            }
        }
    }
}

// MARK: - Table View Cell Delegate

extension ViewEmpEducationDetailsVC:EducationDetailsCellDelegate{
    func deleteAction(id:String,indexPath: IndexPath) {
        deleteEducation(keyId: id,indexPath: indexPath)
    }
    
    func updateAction(data:EducationRecord) {
        goToAddVC(isView: false, data: data)
    }
    
    func viewAction(data:EducationRecord) {
        goToAddVC(isView: true, data: data)
    }
    
    private func goToAddVC(isView:Bool,data:EducationRecord?){
        let vc = AddEmpEduDetailsViewController()
        vc.data = data
        vc.isView = isView
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


// MARK: - API Handling
extension ViewEmpEducationDetailsVC{
    private func getAllEducationDetails(isFromBottom:Bool){
        if !isFromBottom{
            pageNumber = 1
        }
        showLoadingActivity()
        APIController.shard.getAllEducationDetails(pageNumber: "\(pageNumber)", searchKey: searchTextField.text!, branch_id: ViewEmployeeDetailsVC.empData.data?.branch_id ?? "", id: ViewEmployeeDetailsVC.empData.data?.employee_number ?? "", employee_id_number: ViewEmployeeDetailsVC.empData.data?.employee_id_number ?? "") { data in
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
    
    
    private func deleteEducation(keyId:String,indexPath:IndexPath){
        let alertVC = UIAlertController(title: "Confirmation !!!".localized(), message: "Are you sure !?".localized(), preferredStyle: .alert)
        alertVC.addAction(.init(title: "Yes".localized(), style: .default, handler: { action in
            let empId  = ViewEmployeeDetailsVC.empData.data?.employee_number ?? ""
            let branchId = ViewEmployeeDetailsVC.empData.data?.branch_id ?? ""
            self.showLoadingActivity()
            APIController.shard.deleteEmpEducation(key_id: keyId,branchId: branchId, empId: empId) { data in
                self.hideLoadingActivity()
                DispatchQueue.main.async{
                    var alertVC:UIAlertController!
                    if let status = data.status,status{
                        self.data.remove(at: indexPath.row)
                        self.tableView.reloadData()
                        alertVC = UIAlertController(title: "Success".localized(), message: data.msg, preferredStyle: .alert)
                    }else{
                        alertVC = UIAlertController(title: "error".localized(), message: data.error, preferredStyle: .alert)
                    }
                    alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel, handler: nil))
                    self.present(alertVC, animated: true)
                }
            }
        }))
        alertVC.addAction(.init(title: "No".localized(), style: .default, handler: nil))
        present(alertVC, animated: true)
    }
    
}

