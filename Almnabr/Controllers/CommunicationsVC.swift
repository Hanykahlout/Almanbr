//
//  CommunicationsVC.swift
//  Almnabr
//
//  Created by MacBook on 30/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import FontAwesome_swift

class CommunicationsVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var img_nodata: UIImageView!
    @IBOutlet weak var viewsearch: UIView!
    
    @IBOutlet weak var lblsearchOutgoing: UILabel!
    @IBOutlet weak var viewsearchOutgoing: UIView!
    @IBOutlet weak var imgDropOutgoing: UIImageView!
    
    
    var SearchKey:String = ""
    var SearchFilter:String = "FORM_C1"
    var pageNumber = 1
    var arr_data:[CommunicationsObj] = []
    var allItemDownloaded = false
    var params:[String:Any] = [:]
    
    var arr_Filter:[String] = ["Incoming".localized(),"Outgoing".localized()]
    var arr_value: [String] = ["FORM_C2", "FORM_C1"]
    var arr_NoData:[String] = ["No items found".localized()]
    
    var profile_obj:ProfileObj?
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configGUI()
        configNavigation()
        get_data(showLoading: true, loadOnly: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Config Navigation
    func configNavigation() {
        
        _ = self.navigationController?.preferredStatusBarStyle
        self.view.backgroundColor = maincolor //F0F4F8
        //navigationController?.navigationBar.barTintColor = .buttonBackgroundColor()
        navigationController?.navigationBar.barTintColor = maincolor
       addNavigationBarTitle(navigationTitle: "Communications".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
    }

    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        self.viewsearch.setBorderGrayWidthCorner(1, 20)
        self.viewsearchOutgoing.setBorderGrayWidthCorner(1, 20)
        
        self.imgDropOutgoing.image = dropDownmage
        
        self.lblsearchOutgoing.font = .kufiRegularFont(ofSize: 15)
        self.lblsearchOutgoing.text = "Outgoing".localized()
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "CommunicationsTVCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "CommunicationsTVCell")
       
    }
    
    func get_data(showLoading: Bool, loadOnly: Bool){
        
        if showLoading {
            self.showLoadingActivity()
        }
        let search:String = SearchKey.replacingOccurrences(of: " ", with: "%20").trim()
        self.params["search_key"] = search
        self.params["extra[module_key]"] = "human_resources"
        self.params["extra[transaction_key]"] = SearchFilter
        self.params["extra[employee_number]"] = profile_obj?.employee_number
        self.params["page_num"] = pageNumber
        self.params["page_size"] = "10"
        
        
                                       
        APIController.shard.sendRequestPostAuth(urlString: "ccustom/human_resources_list", parameters: self.params ) { (response) in
            self.hideLoadingActivity()
            
            if self.pageNumber == 1 {
                self.arr_data.removeAll()
            }
            let status = response["status"] as? Bool
            if loadOnly {
                self.table.reloadData()
            }
            
            
            let page = response["page"] as? [String:Any]
            if status == true{
                if  let records = response["list"] as? NSArray{
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj = CommunicationsObj.init(dict!)
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
                self.img_nodata.isHidden = false
               // self.table.isHidden = true
                self.hideLoadingActivity()
            }
            
            
        }
    }
    
    @IBAction func btnSearchOngoing_Click(_ sender: Any) {
        
      
        self.imgDropOutgoing.image = dropUpmage
        
        let dropDown = DropDown()
        dropDown.anchorView = view
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 2.0
        
        dropDown.dataSource = self.arr_Filter
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            if item == self.arr_Filter[index] {
                self.lblsearchOutgoing.text =  item
                let i =  self.arr_value[index]
                self.SearchFilter = i
                self.imgDropOutgoing.image = dropDownmage
                get_data(showLoading: true, loadOnly: true)
            }
            
        }
        dropDown.direction = .bottom
        dropDown.anchorView = viewsearchOutgoing
        dropDown.bottomOffset = CGPoint(x: 0, y: viewsearchOutgoing.bounds.height)
        dropDown.width = viewsearchOutgoing.bounds.width
        dropDown.show()
    }
    
    

}

extension CommunicationsVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommunicationsTVCell", for: indexPath) as! CommunicationsTVCell
        
        let obj = arr_data[indexPath.item]
 
       
        let RequestNo = "\(obj.transaction_request_id)"  + "   Form".localized() + ":  \(obj.communication_types_name)"
        let From = "From".localized() + ": \(obj.communication_from_name)"
        let To = "To".localized() + ": \(obj.communication_to)"
        let Type = "Type".localized() + ": \(obj.communication_types_name)"
        let Module = "Module".localized() + ": \(obj.modules_name)"
        let writer = "Writer".localized() + ": \(obj.communication_user_name_writer)"
        let Submitter = "Submitter".localized() + ": \(obj.transactions_submitter_user_name)"
        let date = "\(obj.communication_date_m) - \(obj.communication_date_h)"
        
        cell.lblBarcode.text = obj.tbv_barcodeData
        cell.lblDate.text = date
        
        let RequestNoattribute: NSAttributedString = RequestNo.attributedStringWithColor(["   Form","\(obj.transaction_request_id)"], color: maincolor)
        cell.lblRequestNo.attributedText = RequestNoattribute
        
        let Fromattribute: NSAttributedString = From.attributedStringWithColor(["From"], color: maincolor)
        cell.lblFrom.attributedText = Fromattribute
        
        let Toattribute: NSAttributedString = To.attributedStringWithColor(["To"], color: maincolor)
        cell.lblTo.attributedText = Toattribute
        
        let Typeattributed: NSAttributedString = Type.attributedStringWithColor(["Type".localized()], color: maincolor)
        cell.lblType.attributedText = Typeattributed
        
        let Moduleattributed: NSAttributedString = Module.attributedStringWithColor(["Module".localized()], color: maincolor)
        cell.lblModule.attributedText = Moduleattributed

        let writerattributed: NSAttributedString = writer.attributedStringWithColor(["Writer".localized()], color: maincolor)
        cell.lblWriter.attributedText = writerattributed
        
        let Submitterattributed: NSAttributedString = Submitter.attributedStringWithColor(["Submitter".localized()], color: maincolor)
        cell.lblSubmitter.attributedText = Submitterattributed

        cell.btn_PdfAction = {
            
            if obj.file_path != "" {
                let vc:PDFViewrVC  = AppDelegate.mainSB.instanceVC()
                
                vc.isModalInPresentation = true
                //vc.modalPresentationStyle = .overFullScreen
                vc.definesPresentationContext = true
                vc.Strurl = obj.file_path
                self.present(vc, animated: true, completion: nil)
            }
        }
            
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let obj = arr_data[indexPath.item]
        if obj.file_path != "" {
        let vc:PDFViewrVC  = AppDelegate.mainSB.instanceVC()
           
        vc.isModalInPresentation = true
        //vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.Strurl = obj.file_path
        self.present(vc, animated: true, completion: nil)
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
                get_data(showLoading: false, loadOnly: true)
            }
       }
}
