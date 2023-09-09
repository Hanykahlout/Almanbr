//
//  AllPrpjectsVC.swift
//  Almnabr
//
//  Created by MacBook on 10/10/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import DPLocalization
import FontAwesome_swift
import DropDown
class AllPrpjectsVC: UIViewController {
    
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblsearchByServices: UILabel!
    @IBOutlet weak var lblsearchByBranch: UILabel!
    
    
    @IBOutlet weak var viewsearch: UIView!
    @IBOutlet weak var viewsearchByServices: UIView!
    @IBOutlet weak var viewsearchByBranch: UIView!
    
    
    @IBOutlet weak var img_nodata: UIImageView!
    
    @IBOutlet weak var imgDropServices: UIImageView!
    @IBOutlet weak var imgDropBranch: UIImageView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var header: HeaderView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var SearchKey:String = ""
    var StrTitle:String = ""
    var StrSubMenue:String = "All Projects".localized()
    var StrMenue:String = "Projects".localized()
    
    var StrsearchByServices:String = ""
    var StrsearchByBranch:String = ""
    var searchByTypeOfApproval:String = ""
    var pageNumber = 1
    var allItemDownloaded = false
    var MenuObj:MenuObj?
    var SubMenuObj:MenuObj?
    var arr_data:[projectObj] = []
    var arr_Services:[ModuleObj] = []
    var arr_ServicesLabel:[String] = []
    var arr_branch:[ModuleObj] = []
    var arr_branchLabel:[String] = []
    var arr_Admin:[String] = ["All".localized(),"Manual".localized(),"Auto".localized()]
    var cellWidths: [CGFloat] = [700]
    var arr_NoData:[String] = ["No items found".localized()]
    
    let fontStyle: FontAwesomeStyle = .solid
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        configGUI()
        get_Projects_data(showLoading: true, loadOnly: true)
        get_Services()
        get_Branch()
        
        header.btnAction = self.menu_select
      
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Config Navigation
    func configNavigation() {
        _ = self.navigationController?.preferredStatusBarStyle
        self.view.backgroundColor = "FFFFFF".getUIColor() //F0F4F8
        navigationController?.navigationBar.barTintColor = .red
        
        addNavigationBarTitle(navigationTitle: StrTitle)
    }
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        self.viewsearch.setBorderGrayWidthCorner(1, 20)
        
        
        self.viewsearchByBranch.setBorderGrayWidthCorner(1, 20)
        self.lblsearchByBranch.text =  "txt_searchByBranch".localized()
        self.lblsearchByBranch.font = .kufiRegularFont(ofSize: 15)
        
        
        self.viewsearchByServices.setBorderGrayWidthCorner(1, 20)
        self.lblsearchByServices.text =  "txt_searchByServices".localized()
        self.lblsearchByServices.font = .kufiRegularFont(ofSize: 15)
        searchBar.delegate = self

        self.StrMenue =  MenuObj?.menu_name ?? "Projects".localized()
      
        self.lblTitle.text =  StrSubMenue
        
      
        self.imgDropBranch.image = dropDownmage
        self.imgDropServices.image = dropDownmage
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "ProjectTVCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "ProjectTVCell")
        
    }
    
    
    
    func menu_select(){
        let language =  L102Language.currentAppleLanguage()
        if language == "ar"{
            panel?.openRight(animated: true)
        }else{
            panel?.openLeft(animated: true)
        }
        
    }
    
    
    func get_Projects_data(showLoading: Bool, loadOnly: Bool){
        
        if showLoading {
            self.showLoadingActivity()
        }
        
        let search:String = SearchKey.replacingOccurrences(of: " ", with: "%20").trim()
        
        APIController.shard.sendRequestGetAuth(urlString: "MRpWxXzlMesi27d/1/10?branch_id=\(StrsearchByBranch)&search_services=\(StrsearchByServices)&search_key=\(search)" ) { (response) in
            
            if self.pageNumber == 1 {
                self.arr_data.removeAll()
            }
            let status = response["status"] as? Bool
            if loadOnly {
                self.table.reloadData()
            }
            
            
            let page = response["page"] as? [String:Any]
            if status == true{
                if  let records = response["records"] as? NSArray{
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj = projectObj.init(dict!)
                        self.arr_data.append(obj)
                    }
                    let pageObj = PageObj(page!)
                  
                    if pageObj.total_pages > self.pageNumber {
                        self.allItemDownloaded = false
                    }else{
                        self.allItemDownloaded = true
                    }
                    if records.count == 0 {
                        self.img_nodata.isHidden = false
                    }else{
                        self.img_nodata.isHidden = true
                    }
                    self.table.reloadData()
                    self.hideLoadingActivity()
                }
                
            }else{
                self.hideLoadingActivity()
               // self.lblnodata.isHidden = false
            }
            
            
        }
    }
    
    
    func get_Services(){
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "aB8Vlmue0xVSv8O/projects_view" ) { (response) in
            
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_Services.append(obj)
                        // for echitem in obj{
                        self.arr_ServicesLabel.append(obj.label)
                        // }
                        
                    }
                    self.hideLoadingActivity()
                }
            }
            
            
        }
    }
    
    
    func get_Branch(){
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "tc/tbranches" ) { (response) in
            
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_branch.append(obj)
                        // for echitem in obj{
                        self.arr_branchLabel.append(obj.label)
                        // }
                        
                    }
                    self.hideLoadingActivity()
                }
            }
            
            
        }
    }
 

 
    
    
    @IBAction func btnSearchBranch_Click(_ sender: Any) {
        
        self.imgDropBranch.image = dropUpmage
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_branchLabel
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            if name == self.arr_branchLabel[index] {
                self.lblsearchByBranch.text =  name
                let i =  self.arr_branch[index].value
                self.StrsearchByBranch = i
                self.imgDropBranch.image = self.dropDownmage
                self.get_Projects_data(showLoading: true, loadOnly: true)
            }

        }
        self.present(vc, animated: true, completion: nil)
        
        
        
//        let dropDown = DropDown()
//        dropDown.anchorView = view
//        dropDown.backgroundColor = .white
//        dropDown.cornerRadius = 2.0
//
//        dropDown.dataSource = self.arr_branchLabel
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//
//            if item == self.arr_branchLabel[index] {
//                self.lblsearchByBranch.text =  item
//                let i =  self.arr_branch[index].value
//                self.StrsearchByBranch = i
//                self.imgDropBranch.image = dropDownmage
//                get_Projects_data(showLoading: true, loadOnly: true)
//            }
//
//        }
//        dropDown.direction = .bottom
//        dropDown.anchorView = viewsearchByBranch
//        dropDown.bottomOffset = CGPoint(x: 0, y: viewsearchByBranch.bounds.height)
//        dropDown.width = viewsearchByBranch.bounds.width
//        dropDown.show()
    }
    
    
    
    @IBAction func btnSearchServices_Click(_ sender: Any) {
        
        self.imgDropServices.image = dropUpmage
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_ServicesLabel
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            if name == self.arr_ServicesLabel[index] {
                self.lblsearchByServices.text =  name
                let i =  self.arr_Services[index].value
                self.StrsearchByServices = i
                self.imgDropServices.image = self.dropDownmage
                self.get_Projects_data(showLoading: true, loadOnly: true)
            }

        }
        self.present(vc, animated: true, completion: nil)
        
//        self.imgDropServices.image = dropUpmage
//        let dropDown = DropDown()
//        dropDown.anchorView = view
//        dropDown.backgroundColor = .white
//        dropDown.cornerRadius = 2.0
//
//        dropDown.dataSource = self.arr_ServicesLabel
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//
//            if item == self.arr_ServicesLabel[index] {
//                self.lblsearchByServices.text =  item
//                let i =  self.arr_Services[index].value
//                self.StrsearchByServices = i
//                self.imgDropServices.image = dropDownmage
//                get_Projects_data(showLoading: true, loadOnly: true)
//            }
//
//        }
//        dropDown.direction = .bottom
//        dropDown.anchorView = viewsearchByServices
//        dropDown.bottomOffset = CGPoint(x: 0, y: viewsearchByServices.bounds.height)
//        dropDown.width = viewsearchByServices.bounds.width
//        dropDown.show()
    }
    
    
}





extension AllPrpjectsVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectTVCell", for: indexPath) as! ProjectTVCell
        
        let obj = arr_data[indexPath.item]
      
        
        let Id =  "ID".localized() + ":  \(obj.projects_profile_id)"
        let Title = "Title".localized() + ":  \(obj.project_title)"
        let Branch = "Branch".localized() + ":  \(obj.branch_name)"
        let Type = "Type".localized() + ":  \(obj.customer_type)"
        let Customers = "Customers".localized() + "  \(obj.customer_title_en)"
        let writer = "By".localized() + ": \(obj.writer)"
        let date = "  \(obj.projects_profile_created_datetime)"
       
        
        cell.lblId.text = Id
        cell.lblBranch.text = Branch
        cell.lblTitle.text = Title
        cell.lblType.text = Type
        cell.lblCustomers.text = Customers
        cell.lblWriter.text = writer
        cell.lblDate.text = date

        let maincolor = "#1A3665".getUIColor()
        let Idattribute: NSAttributedString = Id.attributedStringWithColor(["ID"], color: "#1A3665".getUIColor())
        cell.lblId.attributedText = Idattribute
        
        let titleattribute: NSAttributedString = Title.attributedStringWithColor(["Title".localized()], color: maincolor)
        cell.lblTitle.attributedText = titleattribute
        
        let branchAttribute: NSAttributedString = Branch.attributedStringWithColor(["Branch".localized()], color: maincolor)
        cell.lblBranch.attributedText = branchAttribute
        
        let Typeattributed: NSAttributedString = Type.attributedStringWithColor(["Type".localized()], color: maincolor)
        cell.lblType.attributedText = Typeattributed
        
        
       
        let Customersattributed: NSAttributedString = Customers.attributedStringWithColor(["Customers".localized()], color: maincolor)
        cell.lblCustomers.attributedText = Customersattributed
        
        
        
        let Writerattributed: NSAttributedString = writer.attributedStringWithColor(["By".localized()], color: maincolor)
        cell.lblWriter.attributedText = Writerattributed

        cell.lblDate.text = date
        cell.lblDate.textColor = maincolor
       
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let obj = arr_data[indexPath.item]
        let vc:ProjectDetailsVC = AppDelegate.mainSB.instanceVC()
        vc.title =  self.title
        vc.Object = obj
        vc.MenuObj = self.MenuObj
        vc.StrSubMenue =  self.StrSubMenue
        vc.StrMenue = self.StrMenue
        self.navigationController?.pushViewController(vc, animated: true)
//                _ =  panel?.center(vc)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.tag == 0 {
            
            
            print(indexPath.section)
            if indexPath.row   == arr_data.count - 1  {
                    updateNextSet()
                    print("next step")
                
            }
      }
      }
    
        func updateNextSet(){
               print("On Completetion")
            if !allItemDownloaded {
                pageNumber = pageNumber + 1
                get_Projects_data(showLoading: false, loadOnly: true)
            }
       }
}
    

extension AllPrpjectsVC:UISearchBarDelegate {
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
       self.SearchKey = searchBar.text!
        get_Projects_data(showLoading: false, loadOnly: false)
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.SearchKey = searchBar.text!
        get_Projects_data(showLoading: false, loadOnly: false)
        searchBar.resignFirstResponder()
    }
    
    
}

 
//backend/pr/qtp/1/pages/1/10 --- test
