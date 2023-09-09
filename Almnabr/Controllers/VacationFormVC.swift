//
//  VacationFormVC.swift
//  Almnabr
//
//  Created by MacBook on 30/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
class VacationFormVC: UIViewController {
    
    @IBOutlet weak var lblLastJoiningDate: UILabel!
    @IBOutlet weak var lblVactionBalance: UILabel!
    @IBOutlet weak var lblVactionUsedDays: UILabel!
    @IBOutlet weak var lblVactionUnusedDays: UILabel!
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var img_nodata: UIImageView!
    @IBOutlet weak var viewsearch: UIView!
    @IBOutlet weak var viewAddEdu: UIView!
    
    
    var profile_obj:ProfileObj?
    
    var SearchKey:String = ""
    var pageNumber = 1
    var arr_data:[VactionObj] = []
    var allItemDownloaded = false
    var params:[String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigation()
        configGUI()
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
        addNavigationBarTitle(navigationTitle: "Vacation Form".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
    }
    
    
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        
        self.viewsearch.setBorderGrayWidthCorner(1, 20)
        self.viewAddEdu.setBorderGrayWidthCorner(1, 20)
        
       // let Date =  "\(profile_obj?.membership_expiry_date_english ?? "---") - \(profile_obj?.membership_expiry_date_arabic ?? "---")"
        
 
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "VacationFormCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "VacationFormCell")
        
    }
    
    
    func get_data(showLoading: Bool, loadOnly: Bool){
        
        if showLoading {
            self.showLoadingActivity()
        }
        let search:String = SearchKey.replacingOccurrences(of: " ", with: "%20").trim()
        self.params["search_value"] = search
        self.params["employee_number"] = profile_obj?.employee_number
    
        
        APIController.shard.sendRequestPostAuth(urlString: "human_resources/get_employee_vacation_history/\(pageNumber)/10", parameters: self.params ) { (response) in
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
                
                let joining_date = response["joining_date"] as? String
                let used_vacation_total = response["used_vacation_total"] as? String
               // let total = response["total"] as? Int
                let vacation_balance = response["vacation_balance"] as? Int
                
                let LastJoiningDate = "Last Joining Date".localized() + ": \(joining_date ?? "---") "
                let VactionBalance = "Vaction Balance".localized() + ": \( vacation_balance ?? 0) Days"
                let VactionUsedDays = "Vaction Used Days".localized() + ": \(used_vacation_total ?? "-") Days"
                let VactionUnusedDays = "EVaction Unused Days".localized() + ": \(vacation_balance ?? 0 - Int(used_vacation_total ?? "0")!) Days"
                
                
                 let vacation_totalattribute: NSAttributedString = VactionBalance.attributedStringWithColor(["Vaction Balance"], color: maincolor)
                 self.lblVactionBalance.attributedText = vacation_totalattribute
                 
                 let VactionUsedDaysattribute: NSAttributedString = VactionUsedDays.attributedStringWithColor(["Vaction Used Days"], color: maincolor)
                 self.lblVactionUsedDays.attributedText = VactionUsedDaysattribute
                 
                 let VactionUnusedDaysattribute: NSAttributedString = VactionUnusedDays.attributedStringWithColor(["EVaction Unused Days"], color: maincolor)
                 self.lblVactionUnusedDays.attributedText = VactionUnusedDaysattribute
                
                let attribute: NSAttributedString = LastJoiningDate.attributedStringWithColor(["Last Joining Date"], color: maincolor)
                self.lblLastJoiningDate.attributedText = attribute
                
                if  let records = response["records"] as? NSArray{
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj =  VactionObj.init(dict!)
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
    
    
    @IBAction func addAction(_ sender: Any) {
        
        checkEmpContractStatus()
    }
    
}



extension VacationFormVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VacationFormCell", for: indexPath) as! VacationFormCell
        
        let obj = arr_data[indexPath.item]
        
        let VacationType = "Vacation Type".localized() + ": \(obj.vacation_type_name)"
        let Start = "Start".localized() + ": \(obj.vacation_start_date_english)"
        let End = "End".localized() + ": \(obj.vacation_end_date_english)"
        let TotalDays = "Total Days".localized() + ": \(obj.vacation_total_days)"
        
        
        var str_status:String = ""
        if obj.approved_status == "1"{
            str_status = "Approved"
        }else{
            str_status = "Rejected"
        }
        let Status = "Status".localized() + ": \(str_status)"
        
        
        let VacationTypeattributed: NSAttributedString = VacationType.attributedStringWithColor(["Vacation Type".localized()], color: maincolor)
        cell.lblVacationType.attributedText = VacationTypeattributed
        
        let Startattribute: NSAttributedString = Start.attributedStringWithColor(["Start"], color: maincolor)
        cell.lblStartDate.attributedText = Startattribute
        
        let Endattribute: NSAttributedString = End.attributedStringWithColor(["End"], color: maincolor)
        cell.lblEndDate.attributedText = Endattribute
        
        let TotalDaysattribute: NSAttributedString = TotalDays.attributedStringWithColor(["Total Days"], color: maincolor)
        cell.lblTotalDays.attributedText = TotalDaysattribute
        
        let Statusattribute: NSAttributedString = Status.attributedStringWithColor(["Status"], color: maincolor)
        cell.lblStatus.attributedText = Statusattribute
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = VactionViewController()
//        vc.transaction_request_id = arr_data[indexPath.item].tra
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
            get_data(showLoading: false, loadOnly: true)
        }
    }
}

// MARK: - API Handling
extension VacationFormVC{
    private func checkEmpContractStatus(){
        showLoadingActivity()
        APIController.shard.getEmpInfoForVaction(empNum: profile_obj?.employee_number ?? "") {  data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    let vc =  AddVacationViewController()
                    vc.empId = self.profile_obj?.employee_number ?? ""
                    vc.contractInfo = data.result?.contract_vacation_info
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    
}
