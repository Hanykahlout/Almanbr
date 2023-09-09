//
//  DocumentsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 16/08/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
import DropDown

class DocumentsViewController: UIViewController {
    

    
    @IBOutlet weak var branchCollectionView: UICollectionView!
    @IBOutlet weak var header: HeaderView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var branchTypeLabel: UILabel!
    @IBOutlet weak var branchTypeView: UIView!
    @IBOutlet weak var docNumberTextField: UITextField!
    @IBOutlet weak var branchArrow: UIImageView!
    
    private var data = [DocumentData]()
    private var currentPage = 1
    private var totalPages:Int?
    private var document_branch = ""
    private var selectedBranchs = [SearchBranchRecords]()
    private var fileData:Data?
    
    private var branchs = [SearchBranchRecords]()
    private var docTypesDropDown = DropDown()
    private var branchTypesDropDown = DropDown()

    var docNumber = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    
    private func initlization(){
        handleHeaderView()
        setUpTableView()
        setUpDropDownLists()
        setUpCollection()
        getAllBranchs()
        searchTextField.delegate = self
        docNumberTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDocuments(isFromBottom: false)
    }
    
    
    
    private func setUpDropDownLists(){
        
        branchTypesDropDown.anchorView = branchTypeView

        branchTypesDropDown.bottomOffset = CGPoint(x: 0, y:(branchTypesDropDown.anchorView?.plainView.bounds.height)!)

        branchTypesDropDown.selectionAction = { [weak self] index , item in
            guard let self = self else { return }
            self.branchArrow.transform = .init(rotationAngle: .pi)
            if self.selectedBranchs.contains(where: {$0.value == self.branchs[index].value}) != true{
                self.selectedBranchs.insert(self.branchs[index], at: 0)
                self.branchTypeLabel.isHidden = true
                let indexPath = IndexPath(row: 0, section: 0)
                self.branchCollectionView.insertItems(at: [indexPath])
                self.branchCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                self.filterAction()
            }
        }
        
        branchTypesDropDown.cancelAction = {
            self.branchArrow.transform = .init(rotationAngle: 0)
        }
        
        branchTypeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(branchTypeTextFieldAction)))
        
    }
    
    private func handleHeaderView(){
        header.btnAction = {
            let language =  L102Language.currentAppleLanguage()
            if language == "ar"{
                self.panel?.openRight(animated: true)
            }else{
                self.panel?.openLeft(animated: true)
            }
        }
    }
    
    private func filterAction(){
        var branchs = ""
        for index in 0..<selectedBranchs.count{
            if index == 0{
                branchs.append(selectedBranchs[index].value ?? "-1")
            }else{
                branchs.append(",\(branchs.append(selectedBranchs[index].value ?? "-1"))")
            }
        }
        self.document_branch = branchs
        self.getDocuments(isFromBottom: false)
    }
    
    @objc private func branchTypeTextFieldAction(){
        branchTypesDropDown.show()
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
        getDocuments(isFromBottom: false)
    }
    
    
}

extension DocumentsViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "DocumentsTableViewCell", bundle: nil), forCellReuseIdentifier: "DocumentsTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentsTableViewCell", for: indexPath) as! DocumentsTableViewCell
        cell.setData(data:data[indexPath.row])
        cell.deleteDocAction = {
            let docId = self.data[indexPath.row].document_id ?? "-1"
            APIController.shard.deleteDocument(documentId: docId) { data in
                if let status = data.status,status{
                    self.data.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "Somthing went wrong!!")
                }
            }
        }
        
        cell.viewDocAction = {
            let vc = AddDocumentVC()
            vc.data = self.data[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.downloadDocAction = { [unowned self] filePath in
            self.getDoc(filePath: filePath)
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1{
            if let totalPages = totalPages , currentPage < totalPages{
                currentPage += 1
                getDocuments(isFromBottom: true)
            }
        }
    }
    
}

// MARK: - Set Up Collection View

extension DocumentsViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    private func setUpCollection(){
        
        branchCollectionView.delegate = self
        branchCollectionView.dataSource = self
        branchCollectionView.register(.init(nibName: "UsersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UsersCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedBranchs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsersCollectionViewCell", for: indexPath) as! UsersCollectionViewCell
        cell.setData(data: selectedBranchs[indexPath.row], indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    
}

// MARK: - Set Up Collection View Cell Delegate
extension DocumentsViewController:UsersCollectionViewCellDelegate{
    func removeAction(indexPath:IndexPath){
        selectedBranchs.remove(at: indexPath.row)
        if selectedBranchs.isEmpty{
            branchTypeLabel.isHidden = false
        }
        branchCollectionView.reloadData()
        filterAction()
    }
}


// MARK: - TextField Delegate
extension DocumentsViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        getDocuments(isFromBottom: false)
    }
    
}


// MARK: - API handling
extension DocumentsViewController{
    private func getDocuments(isFromBottom:Bool){
        if !isFromBottom {
            currentPage = 1
        }
        showLoadingActivity()
        APIController.shard.getDocuments(document_branch: document_branch, document_number: docNumberTextField.text!, searchText:searchTextField.text! , pageNumber: "\(currentPage)") { data in
            self.hideLoadingActivity()
            if let status = data.status,status{
                if isFromBottom{
                    self.data.append(contentsOf: data.data ?? [])
                }else{
                    self.data = data.data ?? []
                }
                
                self.totalPages = data.page?.total_pages
            }else{
                self.data.removeAll()
                SCLAlertView().showError("error".localized(), subTitle: data.error ?? "There is an unknow error.")
            }
            self.tableView.reloadData()
        }
    }
    
    private func getDoc(filePath:String){
        showLoadingActivity()
        APIController.shard.getImage(url: filePath) { [unowned self] data in
            self.hideLoadingActivity()
            if let status = data.status,status{
                let vc = WebViewViewController()
                vc.data = data
                let nav = UINavigationController(rootViewController: vc)
                self.navigationController?.present(nav, animated: true)
            }
        }
    }
    
    private func getAllBranchs(){
        APIController.shard.getFilterData2 { data in
            if let status = data.status,status{
                self.branchs = data.branches ?? []
                self.branchTypesDropDown.dataSource = data.branches?.map({$0.label ?? ""}) ?? []
            }
        }
    }
    
}


