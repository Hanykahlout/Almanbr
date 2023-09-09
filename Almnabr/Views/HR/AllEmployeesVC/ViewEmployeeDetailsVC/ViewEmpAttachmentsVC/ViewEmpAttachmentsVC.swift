//
//  ViewEmpAttachmentsVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 12/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
class ViewEmpAttachmentsVC: UIViewController {
    
    @IBOutlet weak var docTypeView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var docTypeArrow: UIImageView!
    @IBOutlet weak var docTypeLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    private var pageNumber = 1
    private var totalPages = 1
    private var data = [AttachmentRecords]()
    private var attachmentTypes = [AttachmentTypeRecords]()
    private var selectedAttachmentTypes = [AttachmentTypeRecords]()
    private var dropDown = DropDown()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }
    
    private func initlization(){
        setUpTableView()
        setUpCollectionView()
        getAttachmentTypes()
        setUpDropDownList()
        searchTextField.addTarget(self, action: #selector(searchAction), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllAttachments(isFromBottom: false)
    }

    private func setUpDropDownList(){
        dropDown.anchorView = docTypeView
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.docTypeArrow.transform = .init(rotationAngle: 0)
            docTypeLabel.isHidden = true
            let selectedItem = self.attachmentTypes[index]
            if !self.selectedAttachmentTypes.contains(where: {$0.key_code == selectedItem.key_code}){
                self.selectedAttachmentTypes.append(selectedItem)
                collectionView.reloadData()
                self.getAllAttachments(isFromBottom: false)
            }
            
        }
        
        dropDown.cancelAction = { [unowned self] in
            self.docTypeArrow.transform = .init(rotationAngle: 0)
        }
        docTypeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(docTypeViewAction)))
    }
    
    @objc private func docTypeViewAction(){
        
        dropDown.show()
    }
    
    
    @objc private func searchAction(){
        docTypeArrow.transform = .init(rotationAngle: .pi)
        getAllAttachments(isFromBottom: true)
    }
    
    
    @IBAction func uploadAction(_ sender: Any) {
        let vc = AddAttachmentViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


// MARK: - Set Up Table View
extension ViewEmpAttachmentsVC:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "AttachmentTableViewCell", bundle: nil), forCellReuseIdentifier: "AttachmentTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttachmentTableViewCell", for: indexPath) as! AttachmentTableViewCell
        cell.delegate = self
        cell.setData(data:data[indexPath.row],indexPath:indexPath)
        return cell
    }

    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1{
            if pageNumber < totalPages{
                pageNumber += 1
                getAllAttachments(isFromBottom: true)
            }
        }
    }
}

// MARK: - Table View Cell Delegate
extension ViewEmpAttachmentsVC:AttachmentCellDelegate{
    func deleteAction(data: AttachmentRecords, indexPath: IndexPath) {
        deleteAttachment(data: data, indexPath: indexPath)
    }
    
    func editAattchment(data: AttachmentRecords) {
        let vc = AddAttachmentViewController()
        vc.attachmentData = data
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func previewAttachmentAction(data: AttachmentRecords) {
        APIController.shard.getAttachmentPreview(filePath:data.file_path ?? "") { data in
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

// MARK: - Set Up Collection View

extension ViewEmpAttachmentsVC:UICollectionViewDelegate,UICollectionViewDataSource{
    private func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(.init(nibName: "UsersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UsersCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedAttachmentTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsersCollectionViewCell", for: indexPath) as! UsersCollectionViewCell
        cell.delegate = self
        cell.setData(data: selectedAttachmentTypes[indexPath.row], indexPath: indexPath)
        return cell
    }

}

extension ViewEmpAttachmentsVC:UsersCollectionViewCellDelegate{
    func removeAction(indexPath: IndexPath) {
        selectedAttachmentTypes.remove(at: indexPath.row)
        collectionView.reloadData()
        if selectedAttachmentTypes.isEmpty{
            docTypeLabel.isHidden = false
        }
        self.getAllAttachments(isFromBottom: false)
    }

}

// MARK: - API Handling

extension ViewEmpAttachmentsVC{
    func getAllAttachments(isFromBottom:Bool){
        let empId = ViewEmployeeDetailsVC.empData.data?.employee_number ?? ""
        let branchId = ViewEmployeeDetailsVC.empData.data?.branch_id ?? ""
        if !isFromBottom{
            pageNumber = 1
        }
        var attachmentType = ""
        for index in 0..<selectedAttachmentTypes.count{
            attachmentType.append("\(index != 0 ? "," : "")\(selectedAttachmentTypes[index].attach_type_id ?? "")")
        }
        showLoadingActivity()
        APIController.shard.getAllAttachments(pageNumber: "\(pageNumber)", empId: empId, branchId: branchId, searchKey: searchTextField.text!, attachmentType: attachmentType) { data in
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
    
    
    func deleteAttachment(data attachmentData: AttachmentRecords,indexPath:IndexPath){
        let empId = ViewEmployeeDetailsVC.empData.data?.employee_number ?? ""
        let branchId = ViewEmployeeDetailsVC.empData.data?.branch_id ?? ""
        showLoadingActivity()
        APIController.shard.deleteAttachment(key_id: attachmentData.file_records_id ?? "", branchId: branchId, empId: empId) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                var alertVC:UIAlertController!
                if let status = data.status,status{
                    alertVC = UIAlertController(title: "Success".localized(), message: data.msg, preferredStyle: .alert)
                    if attachmentData.key_code == "EN0001"{
                        ViewEmployeeDetailsVC.empData.attachments?.en0001 = nil
                        ViewEmployeeDetailsVC.empData.attachments?.en0001_d = nil
                    }else if attachmentData.key_code == "IR0001"{
                        ViewEmployeeDetailsVC.empData.attachments?.ir0001 = nil
                        ViewEmployeeDetailsVC.empData.attachments?.ir0001_d = nil
                    }
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
    

    func getAttachmentTypes(){
        APIController.shard.getAttachmentTypes { data in
            if let status = data.status,status{
                self.attachmentTypes = data.records ?? []
                self.dropDown.dataSource = (data.records ?? []).map{$0.title ?? ""}
            }
        }
    }
    

}

