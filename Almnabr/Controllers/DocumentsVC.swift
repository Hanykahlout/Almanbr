//
//  DocumentsVC.swift
//  Almnabr
//
//  Created by MacBook on 20/10/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import DPLocalization
import FontAwesome_swift
import DropDown

class DocumentsVC: UIViewController {
    
    
    @IBOutlet weak var lblActive: UILabel!
    @IBOutlet weak var lblDocumentType: UILabel!
    @IBOutlet weak var lblDivision: UILabel!
    
    @IBOutlet weak var viewActive: UIView!
    @IBOutlet weak var viewDocumentType: UIView!
    @IBOutlet weak var viewDivision: UIView!
    
    @IBOutlet weak var btnActive: UIButton!
    @IBOutlet weak var btnDocumentType: UIButton!
    @IBOutlet weak var btnDivision: UIButton!
    
    @IBOutlet weak var imgDropActive: UIImageView!
    @IBOutlet weak var imgDropDocumentType: UIImageView!
    @IBOutlet weak var imgDropDivision: UIImageView!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var viewsearch: UIView!
    @IBOutlet weak var img_nodata: UIImageView!
    @IBOutlet weak var tableHeightConstraint:NSLayoutConstraint!
    
    var StrTitle:String = ""
    var StrSubMenue:String = ""
    var StrDocumentType:String = ""
    var StrActive:String = ""
    var StrDivision:String = ""
    
    var SearchKey:String = ""
    
    var StrsearchByAdmin:Bool = true
    var pageNumber = 1
    var total:Int = 0
    var allItemDownloaded = false
    var MenuObj:MenuObj?
    var SubMenuObj:MenuObj?
    var arr_data:[DocumentObj] = []
    var arr_Division:[ModuleObj] = []
    var arr_DivisionLabel:[String] = []
    var arr_DocumentType:[ModuleObj] = []
    var arr_DocumentTypeLabel:[String] = []
    var arr_Active:[ModuleObj] = []
    var arr_ActiveLabel:[String] = ["Active".localized(),"History".localized(),"All".localized()]
    var arr_ActiveVlaue:[String] = ["1","0",""]
    var arr_NoData:[String] = ["No items found".localized()]
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        configGUI()
        //  setupCollection()
        get_Documents_data(showLoading: true, loadOnly: true)
       // get_Active()
        get_DocumentType()
        get_Division()
        
        
        
    }
    
    
    func configNavigation() {
        _ = self.navigationController?.preferredStatusBarStyle
        self.view.backgroundColor = "FFFFFF".getUIColor() //F0F4F8
        navigationController?.navigationBar.barTintColor = .red
        
        addNavigationBarTitle(navigationTitle: StrTitle)
    }
   
    
    func configGUI() {
        
        self.viewsearch.setBorderGrayWidthCorner(1, 20)
        
        
        self.viewActive.setBorderGrayWidthCorner(1, 20)
        self.lblActive.text =  "txt_Active".localized()
        self.lblActive.font = .kufiRegularFont(ofSize: 15)
        
        self.viewDocumentType.setBorderGrayWidthCorner(1, 20)
        self.lblDocumentType.text =  "txt_DocumentType".localized()
        self.lblDocumentType.font = .kufiRegularFont(ofSize: 15)
        
        self.viewDivision.setBorderGrayWidthCorner(1, 20)
        self.lblDivision.text =  "txt_Division".localized()
        self.lblDivision.font = .kufiRegularFont(ofSize: 15)
        
        self.img_nodata.isHidden = false
        
        btnDivision.isHidden = true
        btnDocumentType.isHidden = true
        btnActive.isHidden = true
        
        self.imgDropDivision.image = dropDownmage
        self.imgDropDocumentType.image = dropDownmage
        self.imgDropActive.image = dropDownmage
        
       
        
        searchBar.delegate = self
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "TransactionTVCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "TransactionTVCell")
        
        
    }
    
    func get_Documents_data(showLoading: Bool, loadOnly: Bool){
        
        if showLoading {
            self.showLoadingActivity()
        }
        
        let search:String = SearchKey.replacingOccurrences(of: " ", with: "%20").trim()
        
        APIController.shard.sendRequestGetAuth(urlString: "gnN4Pp81e9/\(projects_profile_id)/\(projects_supervision_id)/\(pageNumber)/10?searchKey=\(search)&documents_file_status=\(StrActive)&document_type=\(StrDocumentType)&item_document_type=\(StrDivision)" ) { (response) in
            
            if self.pageNumber == 1 {
                self.arr_data.removeAll()
            }
            let status = response["status"] as? Bool
            //let total = response["total"] as? Int
            if loadOnly {
                self.table.reloadData()
            }
            
            let page = response["page"] as? [String:Any]
           // let list = response["list"] as? [String:Any]
            if status == true{
               // self.total = total!
                
                if  let records = response["records"] as? NSArray{
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj = DocumentObj.init(dict!)
                        self.arr_data.append(obj)
                    }
                    
                    
                    let pageObj = PageObj(page!)
                    
                    
                    
                    if records.count == 0 {
                        self.img_nodata.isHidden = false
                    }else{
                        self.img_nodata.isHidden = true
                    }
                    
                    if pageObj.total_pages > self.pageNumber {
                        self.allItemDownloaded = false
                    }else{
                        self.allItemDownloaded = true
                    }
                    self.table.reloadData()
                    // self.collection.scrollToItem(at:IndexPath(item: self.arr_data.count - 1, section: self.arr_data.count - 1), at: .left, animated: false)
                    self.hideLoadingActivity()
                }
                
            }else{
                self.hideLoadingActivity()
                self.img_nodata.isHidden = false
                // self.showAMessage(withTitle: "error", message: "Please try again")
            }
            
            
        }
    }
    
    
//    func get_Active(){
//
//        self.showLoadingActivity()
//        APIManager.sendRequestGetAuth(urlString: "p/get_templates_for_transactions?lang_key=en&projects_work_area_id=1" ) { (response) in
//
//
//            let status = response["status"] as? Bool
//            if status == true{
//                if  let list = response["records"] as? NSArray{
//                    for i in list {
//                        let dict = i as? [String:Any]
//                        let obj = ModuleObj.init(dict!)
//                        self.arr_Active.append(obj)
//                        // for echitem in obj{
//                        self.arr_ActiveLabel.append(obj.label)
//                        // }
//
//                    }
//                    self.hideLoadingActivity()
//                }
//            }
//            self.hideLoadingActivity()
//
//        }
//    }
    
    
    func get_DocumentType(){
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "ZyYkGcK85IUr/DCT01" ) { (response) in
            
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_DocumentType.append(obj)
                        // for echitem in obj{
                        self.arr_DocumentTypeLabel.append(obj.label)
                        // }
                        
                    }
                    self.hideLoadingActivity()
                }
            }
            
            
        }
    }
    
    
    func get_Division(){
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "ZyYkGcK85IUr/ID001" ) { (response) in
            
            
            let status = response["status"] as? Bool
            if status == true{
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ModuleObj.init(dict!)
                        self.arr_Division.append(obj)
                        self.arr_DivisionLabel.append(obj.label)
                      
                        
                    }
                    self.hideLoadingActivity()
                }
            }
            
            
        }
    }
    
    
  
    
    
    @IBAction func btnActive_Click(_ sender: Any) {
        
        self.imgDropActive.image = dropUpmage
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_ActiveLabel
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            if name == self.arr_ActiveLabel[index] {
                self.lblActive.text =  name
                let i =  self.arr_ActiveVlaue[index]
                self.StrActive = i
                self.btnActive.isHidden = false
                self.imgDropActive.image = self.dropDownmage
                self.get_Documents_data(showLoading: true, loadOnly: true)
           }
        }
        self.present(vc, animated: true, completion: nil)
        
        
//        let dropDown = DropDown()
//        dropDown.anchorView = view
//        dropDown.backgroundColor = .white
//        dropDown.cornerRadius = 2.0
//        if self.arr_ActiveLabel.count == 0 {
//            dropDown.dataSource = self.arr_NoData
//            dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            self.imgDropActive.image = dropDownmage
//        }else{
//        dropDown.dataSource = self.arr_ActiveLabel
//
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//
//            if item == self.arr_ActiveLabel[index] {
//                self.lblActive.text =  item
//                let i =  self.arr_ActiveVlaue[index]
//                self.StrActive = i
//                self.btnActive.isHidden = false
//                self.imgDropActive.image = dropDownmage
//                get_Documents_data(showLoading: true, loadOnly: true)
//
//            }
//
//        }}
//        dropDown.direction = .bottom
//        dropDown.anchorView = viewActive
//        dropDown.bottomOffset = CGPoint(x: 0, y: viewActive.bounds.height)
//        dropDown.width = viewActive.bounds.width
//        dropDown.show()
    }
    
    
    @IBAction func btnDocumentType_Click(_ sender: Any) {
        
        
        self.imgDropDocumentType.image = dropUpmage
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_DocumentTypeLabel
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            if name == self.arr_DocumentTypeLabel[index] {
                self.lblDocumentType.text =  name
                let i =  self.arr_DocumentType[index]
                self.StrDocumentType = i.value
                //self.StrsearchGroupTypeCode = i.code
                self.imgDropDocumentType.image = self.dropDownmage
                self.btnDocumentType.isHidden = false
                self.get_Documents_data(showLoading: true, loadOnly: true)
                
            }
        }
        self.present(vc, animated: true, completion: nil)
        
//        let dropDown = DropDown()
//        dropDown.anchorView = view
//        dropDown.backgroundColor = .white
//        dropDown.cornerRadius = 2.0
//
//        if self.arr_DocumentTypeLabel.count == 0 {
//            dropDown.dataSource = self.arr_NoData
//            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//                self.imgDropDocumentType.image = dropDownmage
//            }
//            dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        }else{
//
//        dropDown.dataSource = self.arr_DocumentTypeLabel
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//
//            if item == self.arr_DocumentTypeLabel[index] {
//                self.lblDocumentType.text =  item
//                let i =  self.arr_DocumentType[index]
//                self.StrDocumentType = i.value
//                //self.StrsearchGroupTypeCode = i.code
//                self.imgDropDocumentType.image = dropDownmage
//                self.btnDocumentType.isHidden = false
//                get_Documents_data(showLoading: true, loadOnly: true)
//
//            }
//
//        }}
//        dropDown.direction = .bottom
//        dropDown.anchorView = viewDocumentType
//        dropDown.bottomOffset = CGPoint(x: 0, y: viewDocumentType.bounds.height)
//        dropDown.width = viewDocumentType.bounds.width
//        dropDown.show()
    }
    
    
    
    
    @IBAction func btnDivision_Click(_ sender: Any) {
        
        self.imgDropDivision.image = dropUpmage
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_DivisionLabel
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            if name == self.arr_DivisionLabel[index] {
                self.lblDivision.text =  name
                let i =  self.arr_Division[index].value
                self.StrDivision = i
                self.btnDivision.isHidden = false
                self.imgDropDivision.image = self.dropDownmage
                self.get_Documents_data(showLoading: true, loadOnly: true)
            }
        }
        self.present(vc, animated: true, completion: nil)
        
//        self.imgDropDivision.image = dropUpmage
//        let dropDown = DropDown()
//        dropDown.anchorView = view
//        dropDown.backgroundColor = .white
//        dropDown.cornerRadius = 2.0
//
//        if self.arr_DivisionLabel.count == 0 {
//            dropDown.dataSource = self.arr_NoData
//            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//                self.imgDropDivision.image = dropDownmage
//            }
//            dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        }else{
//
//        dropDown.dataSource = self.arr_DivisionLabel
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//
//            if item == self.arr_DivisionLabel[index] {
//                self.lblDivision.text =  item
//                let i =  self.arr_Division[index].value
//                self.StrDivision = i
//                //self.StrsearchGroup1Code = i
//                self.btnDivision.isHidden = false
//                self.imgDropDivision.image = dropDownmage
//                get_Documents_data(showLoading: true, loadOnly: true)
//            }
//
//        }}
//        dropDown.direction = .bottom
//        dropDown.anchorView = viewDivision
//        dropDown.bottomOffset = CGPoint(x: 0, y: viewDivision.bounds.height)
//        dropDown.width = viewDivision.bounds.width
//        dropDown.show()
    }
    

    
    @IBAction func btnActiveDelete_Click(_ sender: Any) {
        self.lblActive.text = "txt_Active".localized()
        self.btnActive.isHidden = true
        self.StrActive = ""
        get_Documents_data(showLoading: true, loadOnly: true)
    }
    
    @IBAction func btnDocumentTypeDelete_Click(_ sender: Any) {
        self.lblDocumentType.text = "txt_DocumentType".localized()
        self.btnDocumentType.isHidden = true
        self.StrDocumentType = ""
        get_Documents_data(showLoading: true, loadOnly: true)
    }
    
    @IBAction func btnDivisionDelete_Click(_ sender: Any) {
        self.lblDivision.text = "txt_Division".localized()
        self.btnDivision.isHidden = true
        self.StrDivision = ""
        get_Documents_data(showLoading: true, loadOnly: true)
    }
    
}


extension DocumentsVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTVCell", for: indexPath) as! TransactionTVCell
        
        let obj = arr_data[indexPath.item]
        
        
        let Description = "Description".localized() + "  \(obj.documents_description)"
        let type = "Document Types".localized() + "  \(obj.document_type)"
        let from = "Specific Item Divisions".localized() + "  \(obj.document_sub_type)"
        
        let to = "File Level".localized() + "  \(obj.level_keys)"
        let Status = "Status".localized() + "  \(obj.documents_file_status)"
        
        let writer = "Writer".localized() + "  \(obj.writer)"
        let LastUpdate = "On Date".localized() + "  \(obj.created_datetime)"
        
        
       
        cell.lblKeyDesc.text = Description
        cell.lblKeyFrom.text = from
        cell.lblKeyTo.text = to
        cell.lblKeyType.text = type
        cell.lblKeyWriter.text = writer
        cell.lblKeyLastUpdate.text = LastUpdate
        cell.lblKeyStatus.text = Status
        
        cell.lbKeylNo.isHidden = true
        cell.lblKeyModule.isHidden = true
        cell.lblKeyBarCode.isHidden = true
        cell.lblKeySubmitter.isHidden = true
        
        let Descriptionattributed: NSAttributedString = Description.attributedStringWithColor(["Description".localized()], color: HelperClassSwift.acolor.getUIColor())
        cell.lblKeyDesc.attributedText = Descriptionattributed
        
        let fromattributed: NSAttributedString = from.attributedStringWithColor(["Specific Item Divisions".localized()], color: HelperClassSwift.acolor.getUIColor())
        cell.lblKeyFrom.attributedText = fromattributed
        
        let Toattributed: NSAttributedString = to.attributedStringWithColor(["File Level".localized()], color: HelperClassSwift.acolor.getUIColor())
        cell.lblKeyTo.attributedText = Toattributed
        
        
        
        let Typeattributed: NSAttributedString = type.attributedStringWithColor(["Document Types".localized()], color: HelperClassSwift.acolor.getUIColor())
        cell.lblKeyType.attributedText = Typeattributed
        
        let Writerattributed: NSAttributedString = writer.attributedStringWithColor(["Writer".localized()], color: HelperClassSwift.acolor.getUIColor())
        cell.lblKeyWriter.attributedText = Writerattributed
        
        
        let Lastattributed: NSAttributedString = LastUpdate.attributedStringWithColor(["On Date".localized()], color: HelperClassSwift.acolor.getUIColor())
        cell.lblKeyLastUpdate.attributedText = Lastattributed
        
        let Statusattributed: NSAttributedString = Status.attributedStringWithColor(["Status".localized()], color: HelperClassSwift.acolor.getUIColor())
        cell.lblKeyStatus.attributedText = Statusattributed
        
        
        cell.viewBack.setcorner()
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        cell.selectedBackgroundView = backgroundView
        
        return cell
        
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
            get_Documents_data(showLoading: false, loadOnly: false)
        }
    }
}


extension DocumentsVC:UISearchBarDelegate {
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
       self.SearchKey = searchBar.text!
        get_Documents_data(showLoading: false, loadOnly: false)
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
}
