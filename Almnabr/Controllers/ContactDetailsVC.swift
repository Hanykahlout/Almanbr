//
//  ContactDetailsVC.swift
//  Almnabr
//
//  Created by MacBook on 30/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ContactDetailsVC: UIViewController {

    @IBOutlet weak var btnPrimaryMobile: UIButton!
    @IBOutlet weak var btnPrimaryEmailAddress: UIButton!
    @IBOutlet weak var lblPrimaryAddress: UILabel!
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var img_nodata: UIImageView!
    @IBOutlet weak var viewsearch: UIView!
    
    
    var profile_obj:ProfileObj?
    
    var SearchKey:String = ""
    var pageNumber = 1
    var arr_data:[ProfileContactObj] = []
    var allItemDownloaded = false
    var params:[String:Any] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configNavigation()
        configGUI()
        get_data(showLoading: true, loadOnly: true)
       
    }
    //ProfileContactTVCell
    
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
       addNavigationBarTitle(navigationTitle: "Contact Details".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
    }

    
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
       
        
        self.viewsearch.setBorderGrayWidthCorner(1, 20)
        btnPrimaryMobile.setTitle(profile_obj?.primary_mobile, for: .normal)
        btnPrimaryEmailAddress.setTitle(profile_obj?.primary_email, for: .normal)
        lblPrimaryAddress.text = profile_obj?.primary_address
        
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "ProfileContactTVCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "ProfileContactTVCell")
      
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
        
        
                                       
        APIController.shard.sendRequestPostAuth(urlString: "my_contacts/\(pageNumber)/10", parameters: self.params ) { (response) in
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
                        let obj = ProfileContactObj.init(dict!)
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
    
    
    @IBAction func btnEmail_Click(_ sender: Any) {
        
        let email = profile_obj?.primary_email
        if let url = URL(string: "mailto:\(email ?? "www")") {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
        
    }
    
    @IBAction func btnMobile_Click(_ sender: Any) {
        
        if let phoneCallURL = URL(string: "tel://\(profile_obj?.primary_mobile)") {

          let application:UIApplication = UIApplication.shared
          if (application.canOpenURL(phoneCallURL)) {
              application.open(phoneCallURL, options: [:], completionHandler: nil)
          }
        }
        
    }
}



extension ContactDetailsVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileContactTVCell", for: indexPath) as! ProfileContactTVCell
        
        let obj = arr_data[indexPath.item]
 
       
       
        let ContactAddress  = "Contact Address".localized() + ": \(obj.contact_address_text)"
        let writer = "By".localized() + ": \(obj.name)"
        
        cell.lblPersonName.text = obj.contact_person_name
        cell.lblOnDate.text = obj.contact_createddatetime
        cell.lblEmail.text = obj.contact_email_address
        cell.lblMobile.text = obj.contact_mobile_number
        
        let writerattributed: NSAttributedString = writer.attributedStringWithColor(["By".localized()], color: maincolor)
        cell.lblWriter.attributedText = writerattributed
        
        let ContactAddressattributed: NSAttributedString = ContactAddress.attributedStringWithColor(["Contact Address".localized()], color: maincolor)
        cell.lblContactAddress.attributedText = ContactAddressattributed

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
