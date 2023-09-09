//
//  SubFormVersionVC.swift
//  Almnabr
//
//  Created by MacBook on 23/12/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class SubFormVersionVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var table: UITableView!
     
    @IBOutlet weak var lblnodata: UILabel!
    
    
    var params = [:] as [String : String]

    
    var arr_data:[FormTransactionObj] = []
    
    var pageNumber = 1
    var allItemDownloaded = false
    
    var ProjectObj:templateObj!
    var platform_code_system:String = ""
    var transaction_separation:String = ""
    
    var FormWirObj:form_wir_dataObj?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SetupTable()
        configNavigation()
        SetUp_param()
        get_Forms()
        SetUp_param()
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
        self.view.backgroundColor = maincolor
        //navigationController?.navigationBar.barTintColor = .buttonBackgroundColor()
        navigationController?.navigationBar.barTintColor = maincolor
       addNavigationBarTitle(navigationTitle: "Form Versions".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
    }
    
    
    
    // MARK: - Setup Table
    
    func SetupTable(){
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "FormVersionTVCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "FormVersionTVCell")
        self.table.reloadData()
    }
    
    
    
    func get_Forms(){
        
        self.showLoadingActivity()
    
        APIController.shard.sendRequestPostAuth(urlString: "form/\(obj_transaction?.transaction_key ?? " ")/cr/3/\(obj_transaction?.transaction_request_id ?? "0")", parameters: self.params ) { (response) in
            self.hideLoadingActivity()
           
            
            let status = response["status"] as? Bool
            let error = response["error"] as? String
            
            if status == true{
                
                let page = response["page"] as? [String:Any]
                
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = FormTransactionObj.init(dict!)
                        self.arr_data.append(obj)
                       
                    }
                    self.table.reloadData()
                    let pageObj = PageObj(page!)
                  
                    if pageObj.total_pages > self.pageNumber {
                        self.allItemDownloaded = false
                    }else{
                        self.allItemDownloaded = true
                    }
                    if list.count == 0 {
                        self.lblnodata.isHidden = false
                    }else{
                        self.lblnodata.isHidden = true
                    }
                    self.hideLoadingActivity()
                }
            }else{
                self.table.isHidden = true
                self.lblnodata.isHidden = false
                self.showAMessage(withTitle: "error", message: error ?? "some thing went wrong")
            }

            
           
            }
        }

    
    
    func SetUp_param(){
        
         
        self.lblnodata.font = .kufiRegularFont(ofSize: 15)
        self.lblnodata.textColor =  HelperClassSwift.acolor.getUIColor()
        
        self.params["projects_work_area_id"] = obj_FormWir?.projects_work_area_id
        
        self.params["platform_code_system"] = self.platform_code_system
        self.params["template_id"] = FormWirObject?.template_id
        self.params["lang_key"] = "en"
        self.params["transaction_separation"] = "0"
        self.params["page_no"] = "1"
        self.params["page_size"] = "10"
        self.params["work_site"] = "GN"
        self.params["method"] = "VIEW"
     
        for i in arr_form_unit_level{
            self.params["units_and_level[\(i.work_level_key )]"] = i.unit_id
        }
        
        
    }
    
    @IBAction func btnBack_Click(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }

}



extension SubFormVersionVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
      
            return arr_data.count
    
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
            let cell = tableView.dequeueReusableCell(withIdentifier: "FormVersionTVCell", for: indexPath) as! FormVersionTVCell
            
            let obj = arr_data[indexPath.item]
         
      
        let TransactionNo = "Transaction Number".localized() +  ": \(obj.transaction_request_id)"
        let Unit = "Unit".localized() + ": \(obj.unit_id)"
        let WorkLevel = "Work Level".localized() + ": \(obj.levelname)"
        let Barcode = "\(obj.tbv_barcodeData)"
        let Result = "Evaluation Result".localized() + ": \(obj.result_code)"
        let Date = "\(obj.transactions_date_datetime)"

        cell.lblDate.text = Date
        cell.lblBarCode.text = Barcode
        
        let TransactionNoattribute: NSAttributedString = TransactionNo.attributedStringWithColor(["Transaction Number"], color: maincolor)
        cell.lblTransactionNo.attributedText = TransactionNoattribute
        
        let Unitattribute: NSAttributedString = Unit.attributedStringWithColor(["Unit"], color: maincolor)
        cell.lblUnit.attributedText = Unitattribute
        
        let WorkLevelattribute: NSAttributedString = WorkLevel.attributedStringWithColor(["Work Level"], color: maincolor)
        cell.lblWL.attributedText = WorkLevelattribute
        
        let Resultattribute: NSAttributedString = Result.attributedStringWithColor(["Evaluation Result"], color: maincolor)
        cell.lblEvalutionResult.attributedText = Resultattribute
        
        
        
            
        if obj.file_path != "" {
            cell.btnAction.isHidden = false
        }else{
            cell.btnAction.isHidden = true
        }
           
        switch obj.color {
        case "RED":
            cell.viewStatus.backgroundColor = .red
        case "ORANGE":
            cell.viewStatus.backgroundColor = .orange
        default:
            cell.viewStatus.backgroundColor = .lightGray
        }
        
                    // cell.viewBack.setcorner()
         
                     return cell
            
        
  
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let obj = arr_data[indexPath.item]
        if obj.file_path != "" {
        let vc:PDFViewrVC  = AppDelegate.mainSB.instanceVC()
        vc.isModalInPresentation = true
        vc.definesPresentationContext = true
        vc.Strurl = obj.file_path
        self.present(vc, animated: true, completion: nil)
    }
        
    }

}


