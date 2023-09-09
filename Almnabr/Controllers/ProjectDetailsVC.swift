//
//  ProjectDetailsVC.swift
//  Almnabr
//
//  Created by MacBook on 11/10/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import DPLocalization
import FontAwesome_swift
import SCLAlertView
class ProjectDetailsVC: UIViewController {
    
    @IBOutlet weak var imgnodata: UIImageView!
    
    @IBOutlet weak var lblQuotations: UILabel!
    @IBOutlet weak var lblProjects: UILabel!
    
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var projectNameEnLabel: UILabel!
    @IBOutlet weak var projectNameArLabel: UILabel!
    @IBOutlet weak var customersLabel: UILabel!
    @IBOutlet weak var projectTypeLabel: UILabel!
    @IBOutlet weak var projectServicesLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var projectUsersLabel: UILabel!
    @IBOutlet weak var projectReviewersLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var onUpdatedLabel: UILabel!
    @IBOutlet weak var projectLocationLabel: UILabel!
    
    
    @IBOutlet weak var View_project: UIView!
    @IBOutlet weak var View_Quotation: UIView!
    @IBOutlet weak var SelectedView_project: UIView!
    @IBOutlet weak var SelectedView_Quotation: UIView!
    
    
    @IBOutlet weak var collectionServieces: UICollectionView!

    @IBOutlet weak var tableProjects: UITableView!
    
    
    var QuotationSearchKey:String = ""
    var ProjectSearchKey:String = ""
    var StrTitle:String = ""
    var StrSubMenue:String = ""
    var StrMenue:String = ""
    var projectId:String = ""
    var CustomerName:String = ""
    
    var pageNumber = 1
    var allItemDownloaded = false
    var IsPrpjectTable = true
    var MenuObj:MenuObj?
    var SubMenuObj:MenuObj?
    
    var add:Bool = false
    var Object:projectObj?
    
    
    
    var arr_Services:[ProjectDetilaService] = []
    var arr_ServicesLabel:[String] = []
    var arr_branch:[ModuleObj] = []
    var arr_branchLabel:[String] = []
    
    var cellWidths: [CGFloat] = [900]
    
    let fontStyle: FontAwesomeStyle = .solid
    let maincolor = "#1A3665".getUIColor()
    private var quotationsPageNumber = 1
    private var quotationsTotalPages = 1
    private var projectPageNumber = 1
    private var projectTotalPages = 1
    
    private var projectDesignPageNumber = 1
    private var projectDesignTotalPages = 1
    
    private var isSupervison = true
    
    private var arr_data:[QuotationRecord] = []
    private var arr_Projectdata:[ProjectServicesRecord] = []
    private var projectDesignData:[ProjectsDesignData] = []
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        configGUI()
        setupCollection()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBarTitle(navigationTitle: "Project Details")
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        clearData()
        get_Projects_Details()
        getQuotationsData(isFromBottom: false)
        getProjectsData(isFromBottom: false)
        getProjectsDesignData(isFromBottom: false)
    }
    
    
    func configNavigation() {
        _ = self.navigationController?.preferredStatusBarStyle
        self.view.backgroundColor = "FFFFFF".getUIColor()
        navigationController?.navigationBar.barTintColor = .red
        addNavigationBarTitle(navigationTitle: StrTitle)
    }
    
    
    func configGUI() {
        self.lblQuotations.text =  "txt_Quotations".localized()
        self.lblQuotations.font = .kufiRegularFont(ofSize: 15)
        //self.lblQuotations.textColor =  maincolor
        
        self.lblProjects.text =  "txt_Projects".localized()
        self.lblProjects.font = .kufiRegularFont(ofSize: 15)
        //self.lblProjects.textColor =  maincolor
        
        self.SelectedView_project.backgroundColor = maincolor
        self.SelectedView_Quotation.backgroundColor = maincolor
        
        self.SelectedView_Quotation.isHidden = true
        
    }
    
    func is_hide_Qutation(){
        
        if userObj?.is_admin == "1" || add == true {
            self.View_Quotation.isHidden = false
        }else{
            self.View_Quotation.isHidden = true
        }
    }
    
    func setupCollection(){
        
        collectionServieces.delegate = self
        collectionServieces.dataSource = self
        
        
        let nib = UINib(nibName: "SubProjectTVCell", bundle: nil)
        tableProjects.register(nib, forCellReuseIdentifier: "SubProjectTVCell")
        tableProjects.register(.init(nibName: "QuotationTableViewCell", bundle: nil), forCellReuseIdentifier: "QuotationTableViewCell")
        
    }
    
    private func clearData(){
        branchLabel.text = ""
        projectNameEnLabel.text = ""
        projectNameArLabel.text = ""
        customersLabel.text = ""
        projectTypeLabel.text = ""
        projectServicesLabel.text = ""
        writerLabel.text = ""
        projectUsersLabel.text = ""
        projectReviewersLabel.text = ""
        createdDateLabel.text = ""
        onUpdatedLabel.text = ""
        projectLocationLabel.text = ""
        arr_Services.removeAll()
        collectionServieces.reloadData()
    }
    
    
    @IBAction func btnProject_Click(_ sender: Any) {
        
        self.IsPrpjectTable = true
        self.tableProjects.reloadData()
        self.SelectedView_project.isHidden = false
        self.SelectedView_Quotation.isHidden = true
        
        UIView.transition(with: tableProjects, duration: 0.4,
                          options: .transitionFlipFromTop,
                          animations: {
            self.tableProjects.isHidden = false
        })
        
    }
    
    
    @IBAction func btnQuotation_Click(_ sender: Any) {
        self.IsPrpjectTable = false
        self.tableProjects.reloadData()
        self.SelectedView_project.isHidden = true
        self.SelectedView_Quotation.isHidden = false
        UIView.transition(with: tableProjects, duration: 0.4,
                          options: .transitionFlipFromTop,
                          animations: {
            self.tableProjects.isHidden = false
        })
    }

    
    @IBAction func btnAddQuotation_Click(_ sender: Any) {
        
    }
    
}

extension ProjectDetailsVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if IsPrpjectTable{
            if isSupervison{
                return arr_Projectdata.count
            }else{
                return projectDesignData.count
            }
        }else{
            return arr_data.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if IsPrpjectTable{
            if isSupervison{
                let cell = tableView.dequeueReusableCell(withIdentifier: "SubProjectTVCell", for: indexPath) as! SubProjectTVCell
                cell.setData(data: arr_Projectdata[indexPath.row])
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "SubProjectTVCell", for: indexPath) as! SubProjectTVCell
                cell.setData(data: projectDesignData[indexPath.row])
                return cell
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuotationTableViewCell") as! QuotationTableViewCell
        cell.setData(data:arr_data[indexPath.row])
        cell.didClickOnFile = {
            self.showFile(url: self.arr_data[indexPath.row].projects_quotation_pdf_file ?? "")
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if IsPrpjectTable == true{
            if isSupervison{
                let obj = arr_Projectdata[indexPath.item]
                projects_profile_id = obj.projects_profile_id ?? ""
                projects_work_area_id = obj.projects_work_area_id ?? ""
                projects_supervision_id = obj.projects_supervision_id ?? ""
                let vc:SupervisionOperationVC = AppDelegate.mainSB.instanceVC()
                vc.projects_work_area_id = obj.projects_work_area_id ?? ""
                vc.Object = Object
                vc.StrSubMenue =  self.StrSubMenue
                vc.StrMenue = self.StrMenue
                vc.MenuObj = self.MenuObj
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if IsPrpjectTable {
            if isSupervison{
                if indexPath.row == arr_Projectdata.count - 1 {
                    if projectPageNumber < projectTotalPages{
                        projectPageNumber += 1
                        getProjectsData(isFromBottom: true)
                    }
                }
            }else{
                if indexPath.row == projectDesignData.count - 1 {
                    if projectDesignPageNumber < projectDesignTotalPages{
                        projectDesignPageNumber += 1
                        getProjectsDesignData(isFromBottom: true)
                    }
                }
            }
        }else{
            if indexPath.row == arr_data.count - 1 {
                if quotationsPageNumber < quotationsTotalPages{
                    quotationsPageNumber += 1
                    getQuotationsData(isFromBottom: true)
                }
            }
        }
    }
    
    
}



extension ProjectDetailsVC: UICollectionViewDataSource ,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr_Services.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCell", for: indexPath) as! TestCell
        
        let item = arr_Services[indexPath.item]
        cell.obj_ModuleObj = item
        cell.lbl_Title.font = .kufiRegularFont(ofSize: 13)
        cell.lbl_Title.textColor = HelperClassSwift.bcolor.getUIColor()
        
        cell.view_img.setBorderGrayWidth(3)
        cell.view_img.setRounded()
        
        cell.img.image = UIImage.fontAwesomeIcon(name: .codeBranch, style: self.fontStyle, textColor: .white, size: CGSize(width: 40, height: 40))
        
        if item.isSelected {
            cell.view_img.backgroundColor = HelperClassSwift.acolor.getUIColor()
        }else{
            cell.view_img.backgroundColor = HelperClassSwift.bcolor.getUIColor()
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<arr_Services.count{
            arr_Services[i].isSelected = indexPath.row == i
            if indexPath.row == i{
                arr_data.removeAll()
                arr_Projectdata.removeAll()
                projectDesignData.removeAll()
                
                isSupervison = arr_Services[i].projects_services_code == "S"
                if isSupervison {
                    getProjectsData(isFromBottom: false)
                    getQuotationsData(isFromBottom: false)
                }else{
                    getProjectsDesignData(isFromBottom: false)
                }
             }
        }
        collectionServieces.reloadData()
    }
    
}


extension ProjectDetailsVC:UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if IsPrpjectTable == true{
            self.ProjectSearchKey = searchBar.text!
        }else{
            self.QuotationSearchKey = searchBar.text!
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if IsPrpjectTable == true{
            self.ProjectSearchKey = searchBar.text!
        }else{
            self.QuotationSearchKey = searchBar.text!
        }
        searchBar.resignFirstResponder()
    }
    
}
// MARK: - API Copntroller
extension ProjectDetailsVC{
    
    private func get_Projects_Details(){
        showLoadingActivity()
        APIController.shard.getProjectDetailsData(projectId: Object!.projects_profile_id) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    
                    self.branchLabel.text = data.data?.branch_name ?? "----"
                    self.projectNameEnLabel.text = data.data?.projects_profile_name_en ?? "----"
                    self.projectNameArLabel.text = data.data?.projects_profile_name_ar ?? "----"
                    self.customersLabel.text = data.data?.customer_name ?? "----"
                    self.projectTypeLabel.text = data.data?.customer_type ?? "----"
                    self.add = data.add ?? false
                    if let service_user_data = data.service_user_data, let services = service_user_data.services, let users = service_user_data.users{
                        for index in 0..<services.count{
                            var service = services[index]
                            service.isSelected = index == 0
                            self.arr_Services.append(service)
                            self.projectServicesLabel.text! += "\(index+1)- \(service.label ?? "--"), "
                        }
                        self.collectionServieces.reloadData()
                        for index in 0..<users.count{
                            let user = users[index]
                            self.projectUsersLabel.text! += "\(index+1)- \(user.label ?? "--"), "
                        }
                    }
                    
                    self.writerLabel.text = data.data?.writer ?? "----"
                    self.projectReviewersLabel.text = "----"
                    self.createdDateLabel.text = data.data?.projects_profile_created_datetime ?? "----"
                    self.onUpdatedLabel.text = data.data?.projects_profile_updated_datetime ?? "----"
                    self.projectLocationLabel.text = data.data?.projects_profile_location ?? "----"
                }
            }
        }
    }
    
    
    private func getQuotationsData(isFromBottom:Bool){
        if !isFromBottom{
            quotationsPageNumber = 1
        }
        showLoadingActivity()
        APIController.shard.getQuotationsSupervisionData(projectId: Object!.projects_profile_id, pageNumber: String(quotationsPageNumber), searchKey: QuotationSearchKey) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status, status{
                    if isFromBottom{
                        self.arr_data.append(contentsOf: data.records ?? [])
                    }else{
                        self.arr_data = data.records ?? []
                    }
                }else{
                    if !isFromBottom{
                        self.arr_data.removeAll()
                    }
                }
                self.imgnodata.isHidden = !self.arr_data.isEmpty
                self.quotationsTotalPages = data.page?.total_pages ?? 1
                self.imgnodata.isHidden = !self.arr_data.isEmpty
                self.tableProjects.reloadData()
            }
        }
    }
    
    
    private func getProjectsData(isFromBottom:Bool){
        if !isFromBottom{
            projectPageNumber = 1
        }
        showLoadingActivity()
        APIController.shard.getProjectsSupervisionData(projectId: Object!.projects_profile_id, pageNumber: String(projectPageNumber), searchKey: ProjectSearchKey) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status, status{
                    if isFromBottom{
                        self.arr_Projectdata.append(contentsOf: data.records ?? [])
                    }else{
                        self.arr_Projectdata = data.records ?? []
                    }
                }else{
                    self.arr_Projectdata.removeAll()
                }
                self.projectTotalPages = data.page?.total_pages ?? 1
                self.imgnodata.isHidden = !self.arr_Projectdata.isEmpty
                self.tableProjects.reloadData()
            }
        }
        
    }
    
    
    private func getProjectsDesignData(isFromBottom:Bool){
        
        if !isFromBottom{
            projectDesignPageNumber = 1
        }
        
        showLoadingActivity()
        APIController.shard.getProjectsDesignData(projectId: Object!.projects_profile_id, pageNumber: String(projectDesignPageNumber)) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status, status{
                    if isFromBottom{
                        self.projectDesignData.append(contentsOf: data.data ?? [])
                    }else{
                        self.projectDesignData = data.data ?? []
                    }
                }else{
                    self.projectDesignData.removeAll()
                }
                self.projectDesignTotalPages = data.page?.total_pages ?? 1
                self.imgnodata.isHidden = !self.projectDesignData.isEmpty
                self.tableProjects.reloadData()
            }
        }
        
    }
    
    private func showFile(url:String){
        showLoadingActivity()
        APIController.shard.getImage(url: url) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    let vc = WebViewViewController()
                    vc.data = data
                    let nav = UINavigationController(rootViewController: vc)
                    self.navigationController?.present(nav, animated: true)
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "There is an unknown error!!")
                }
            }
        }
    }
    
}

