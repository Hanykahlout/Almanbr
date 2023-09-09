//
//  JobDetailsVC.swift
//  Almnabr
//
//  Created by MacBook on 30/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class JobDetailsVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var img_nodata: UIImageView!
    @IBOutlet weak var viewsearch: UIView!
    
    var profile_obj:ProfileObj?
    var SearchKey:String = ""
    var pageNumber = 1
    var arr_data:[JobDetailsObj] = []
    var allItemDownloaded = false
    var params:[String:Any] = [:]
    
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
       addNavigationBarTitle(navigationTitle: "Job Details".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
    }
 
    
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        self.viewsearch.setBorderGrayWidthCorner(1, 20)
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "JobDetailsTVCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "JobDetailsTVCell")
      
        
    }
    
    func get_data(showLoading: Bool, loadOnly: Bool){
        
        if showLoading {
            self.showLoadingActivity()
        }
        let search:String = SearchKey.replacingOccurrences(of: " ", with: "%20").trim()
        self.params["search_key"] = search
        self.params["id"] = profile_obj?.employee_number
        self.params["branch_id"] = profile_obj?.branch_id
        
        
                                       
        APIController.shard.sendRequestPostAuth(urlString: "my_positions/\(pageNumber)/10", parameters: self.params ) { (response) in
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
                if  let records = response["records"] as? NSArray{
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj = JobDetailsObj.init(dict!)
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

extension JobDetailsVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobDetailsTVCell", for: indexPath) as! JobDetailsTVCell
        
        let obj = arr_data[indexPath.item]
      
        
        let Positions = "Positions".localized() + ":  \(obj.postition_name)"
        let Description = "Description".localized() + ":  \(obj.job_descriptions)"
        let writer = "By".localized() + ": \(obj.name)"
        
        var licence :String = "No"
        if obj.settings_need_licence == "0"{
            licence = "No"
        }else{
            licence = "Yes"
        }
        let needLicence = "Need Licences ?".localized() + licence
        
        let Positionsattribute: NSAttributedString = Positions.attributedStringWithColor(["Positions"], color: maincolor)
        cell.lblPositions.attributedText = Positionsattribute
        
        let Descriptionattribute: NSAttributedString = Description.attributedStringWithColor(["Description"], color: maincolor)
        cell.lblDescription.attributedText = Descriptionattribute
        
        let needLicenceattribute: NSAttributedString = needLicence.attributedStringWithColor(["Need Licences ?"], color: maincolor)
        cell.lblNeedLicences.attributedText = needLicenceattribute
        
        let Writerattributed: NSAttributedString = writer.attributedStringWithColor(["By".localized()], color: maincolor)
        cell.lblWriter.attributedText = Writerattributed

        cell.lblCreatedDate.text = obj.created_datetime

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//                let obj = arr_data[indexPath.item]
//                let vc:ProjectDetailsVC = AppDelegate.mainSB.instanceVC()
//                vc.title =  self.title
//                vc.Object = obj
//                vc.MenuObj = self.MenuObj
//                vc.StrSubMenue =  self.StrSubMenue
//                vc.StrMenue = self.StrMenue
//        self.navigationController?.pushViewController(vc, animated: true)
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
                get_data(showLoading: false, loadOnly: true)
            }
       }
}
   
