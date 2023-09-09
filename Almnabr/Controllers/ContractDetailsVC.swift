//
//  ContractDetailsVC.swift
//  Almnabr
//
//  Created by MacBook on 30/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ContractDetailsVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var img_nodata: UIImageView!
    @IBOutlet weak var viewsearch: UIView!
    
    var profile_obj:ProfileObj?
    var SearchKey:String = ""
    var pageNumber = 1
    var arr_data:[ContractObj] = []
    var allItemDownloaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configGUI()
        configNavigation()
        get_Contract(showLoading: true, loadOnly: true)
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
       addNavigationBarTitle(navigationTitle: "Contract Details".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
    }

    
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        self.viewsearch.setBorderGrayWidthCorner(1, 20)
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "ContractTVCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "ContractTVCell")
      
        
    }
    func get_Contract(showLoading: Bool, loadOnly: Bool){
        
        if showLoading {
            self.showLoadingActivity()
        }
        
        let search:String = SearchKey.replacingOccurrences(of: " ", with: "%20").trim()
        //get_profile_contract_lists/1/10?search_key=&id=7
        
        APIController.shard.sendRequestGetAuth(urlString: "get_profile_contract_lists/\(pageNumber)/10?search_key=\(search)&id=\(profile_obj?.employee_number ?? "0")" ) { (response) in
            
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
                        let obj = ContractObj.init(dict!)
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
            }
            
            
        }
    }
    
    

}

extension ContractDetailsVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContractTVCell", for: indexPath) as! ContractTVCell
        
        let obj = arr_data[indexPath.item]
      
        
        let ContractDate = "Contract Date".localized() + ":  \(obj.contract_start_date_arabic) - \(obj.contract_start_date_english)"
        let ApprovedDate =  "\(obj.contract_approved_date_arabic) - \(obj.contract_approved_date_english)"
        let writer = "By".localized() + ": \(obj.writer)"
        
        cell.lblSubject.text = obj.subject
        cell.lblWorkDomain.text = obj.work_domain
        cell.lblWorkLocation.text = obj.work_location
        cell.lblApprovedDate.text = ApprovedDate 

        let maincolor = "#1A3665".getUIColor()
        let Dateattribute: NSAttributedString = ContractDate.attributedStringWithColor(["Contract Date"], color: maincolor)
        cell.lblContractDate.attributedText = Dateattribute
        
        
        let Writerattributed: NSAttributedString = writer.attributedStringWithColor(["By".localized()], color: maincolor)
        cell.lblWriter.attributedText = Writerattributed

        cell.lblSubject.textColor = maincolor
       
        if obj.contract_status == "1" {
            cell.viewStatus.backgroundColor = "32CD32".getUIColor()
        }else{
            cell.viewStatus.backgroundColor = "FF0000".getUIColor()
        }
      
        
//        cell.viewBack.layer.applySketchShadow(
//          color: .black,
//          alpha: 0.6,
//          x: 4,
//          y: 4,
//          blur: 5,
//          spread: 0)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = NewContractVC()
        let obj = arr_data[indexPath.row]
        print("SAAAAa",obj.transaction_request_id)
        vc.transaction_request_id = obj.transaction_request_id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        
        
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
                get_Contract(showLoading: false, loadOnly: true)
            }
       }
}
    
