//
//  EducationDetailsVC.swift
//  Almnabr
//
//  Created by MacBook on 30/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class EducationDetailsVC: UIViewController {

    @IBOutlet weak var lblGraduation: UILabel!
    @IBOutlet weak var lblGraduationYear: UILabel!
    @IBOutlet weak var lblMembershipNumber: UILabel!
    @IBOutlet weak var lblExpiryDate: UILabel!
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var img_nodata: UIImageView!
    @IBOutlet weak var viewsearch: UIView!
    @IBOutlet weak var viewAddEdu: UIView!
    
    @IBOutlet weak var btnAddEdu: UIButton!
    
    var profile_obj:ProfileObj?
    
    var SearchKey:String = ""
    var pageNumber = 1
    var arr_data:[EducationObj] = []
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
       addNavigationBarTitle(navigationTitle: "Education Details".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
    }


    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
       
        
        self.viewsearch.setBorderGrayWidthCorner(1, 20)
        self.viewAddEdu.setBorderGrayWidthCorner(1, 20)
        
        let Date =  "\(profile_obj?.membership_expiry_date_english ?? "---") - \(profile_obj?.membership_expiry_date_arabic ?? "---")"

        
        let Graduation = "Graduation".localized() + ": \(profile_obj?.primary_education_level ?? "---")"
        let GraduationYear = "Graduation Year".localized() + ": \(profile_obj?.primary_graduation_year ?? "---")"
        let MembershipNumber = "Membership Number".localized() + ": \(profile_obj?.membership_number ?? "---")"
        let ExpiryDate = "Expiry Date".localized() + ": \(Date)"
        
        
        let Graduationattribute: NSAttributedString = Graduation.attributedStringWithColor(["Graduation"], color: maincolor)
        self.lblGraduation.attributedText = Graduationattribute
        
        let GraduationYearattribute: NSAttributedString = GraduationYear.attributedStringWithColor(["Graduation Year"], color: maincolor)
        self.lblGraduationYear.attributedText = GraduationYearattribute
        
        let MembershipNumberattribute: NSAttributedString = MembershipNumber.attributedStringWithColor(["Membership Number"], color: maincolor)
        self.lblMembershipNumber.attributedText = MembershipNumberattribute
        
        let ExpiryDateattribute: NSAttributedString = ExpiryDate.attributedStringWithColor(["Expiry Date"], color: maincolor)
        self.lblExpiryDate.attributedText = ExpiryDateattribute
        
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "EducationTVCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "EducationTVCell")
        
    }

    
    func get_data(showLoading: Bool, loadOnly: Bool){
        
        if showLoading {
            self.showLoadingActivity()
        }
        let search:String = SearchKey.replacingOccurrences(of: " ", with: "%20").trim()
        self.params["search_key"] = search
        self.params["employee_id_number"] = profile_obj?.employee_id_number
        self.params["id"] = profile_obj?.employee_number
        self.params["branch_id"] = profile_obj?.branch_id
        
        
                                       
        APIController.shard.sendRequestPostAuth(urlString: "my_educations/\(pageNumber)/10", parameters: self.params ) { (response) in
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
                        let obj = EducationObj.init(dict!)
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



extension EducationDetailsVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EducationTVCell", for: indexPath) as! EducationTVCell
        
        let obj = arr_data[indexPath.item]
      
        cell.lblTitle.text = obj.education_title
        cell.lblDescription.text = obj.education_descriptions
        cell.lblDate.text = obj.education_createddatetime
        
        let From = "From".localized() + ": \(obj.education_start_date)"
        let To = "To".localized() + ": \(obj.education_end_date)"
       
        let writer = "By".localized() + ": \(obj.name)"
        
        let Writerattributed: NSAttributedString = writer.attributedStringWithColor(["By".localized()], color: maincolor)
        cell.lblWriter.attributedText = Writerattributed
     
        let Fromattribute: NSAttributedString = From.attributedStringWithColor(["From"], color: maincolor)
        cell.lblFrom.attributedText = Fromattribute
        
        let Toattribute: NSAttributedString = To.attributedStringWithColor(["To"], color: maincolor)
        cell.lblTo.attributedText = Toattribute
        

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
   
