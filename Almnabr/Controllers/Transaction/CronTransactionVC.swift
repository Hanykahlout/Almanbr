//
//  CronTransactionVC.swift
//  Almnabr
//
//  Created by MacBook on 04/10/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import DPLocalization
import FontAwesome_swift
import DropDown

class CronTransactionVC: UIViewController {
    
    @IBOutlet weak var header: HeaderView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableHeightConstraint:NSLayoutConstraint!
    
    @IBOutlet weak var view_refresh: UIView!
    @IBOutlet weak var btnRefrsh: UIButton!
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var imgnodata: UIImageView!
    
    var StrTitle:String = ""
    var StrSubMenue:String = ""
    
    var pageNumber = 1
    var allItemDownloaded = false
    var MenuObj:MenuObj?
    var SubMenuObj:MenuObj?
    var arr_data:[CronJobObj] = []
  
    var cellWidths: [CGFloat] = [700]
    
    let fontStyle: FontAwesomeStyle = .solid
    

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        configGUI()
        get_Transaction_data(showLoading: true, loadOnly: true)
        header.btnAction = self.menu_select
      
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
        
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "CornTransactionTVCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "CornTransactionTVCell")
 
        view_refresh.layer.applySketchShadow(
          color: .gray,
          alpha: 0.6,
          x: 0,
          y: 1,
          blur: 1,
          spread: 0)
        
    }
    
    
    
    
    func get_Transaction_data(showLoading: Bool, loadOnly: Bool){
        
        if showLoading {
            self.showLoadingActivity()
        }
        APIController.shard.sendRequestGetAuth(urlString: "/tc/cronjoblist" ) { (response) in
            
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
                        let obj = CronJobObj.init(dict!)
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
                    self.hideLoadingActivity()
                }
                
            }else{
                self.hideLoadingActivity()
                self.imgnodata.isHidden = false
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
    
    
    @IBAction func btnRefresh_Click(_ sender: Any) {
       
        get_Transaction_data(showLoading: true, loadOnly: true)
    }
    
}



extension CronTransactionVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CornTransactionTVCell", for: indexPath) as! CornTransactionTVCell
        
        let obj = arr_data[indexPath.item]
        
        let Id = "\(obj.transaction_request_id)"
        let FormName = "Form Name".localized() + ":  \(obj.transaction_key)"
        let Attempt =  "\(obj.transactions_cronjob_try_to_submitting)"
        let lastUpdate = "\(obj.transactions_cronjob_last_update)"
        let Error = "Error".localized() + ":  \(obj.transactions_cronjob_err)"
        
        let maincolor = "#1A3665".getUIColor()
        
        cell.lblNo.text = Id
        
        let FormNameattributed: NSAttributedString = FormName.attributedStringWithColor(["Form Name".localized()], color: maincolor)
        cell.lblFormName.attributedText = FormNameattributed
        
        let Attemptattributed: NSAttributedString = Attempt.attributedStringWithColor(["Attempt".localized()], color: maincolor)
        cell.lblAttempt.attributedText = Attemptattributed
        
        cell.lblLastUpdate.text = lastUpdate
        
        
       
        let Errorattributed: NSAttributedString = Error.attributedStringWithColor(["Error".localized()], color: .red)
        cell.lblError.attributedText = Errorattributed
        
        
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.tag == 0 {
            
            
            print(indexPath.item)
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
    
