//
//  CommunicationListsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 22/12/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
import DropDown
class CommunicationListsViewController: UIViewController {
    
    @IBOutlet weak var headerView: HeaderView!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchByModulesTextField: UITextField!
    @IBOutlet weak var searchByFormTextField: UITextField!
    @IBOutlet weak var searchByBranchTextField: UITextField!
    @IBOutlet weak var searchTypeTextField: UITextField!
    
    @IBOutlet weak var searchByModulesArrow: UIImageView!
    @IBOutlet weak var searchByFromArrow: UIImageView!
    @IBOutlet weak var searchByBranchesArrow: UIImageView!
    @IBOutlet weak var searchTypeArrow: UIImageView!
    @IBOutlet weak var emptyDataImageView: UIImageView!
    
    
    @IBOutlet weak var tableView: UITableView!
    private var pageNumber = 1
    private var totalPages = 1
    
    private var data = [CommunicationList]()
    private var modules = [SearchBranchRecords]()
    private var forms = [SearchBranchRecords]()
    private var branches = [SearchBranchRecords]()
    private var types = [SearchBranchRecords]()
    
    private var modulesDropDown = DropDown()
    private var formsDropDown = DropDown()
    private var branchesDropDown = DropDown()
    private var typesDropDown = DropDown()
    
    private var modulesSelectedIndex:Int?
    private var formsSelectedIndex:Int?
    private var branchesSelectedIndex:Int?
    private var typesSelectedIndex:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initailization()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCommunicationList(isFromBottom: false)
        getSearchFilterKeys()
    }
    
    private func initailization(){
        headerView.btnAction = menu_select
        setUpTableView()
        setUpDropDownLists()
        searchTextField.addTarget(self, action: #selector(searchAction), for: .editingChanged)
    }
    
    private func setUpDropDownLists(){
        
        // Modules Drop Down
        modulesDropDown.anchorView = searchByModulesTextField
        modulesDropDown.bottomOffset = CGPoint(x: 0 , y:(modulesDropDown.anchorView?.plainView.bounds.height)!)
        modulesDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.searchByModulesArrow.transform = .init(rotationAngle: 0)
            if index == 0 {
                modulesSelectedIndex = nil
                self.searchByModulesTextField.text = ""
            }else{
                modulesSelectedIndex = index - 1
                self.searchByModulesTextField.text = item
            }
            self.getCommunicationList(isFromBottom: false)
        }
        modulesDropDown.cancelAction = { [unowned self] in
            self.searchByModulesArrow.transform = .init(rotationAngle: 0)
        }
        searchByModulesTextField.addTapGesture {
            self.searchByModulesArrow.transform = .init(rotationAngle: .pi)
            self.modulesDropDown.show()
        }
        
        
        // Branches Drop Down
        branchesDropDown.anchorView = searchByBranchTextField
        branchesDropDown.bottomOffset = CGPoint(x: 0 , y:(branchesDropDown.anchorView?.plainView.bounds.height)!)
        branchesDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.searchByBranchesArrow.transform = .init(rotationAngle: 0)
            if index == 0 {
                branchesSelectedIndex = nil
                self.searchByBranchTextField.text = ""
            }else{
                branchesSelectedIndex = index - 1
                self.searchByBranchTextField.text = item
            }
            self.getCommunicationList(isFromBottom: false)
        }
        branchesDropDown.cancelAction = { [unowned self] in
            self.searchByBranchesArrow.transform = .init(rotationAngle: 0)
        }
        searchByBranchTextField.addTapGesture {
            self.searchByBranchesArrow.transform = .init(rotationAngle: .pi)
            self.branchesDropDown.show()
        }
        
        
        // Forms Drop Down
        formsDropDown.anchorView = searchByFormTextField
        formsDropDown.bottomOffset = CGPoint(x: 0 , y:(formsDropDown.anchorView?.plainView.bounds.height)!)
        formsDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.searchByFromArrow.transform = .init(rotationAngle: 0)
            if index == 0 {
                formsSelectedIndex = nil
                self.searchByFormTextField  .text = ""
            }else{
                formsSelectedIndex = index - 1
                self.searchByFormTextField.text = item
            }
            
            self.getCommunicationList(isFromBottom: false)
        }
        formsDropDown.cancelAction = { [unowned self] in
            self.searchByFromArrow.transform = .init(rotationAngle: 0)
        }
        searchByFormTextField.addTapGesture {
            self.searchByFromArrow.transform = .init(rotationAngle: .pi)
            self.formsDropDown.show()
        }
        
        
        // Types Drop Down
        typesDropDown.anchorView = searchTypeTextField
        typesDropDown.bottomOffset = CGPoint(x: 0 , y:(typesDropDown.anchorView?.plainView.bounds.height)!)
        typesDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.searchTypeArrow.transform = .init(rotationAngle: 0)
            self.searchTypeTextField.text = item
            self.getCommunicationList(isFromBottom: false)
        }
        typesDropDown.cancelAction = { [unowned self] in
            self.searchTypeArrow.transform = .init(rotationAngle: 0)
        }
        searchTypeTextField.addTapGesture {
            self.searchTypeArrow.transform = .init(rotationAngle: .pi)
            self.typesDropDown.show()
        }
        
    }
    
    
    
    private func menu_select(){
        let language =  L102Language.currentAppleLanguage()
        if language == "ar"{
            panel?.openRight(animated: true)
        }else{
            panel?.openLeft(animated: true)
        }
    }
    
    @objc private func searchAction(){
        getCommunicationList(isFromBottom: false)
    }
    
    
}

// MARK: - Table Veiw Delegate and Data Source
extension CommunicationListsViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "CommuncationListTableViewCell", bundle: nil), forCellReuseIdentifier: "CommuncationListTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommuncationListTableViewCell", for: indexPath) as! CommuncationListTableViewCell
        cell.setData(data:data[indexPath.row])
        cell.pdfAction = {
            self.showPdf(path: self.data[indexPath.row].file_path ?? "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1{
            if pageNumber < totalPages{
                pageNumber += 1
                getCommunicationList(isFromBottom: true)
            }
        }
    }
    
}

// MARK: - API Handling
extension CommunicationListsViewController{
    
    private func getCommunicationList(isFromBottom:Bool){
        if !isFromBottom{
            pageNumber = 1
        }
        let searchText = searchTextField.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let moduleKey = modulesSelectedIndex == nil ? "" : modules[modulesSelectedIndex!].value ?? ""
        let formKey = formsSelectedIndex == nil ? "" : forms[formsSelectedIndex!].value ?? ""
        let branchKey = branchesSelectedIndex == nil ? "" : branches[branchesSelectedIndex!].value ?? ""
        let typeKey = typesSelectedIndex == nil ? "" : types[typesSelectedIndex!].value ?? ""
        
        APIController.shard.getCommunicationList(pageNumber: String(pageNumber),
                                                 searchText: searchText,
                                                 moduleKey: moduleKey ,
                                                 transactionKey: formKey,
                                                 branchKey: branchKey,
                                                 typeKey: typeKey) { data in
            DispatchQueue.main.async {
                if let status = data.status,status{
                    if isFromBottom{
                        self.data.append(contentsOf: data.list ?? [])
                    }else{
                        self.data = data.list ?? []
                    }
                    self.totalPages = data.page?.total_pages ?? 1
                }else{
                    self.data.removeAll()
                }
                self.emptyDataImageView.isHidden = !self.data.isEmpty
                self.tableView.reloadData()
            }
        }
    }
    
    
    private func showPdf(path:String){
        showLoadingActivity()
        APIController.shard.getImage(url: path) { data in
            self.hideLoadingActivity()
            if let status = data.status,status{
                let vc = WebViewViewController()
                vc.data = data
                self.present(UINavigationController(rootViewController: vc), animated: true)
            }else{
                SCLAlertView().showError("error".localized(), subTitle: data.error ?? "There is an unknow error")
            }
        }
    }
    
    
    private func getSearchFilterKeys(){
        getModules()
        getForms()
        getBranches()
        getTypes()
    }
    
    
    private func getModules(){
        showLoadingActivity()
        APIController.shard.getCommunctionSearchKeys(urlKey: "sml") { data in
            self.hideLoadingActivity()
            DispatchQueue.main.async {
                if let status = data.status,status{
                    let data = data.records ?? []
                    self.modules = data
                    self.modulesDropDown.dataSource = ["All"]
                    self.modulesDropDown.dataSource.append(contentsOf: data.map{$0.label ?? "----"})
                }
            }
        }
    }
    
    
    private func getForms(){
        showLoadingActivity()
        APIController.shard.getCommunctionSearchKeys(urlKey: "sfl") { data in
            self.hideLoadingActivity()
            DispatchQueue.main.async {
                if let status = data.status,status{
                    let data = data.records ?? []
                    self.forms = data
                    self.formsDropDown.dataSource = ["All"]
                    self.formsDropDown.dataSource.append(contentsOf: data.map{$0.label ?? "----"})
                }
            }
        }
    }
    
    
    private func getBranches(){
        showLoadingActivity()
        APIController.shard.getCommunctionSearchKeys(urlKey: "sbl") { data in
            self.hideLoadingActivity()
            DispatchQueue.main.async {
                if let status = data.status,status{
                    let data = data.records ?? []
                    self.branches = data
                    self.branchesDropDown.dataSource = ["All"]
                    self.branchesDropDown.dataSource.append(contentsOf: data.map{$0.label ?? "----"})
                }
            }
        }
    }
    
    
    private func getTypes(){
        showLoadingActivity()
        APIController.shard.getCommunctionSearchKeys(urlKey: "sctl") { data in
            self.hideLoadingActivity()
            DispatchQueue.main.async {
                if let status = data.status,status{
                    let data = data.records ?? []
                    self.types = data
                    self.typesDropDown.dataSource = ["All"]
                    self.typesDropDown.dataSource.append(contentsOf: data.map{$0.label ?? "----"})
                }
            }
        }
    }
    
    
}
