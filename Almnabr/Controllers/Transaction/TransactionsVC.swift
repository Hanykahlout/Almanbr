//
//  TransactionsVC.swift
//  Almnabr
//
//  Created by MacBook on 02/10/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import DPLocalization
import FontAwesome_swift
import DropDown

class TransactionsVC: UIViewController {
    
    @IBOutlet weak var header: HeaderView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblsearchAdmin: UILabel!
    @IBOutlet weak var lblsearchByModule: UILabel!
    @IBOutlet weak var lblsearchByForm: UILabel!
    @IBOutlet weak var lblAllPending: UILabel!
    
    @IBOutlet weak var tableHeightConstraint:NSLayoutConstraint!
    
    @IBOutlet weak var viewsearchAdmin: UIView!
    
    @IBOutlet weak var viewsearchByModule: UIView!
    
    @IBOutlet weak var viewsearchByForm: UIView!
    
    @IBOutlet weak var viewsearchAllPending: UIView!
    
    @IBOutlet weak var viewsearch: UIView!
    
    @IBOutlet weak var imgDropAdmin: UIImageView!
    
    @IBOutlet weak var imgDropModule: UIImageView!
    
    @IBOutlet weak var imgDropForm: UIImageView!
    
    @IBOutlet weak var imgDropAllPending: UIImageView!
    
    @IBOutlet weak var imgnodata: UIImageView!
    
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchTextField: TextFieldWithPadding!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var view_FilterAdmin: UIView!
    
    
    private var StrTitle:String = ""
    private var StrSubMenue:String = "My Transactions"
    private var StrsearchByModule:String = ""
    private var StrsearchByForm:String = ""
    private var SearchKey:String = ""
    private var SearchAllpending:String = "all_pending_need_action"
    private var StrsearchByAdmin:Int = 0
    private var pageNumber = 1
    private var totalPages = 1
    private var total:Int = 0
    private var MenuObj:MenuObj?
    private var SubMenuObj:MenuObj?
    private var arr_data:[Tcore] = []
    private var arr_module:[ModuleObj] = []
    private var arr_moduleLabel:[String] = []
    private var arr_form:[ModuleObj] = []
    private var arr_formeLabel:[String] = []
    private var arr_Admin:[String] = ["Admin".localized(),"Users".localized()]
    private var arr_Admin_localized:[String] = ["Admin","Users"]
    private var arr_AllPending:[String] = ["all_pending_need_action" , "all_pending","all_complete","all_sent"]
    private var arr_AllPending_localized:[String] = ["all_pending_need_action".localized() , "all_pending".localized(),"all_complete".localized(),"all_sent".localized()]
    private var cellWidths: [CGFloat] = [1200]
    private var arr_NoData:[String] = ["No items found".localized()]
    private let fontStyle: FontAwesomeStyle = .solid
    private let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    private let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    private let kCellheaderReuse : String = "MyTransactionHeaderView"
    private let refreshControl = UIRefreshControl()
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigation()
        configGUI()
        
        get_module()
        get_forms()
        header.btnAction = self.menu_select
        configGUI()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        searchTextField.addTarget(self, action: #selector(searchAction), for: .editingChanged)
        
        
    }
    
    
    
    // MARK: - Config Navigation
    
    func configNavigation() {
        
        _ = self.navigationController?.preferredStatusBarStyle
        navigationController?.navigationBar.barTintColor = maincolor
        addNavigationBarTitle(navigationTitle: "My Transactions".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        get_Transaction_data(isFromBottom: false)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        
        lblTitle.textColor =  "1A3665".getUIColor()
        lblTitle.font = .kufiRegularFont(ofSize: 17)
        lblTitle.text =  StrSubMenue
        
        self.imgnodata.isHidden = true
        
        self.viewsearch.setBorderGrayWidthCorner(1, 20)
        
        self.viewsearchAllPending.setBorderGrayWidthCorner(1, 20)
        self.lblAllPending.text =  "all_pending_need_action".localized()
        self.lblAllPending.font = .kufiRegularFont(ofSize: 13)
        
        
        self.viewsearchByForm.setBorderGrayWidthCorner(1, 20)
        self.lblsearchByForm.text = "Search By Form"
        //"txt_searchByForm".localized()
        self.lblsearchByForm.font = .kufiRegularFont(ofSize: 13)
        
        // for first puplish
        self.viewsearchByForm.isUserInteractionEnabled = true
        self.StrsearchByForm = ""
        
        
        self.viewsearchAdmin.setBorderGrayWidthCorner(1, 20)
        self.lblsearchAdmin.text =  "Users".localized()
        self.lblsearchAdmin.font = .kufiRegularFont(ofSize: 13)
        
        self.viewsearchByModule.setBorderGrayWidthCorner(1, 20)
        self.lblsearchByModule.text =  "txt_searchByModule".localized()
        self.lblsearchByModule.font = .kufiRegularFont(ofSize: 13)
        
        self.imgDropAdmin.image = dropDownmage
        self.imgDropForm.image = dropDownmage
        self.imgDropModule.image = dropDownmage
        self.imgDropAllPending.image = dropDownmage
        
        
        
        table.dataSource = self
        table.delegate = self
        table.refreshControl = refreshControl
        let nib = UINib(nibName: "MyTrannsactionTVCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "MyTrannsactionTVCell")
        
        if userObj?.user_type_id == "1" {
            self.view_FilterAdmin.isHidden = false
        }else{
            self.view_FilterAdmin.isHidden = true
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
    
    @objc func refresh(){
        get_Transaction_data(isFromBottom: false)
    }
    
    @objc func searchAction(){
        if !arr_data.isEmpty{
            table.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
        get_Transaction_data(isFromBottom: false)
    }
    
    
    @objc func buttonMenuAction(sender: UIButton!) {
        let language =  L102Language.currentAppleLanguage()
        if language == "ar"{
            panel?.openRight(animated: true)
        }else{
            panel?.openLeft(animated: true)
        }
    }
    
    
    
    @IBAction func btnSearchAdmin_Click(_ sender: Any) {
        
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_Admin
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            
            if name == self.arr_Admin[index] {
                self.lblsearchAdmin.text =  name
                let i =  self.arr_Admin_localized[index]
                if i == "Admin" {
                    self.StrsearchByAdmin = 1
                }else{
                    self.StrsearchByAdmin = 0
                }
                self.imgDropAdmin.image = self.dropDownmage
                self.get_Transaction_data(isFromBottom: false)
            }
            
            // self.sig_id = self.arr_sig_id[index].id
        }
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func btnSearchForm_Click(_ sender: Any) {
        self.imgDropForm.image = dropUpmage
        
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_formeLabel
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            if name == self.arr_formeLabel[index] {
                
                self.lblsearchByForm.text =  name
                let i = self.arr_form[index].value
                self.StrsearchByForm = i
                
                self.imgDropForm.image = self.dropDownmage
                self.get_Transaction_data(isFromBottom: false)
            }
            
        }
        self.present(vc, animated: true, completion: nil)
        
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
                self.get_Transaction_data(isFromBottom: false)
            }
        }
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func btnSearchAllPending_Click(_ sender: Any) {
        
        self.imgDropForm.image = dropUpmage
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_AllPending_localized
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            if name == self.arr_AllPending_localized[index]  {
                self.lblAllPending.text =  name
                // let i =  self.arr_module[index].value
                self.SearchAllpending = self.arr_AllPending[index]
                self.imgDropAllPending.image = self.dropDownmage
                self.get_Transaction_data(isFromBottom: false)
            }
        }
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
}


extension TransactionsVC: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTrannsactionTVCell", for: indexPath) as! MyTrannsactionTVCell
        
        let obj = arr_data[indexPath.item]
        
        //        cell.viewBack.setBorderGray()
        
        let Id = "\(obj.transaction_request_id)"
        let Description = "Description".localized() + "  \(obj.transaction_request_description)"
        let from = "From".localized() + ":  \(obj.transaction_from_name)"
        let to = "To".localized() + ":  \(obj.transaction_to_name)"
        let barcode = "  \(obj.barcode)"
        //"Barcode".localized() +
        let type = "Type".localized() + ":  \(obj.transactions_type_name )"
        let Module = "Module".localized() + ":  \(obj.module_name)"
        let Form = "Form".localized() + ":  \(obj.transactions_name)"
        let writer = "By".localized() + ":  \(obj.transaction_request_user_name_writer)"
        let Submitter = "Submitter".localized() + ":  \(obj.transactions_submitter_user_name)"
        let LastUpdate =  "\(obj.transactions_date_last_update)"
        let Status = "\(obj.transaction_request_status)"
        
        
        let maincolor = "#1A3665".getUIColor()
        
        cell.lblNo.text = Id
        
        let Descattribute: NSAttributedString = Description.attributedStringWithColor(["Description".localized()], color: maincolor)
        cell.lblDesc.attributedText = Descattribute
        
        let fromattributed: NSAttributedString = from.attributedStringWithColor(["From".localized()], color: maincolor)
        cell.lblFrom.attributedText = fromattributed
        
        let Toattributed: NSAttributedString = to.attributedStringWithColor(["To".localized()], color: maincolor)
        cell.lblTo.attributedText = Toattributed
        
        
        cell.lblBarCode.text = barcode
        
        let Typeattributed: NSAttributedString = type.attributedStringWithColor(["Type".localized()], color: maincolor)
        cell.lblType.attributedText = Typeattributed
        
        
        let Moduleattributed: NSAttributedString = Module.attributedStringWithColor(["Module".localized()], color: maincolor)
        cell.lblModule.attributedText = Moduleattributed
        
        let Formattributed: NSAttributedString = Form.attributedStringWithColor(["Form".localized()], color: maincolor)
        cell.lblForm.attributedText = Formattributed
        
        let writerattributed: NSAttributedString = writer.attributedStringWithColor(["By".localized()], color: maincolor)
        cell.lblWriter.attributedText = writerattributed
        
        let Submitterattributed: NSAttributedString = Submitter.attributedStringWithColor(["Submitter".localized()], color: maincolor)
        cell.lblSubmitter.attributedText = Submitterattributed
        
        cell.lblLastUpdate.text = LastUpdate
        
        let Statusattributed: NSAttributedString = Status.attributedStringWithColor(["Status".localized()], color: maincolor)
        cell.lblStatus.attributedText = Statusattributed
        
        
        //        cell.viewBack.setcorner()
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row   == arr_data.count - 1  {
            if pageNumber < totalPages{
                pageNumber += 1
                get_Transaction_data(isFromBottom: true)
            }
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let obj = self.arr_data[indexPath.item]
        print("Selected rows after selection: ", obj.transaction_key)
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
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


extension TransactionsVC:UISearchBarDelegate {
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.SearchKey = searchBar.text!
        get_Transaction_data(isFromBottom: false)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
}

// MARK: - API Handling
extension TransactionsVC{
    
    
    private func get_Transaction_data(isFromBottom:Bool){
        
        let search:String = searchTextField.text!.replacingOccurrences(of: " ", with: "%20").trim()
        if !isFromBottom{
            pageNumber = 1
        }
        self.showLoadingActivity()
//        /tc/list/1/10?searchKey=&searchAdmin=0&searchByForm=&searchByModule=&searchByStatus=all_pending_need_action
        APIController.shard.sendRequestGetAuth(urlString: "tc/list/\(pageNumber)/10?searchKey=\(search)&searchAdmin=\(StrsearchByAdmin)&searchByModule=\(StrsearchByModule)&searchByForm=\(StrsearchByForm)&searchByStatus=\(SearchAllpending)" ) { (response) in
            
            if !isFromBottom {
                self.arr_data.removeAll()
            }
            
            let status = response["status"] as? Bool
            let total = response["total"] as? Int
            
            
            let page = response["page"] as? [String:Any]
            let list = response["list"] as? [String:Any]
            let pageObj = PageObj(page ?? [:])
            self.totalPages = pageObj.total_pages
            if status == true{
                
                self.total = total!
                
                if  let records = list!["records"] as? NSArray{
                    
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj = Tcore.init(dict!)
                        
                        self.arr_data.append(obj)
                    }
                    
                    
                    
                    if records.count == 0 {
                        self.imgnodata.isHidden = false
                    }else{
                        self.imgnodata.isHidden = true
                    }
                    
                    
                    self.table.isHidden = false
                    self.table.reloadData()
                    
                }
                
            }
            
            self.imgnodata.isHidden = !self.arr_data.isEmpty
            self.hideLoadingActivity()
            if self.refreshControl.isRefreshing{
                self.refreshControl.endRefreshing()
            }
            
        }
        
    }
    
    private func get_module(){
        self.arr_module.removeAll()
        self.arr_module.append(.init([:]))
        self.arr_moduleLabel.removeAll()
        self.arr_moduleLabel.append("Search By Module")
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "tc/getmodulesmydoclist" ) { (response) in
            
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["list"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_module.append(obj)
                        self.arr_moduleLabel.append(obj.label)
                        
                    }
                    self.hideLoadingActivity()
                }
            }
            
            
        }
    }
    
    
    private func get_forms(){
        self.arr_form.removeAll()
        self.arr_formeLabel.removeAll()
        self.arr_formeLabel.append("Search By Form")
        self.arr_form.append(.init([:]))
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
    
    
}
