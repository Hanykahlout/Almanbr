//
//  ApproveTransactionVC.swift
//  Almnabr
//
//  Created by MacBook on 04/10/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import DPLocalization
import FontAwesome_swift
import DropDown

class ApproveTransactionVC: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var tableHeightConstraint:NSLayoutConstraint!
    
    @IBOutlet weak var lblsearchAdmin: UILabel!
    @IBOutlet weak var lblsearchByModule: UILabel!
    @IBOutlet weak var lblsearchByForm: UILabel!
    
    
    @IBOutlet weak var viewsearchAdmin: UIView!
    @IBOutlet weak var viewsearchByModule: UIView!
    @IBOutlet weak var viewsearchByForm: UIView!
    
    @IBOutlet weak var imgDropAdmin: UIImageView!
    @IBOutlet weak var imgDropModule: UIImageView!
    @IBOutlet weak var imgDropForm: UIImageView!
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var header: HeaderView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imgnodata: UIImageView!
    
    
    var StrTitle:String = ""
    var StrSubMenue:String = ""
    var StrsearchByModule:String = ""
    var StrsearchByForm:String = ""
    var searchByTypeOfApproval:String = ""
    var SearchKey:String = ""
    var pageNumber = 1
    var allItemDownloaded = false
    var MenuObj:MenuObj?
    var SubMenuObj:MenuObj?
    var arr_data:[Tcore] = []
    var arr_module:[ModuleObj] = []
    var arr_moduleLabel:[String] = []
    var arr_form:[ModuleObj] = []
    var arr_formeLabel:[String] = []
    var arr_Admin:[String] = ["All".localized(),"Manual".localized(),"Auto".localized()]
    var cellWidths: [CGFloat] = [1200]
    var arr_NoData:[String] = ["No items found".localized()]
    
    
    let fontStyle: FontAwesomeStyle = .solid
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        viewsearchByForm.isUserInteractionEnabled = true
        viewsearchByForm.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnSearchForm_Click)))
        configGUI()
        get_Transaction_data(showLoading: true, loadOnly: true)
        get_module()
        get_forms()
        header.btnAction = {
           
            self.menu_select()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
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
        
        lblTitle.textColor =  "1A3665".getUIColor()
        lblTitle.font = .kufiRegularFont(ofSize: 17)
        lblTitle.text =  StrSubMenue
        
        self.imgnodata.isHidden = true
        
        self.viewsearchByForm.setBorderGrayWidthCorner(1, 20)
        self.lblsearchByForm.text = "WIR"
        //"txt_searchByForm".localized()
        self.lblsearchByForm.font = .kufiRegularFont(ofSize: 15)
        
        
        
        self.viewsearchAdmin.setBorderGrayWidthCorner(1, 20)
        self.lblsearchAdmin.text =  "txt_searchAll".localized()
        self.lblsearchAdmin.font = .kufiRegularFont(ofSize: 15)
        
        self.viewsearchByModule.setBorderGrayWidthCorner(1, 20)
        self.lblsearchByModule.text =  "txt_searchByModule".localized()
        self.lblsearchByModule.font = .kufiRegularFont(ofSize: 15)
        
        self.imgDropAdmin.image = dropDownmage
        self.imgDropForm.image = dropDownmage
        self.imgDropModule.image = dropDownmage
        
        
        searchBar.delegate = self
        
        self.lblTitle.text =  StrSubMenue
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "ApprovalTVCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "ApprovalTVCell")
        
    }
    
    func get_Transaction_data(showLoading: Bool, loadOnly: Bool){
        
        if showLoading {
            self.showLoadingActivity()
        }
        
        let search:String = SearchKey.replacingOccurrences(of: " ", with: "%20").trim()

        // &searchByModule=&searchByForm=&searchByTypeOfApproval=
        APIController.shard.sendRequestGetAuth(urlString: "tc/myapprovaldoclist/1/10?searchKey=\(search)&searchByTypeOfApproval=\(searchByTypeOfApproval)&searchByModule=\(StrsearchByModule)&searchByForm=\(StrsearchByForm)" ) { (response) in
            
            if self.pageNumber == 1 {
                self.arr_data.removeAll()
            }
            
            let status = response["status"] as? Bool
            if loadOnly {
                self.table.reloadData()
            }
            
            let page = response["page"] as? [String:Any]
            let list = response["list"] as? [String:Any]
            if status == true{
                if  let records = list!["records"] as? NSArray{
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj = Tcore.init(dict!)
                        self.arr_data.append(obj)
                    }
                    let pageObj = PageObj(page!)
                    if records.count == 0 {
                        self.imgnodata.isHidden = false
                    }else{
                        self.imgnodata.isHidden = true
                    }
                    if pageObj.total_pages > self.pageNumber {
                        self.allItemDownloaded = false
                    }else{
                        self.allItemDownloaded = true
                    }
                    self.table.reloadData()
                    //self.tableHeightConstraint.constant = self.table.contentSize.height
                    self.hideLoadingActivity()
                }
                
            }else{
                self.hideLoadingActivity()
                self.imgnodata.isHidden = false
                
            }
            
            
        }
    }
    
    
    func get_module(){
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "tc/getmodulesmydoclist" ) { (response) in
            
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["list"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_module.append(obj)
                        // for echitem in obj{
                        self.arr_moduleLabel.append(obj.label)
                        // }
                        
                    }
                    self.hideLoadingActivity()
                }
            }
            
            
        }
    }
    
    
    func get_forms(){
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "tc/gettcmydoclist" ) { (response) in

            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["list"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_form.append(obj)
                        // for echitem in obj{
                        self.arr_formeLabel.append(obj.label)
                        // }
                        
                    }
                    self.hideLoadingActivity()
                }
            }
            
            
        }
    }
    
    
    func menu_select(){
        let language =  L102Language.currentAppleLanguage()
        if language == "ar"{
            panel?.openRight(animated: true)
        }else{
            panel?.openLeft(animated: true)
        }
        
    }
    
    
    @IBAction func btnSearchAdmin_Click(_ sender: Any) {
        
        self.imgDropAdmin.image = dropUpmage
        
        let dropDown = DropDown()
        dropDown.anchorView = view
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 2.0
        
        if self.arr_Admin.count == 0 {
            dropDown.dataSource = self.arr_NoData
            dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.imgDropAdmin.image = dropDownmage
        }else{
            dropDown.dataSource = self.arr_Admin
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                
                if item == self.arr_Admin[index] {
                    self.lblsearchAdmin.text =  item
                    self.searchByTypeOfApproval = index == 0 ? "" : item
                    self.imgDropAdmin.image = dropDownmage
                    get_Transaction_data(showLoading: true, loadOnly: true)
                }
                
            }}
        dropDown.direction = .bottom
        dropDown.anchorView = viewsearchAdmin
        dropDown.bottomOffset = CGPoint(x: 0, y: viewsearchAdmin.bounds.height)
        dropDown.width = viewsearchAdmin.bounds.width
        dropDown.show()
    }
    
    @objc private func btnSearchForm_Click(){
        
        self.imgDropForm.image = dropUpmage
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_formeLabel
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            if name == self.arr_formeLabel[index] {
                self.lblsearchByForm.text =  name
                let i =  self.arr_form[index].value
                self.StrsearchByForm = i
                self.imgDropForm.image = self.dropDownmage
                self.get_Transaction_data(showLoading: true, loadOnly: true)
            }
        }
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnSearchModule_Click(_ sender: Any) {
        
        self.imgDropForm.image = dropUpmage
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_moduleLabel
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            if name == self.arr_moduleLabel[index] {
                self.lblsearchByModule.text =  name
                let i =  self.arr_module[index].value
                self.StrsearchByModule = i
                self.imgDropModule.image = self.dropDownmage
                self.get_Transaction_data(showLoading: true, loadOnly: true)
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    
}





extension ApproveTransactionVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApprovalTVCell", for: indexPath) as! ApprovalTVCell
        
        let obj = arr_data[indexPath.item]
        
        let maincolor = "#1A3665".getUIColor()

        let Id =   "\(obj.transaction_request_id)"
        let Desc = "\(obj.transaction_request_description)"
        let from = "From".localized() + ":  \(obj.transaction_from_name)"
        let to = "To".localized() + ":  \(obj.transaction_to_name)"
        let type = "Type".localized() + ":  \(obj.transactions_type_name)"
        let Module = "Module".localized() + ":  \(obj.module_name)"
        let writer = "By".localized() + ":  \(obj.transaction_request_user_name_writer)"
        let date = "\(obj.create_datetime)"
        let ApprovalType =  "\(obj.transaction_request_type_of_approval)"
        
        cell.lblNo.text = Id
        cell.lbldate.text = date
        cell.lblApprovalType.text = ApprovalType
        cell.lblDesc.text = Desc
        
        
        
        let fromattributed: NSAttributedString = from.attributedStringWithColor(["From".localized()], color: maincolor)
        cell.lblFrom.attributedText = fromattributed
        
        let toattributed: NSAttributedString = to.attributedStringWithColor(["To".localized()], color: maincolor)
        cell.lblTo.attributedText = toattributed
        
        let typeattributed: NSAttributedString = type.attributedStringWithColor(["Type".localized()], color: maincolor)
        cell.lblType.attributedText = typeattributed
        
        
        let Moduleattributed: NSAttributedString = Module.attributedStringWithColor(["Module".localized()], color: maincolor)
        cell.lblModule.attributedText = Moduleattributed
        
        let writerattributed: NSAttributedString = writer.attributedStringWithColor(["By".localized()], color: maincolor)
        cell.lblWriter.attributedText = writerattributed
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = arr_data[indexPath.item]
        switch obj.transaction_key{
        case "FORM_HRV1":
            let vc = VactionViewController()
            vc.transaction_request_id = obj.transaction_request_id
            self.navigationController?.pushViewController(vc, animated: true)
        case "FORM_WIR":
            let vc : TransactionFormDetailsVC = AppDelegate.TransactionSB.instanceVC()
            vc.Object = obj
            //vc.filePath = obj.url
            self.navigationController?.pushViewController(vc, animated: true)
        case "FORM_CT1":
            let vc = NewContractVC()
            vc.transaction_request_id = obj.transaction_request_id
            self.navigationController?.pushViewController(vc, animated: true)
        case "FORM_HRLN1":
            let vc = LoanViewController()
            vc.transactionId = obj.transaction_request_id
            self.navigationController?.pushViewController(vc, animated: true)
        case "FORM_OVR1":
            let vc = OverTimeViewController()
            vc.transactionId = obj.transaction_request_id
            self.navigationController?.pushViewController(vc, animated: true)
        case "FORM_BNS1":
            let vc = BonusViewController()
            vc.transactionId = obj.transaction_request_id
            self.navigationController?.pushViewController(vc, animated: true)
        case "FORM_VOL1":
            let vc = ViolationViewController()
            vc.transactionId = obj.transaction_request_id
            self.navigationController?.pushViewController(vc, animated: true)
        case "FORM_DET1":
            let vc = DeductionViewController()
            vc.transactionId = obj.transaction_request_id
            self.navigationController?.pushViewController(vc, animated: true)
        case "FORM_JF":
            let vc = JobOfferViewController()
            vc.transactionId = obj.transaction_request_id
            self.navigationController?.pushViewController(vc, animated: true)
        case "FORM_C1":
            let vc = CFormViewController()
            vc.isOutging = true
            vc.transactionId = obj.transaction_request_id
            self.navigationController?.pushViewController(vc, animated: true)
        case "FORM_C2":
            let vc = CFormViewController()
            vc.isOutging = false
            vc.transactionId = obj.transaction_request_id
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
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
            get_Transaction_data(showLoading: false, loadOnly: true)
        }
    }
}

extension ApproveTransactionVC:UISearchBarDelegate {
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.SearchKey = searchBar.text!
        get_Transaction_data(showLoading: false, loadOnly: false)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
}
