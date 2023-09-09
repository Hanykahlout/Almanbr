//
//  AllTicketVC.swift
//  Almnabr
//
//  Created by MacBook on 18/04/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class AllTicketVC: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var img_nodata: UIImageView!
    @IBOutlet weak var view_Add: UIView!
    @IBOutlet weak var view_Filter: UIView!
    @IBOutlet weak var view_Search: UIView!
    @IBOutlet weak var lblMyTransaction : UILabel!
    @IBOutlet weak var lblMyTicket : UILabel!
    @IBOutlet weak var header: HeaderView!
    
    var object:ModulesObj?
    var params:[String:Any] = [:]
    var pageNumber = 1
    var SearchKey:String = ""
    var pushToTransactionS :Bool = false
    var arr_data:[TicketObj] = []
    var allItemDownloaded = false
    var profile_obj:ProfileObj?
    
    var total_records:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        get_Transaction_data()
        configNavigation()
        configGUI()
        get_data(showLoading: true, loadOnly: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        header.btnAction = self.menu_select
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    // MARK: - Config Navigation
    func configNavigation() {
        
        _ = self.navigationController?.preferredStatusBarStyle
        self.view.backgroundColor = .white //F0F4F8
        //navigationController?.navigationBar.barTintColor = .buttonBackgroundColor()
        navigationController?.navigationBar.barTintColor = .white
        addNavigationBarTitleColor(navigationTitle: "Ticket List".localized())
        UINavigationBar.appearance().backgroundColor = .white
        //maincolor
    }
    
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        self.params["ticket_no"] = ""
        self.params["link_issue"] = ""
        self.params["ticket_type"] = ""
        self.params["users"] = ""
        self.params["ticket_status"] = ""
        self.params["important_id"] = ""
        self.params["sig_id"] = ""
        self.params["start_date"] = ""
        self.params["end_date"] = ""
        self.params["ref_model"] = ""
        
        //        self.view_Search.setBorderGrayWidthCorner(1, 20)
        self.view_Search.setBorderColorWidthCorner(1, 20, color: maincolor)
        
        self.view_Add.setBorderGrayWidthCorner(1, 20)
        self.view_Filter.setBorderGrayWidthCorner(1, 20)
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "TicketTVCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "TicketTVCell")
        
        if pushToTransactionS {
            let vc:TransactionsVC = AppDelegate.mainSB.instanceVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        self.lblMyTicket.text = "Tickets".localized()
        
    }
    
    
    
    func get_data(showLoading: Bool, loadOnly: Bool){
        
        if showLoading {
            self.showLoadingActivity()
        }
        let search:String = SearchKey.replacingOccurrences(of: " ", with: "%20").trim()
        
        APIController.shard.sendRequestPostAuth(urlString: "tasks/get_data_ticket/\(pageNumber)/10", parameters: self.params ) { (response) in
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
                
                
                if  let records = response["data"] as? NSArray{
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj =  TicketObj.init(dict!)
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
                    
                    self.lblMyTicket.text = "Tickets".localized() + " (\(pageObj.Str_total_records))"
                    self.hideLoadingActivity()
                }
                
            }else{
                self.hideLoadingActivity()
                self.img_nodata.isHidden = false
            }
        }
    }
    
    func get_Transaction_data(){
        
        //        if showLoading {
        self.showLoadingActivity()
        //        }
        let search:String = SearchKey.replacingOccurrences(of: " ", with: "%20").trim()
        APIController.shard.sendRequestGetAuth(urlString: "tc/list/1/10?searchKey=&searchAdmin=0&searchByForm=&searchByModule=&searchByStatus=all_pending_need_action" ) { (response) in
            
            let status = response["status"] as? Bool
            let total = response["total"] as? Int
            if status == true{
                self.total_records = total ?? 0
                self.lblMyTransaction.text = "My Transactions".localized() + " (\(self.total_records))"
                self.hideLoadingActivity()
            }else{
                self.lblMyTransaction.text = "My Transactions".localized() + " (\(self.total_records))"
                self.hideLoadingActivity()
                
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
    
    func delete_ticket(ticket_id:String){
        
        self.showLoadingActivity()
        let param :[String:Any] = ["ticket_id" : ticket_id]
        
        APIController.shard.sendRequestPostAuth(urlString: "tasks/delete_ticket", parameters: param ) { (response) in
            self.hideLoadingActivity()
            
            let status = response["status"] as? Bool
            let message = response["message"] as? String
            if status == true{
                self.showAMessage(withTitle: "", message: message ?? "Deletion process has been successful", completion: {
                    self.get_data(showLoading: true, loadOnly: true)
                    self.hideLoadingActivity()
                })
            }else{
                self.hideLoadingActivity()
                
            }
        }
    }
    
    
    
    @IBAction func btnAddTicket_Click(_ sender: Any) {
        let vc:AddTicketVC = AppDelegate.TicketSB.instanceVC()
        vc.delegate = {
            self.get_data(showLoading: true, loadOnly: true)
        }
        vc.strTitle = "Add Ticket".localized()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnFilter_Click(_ sender: Any) {
        let vc:TaskFilterVC = AppDelegate.mainSB.instanceVC()
        vc.delegate = {params  in
            
            self.params = params
            self.get_data(showLoading: true, loadOnly: true)
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnMyTransaction_Click(_ sender: Any) {
        let vc:TransactionsVC = AppDelegate.mainSB.instanceVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension AllTicketVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketTVCell", for: indexPath) as! TicketTVCell
        
        let obj = arr_data[indexPath.item]
        
        let Type = "Type".localized() + ": \(obj.ticket_type_name)"
        let Priority = "Priority".localized() + ": \(obj.important_name)"
        let Status = "Status".localized() + ": \(obj.ticket_status_name)"
        let Module = "Module".localized() + ": \(obj.ref_model)"
        
        cell.lblSubject.text = obj.ticket_titel
        cell.lblDateCreated.text = obj.insert_date
        
        if obj.can_delete == false{
            cell.btnDelete.isHidden = true
        }
        
        if obj.can_edit == false{
            cell.btnEdit.isHidden = true
        }
        
        cell.btnEditAction = {
            
            let vc:AddTicketVC = AppDelegate.TicketSB.instanceVC()
            vc.delegate = {
                self.get_data(showLoading: true, loadOnly: true)
            }
            vc.strTitle = "Edit Ticket".localized()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.btnDeleteAction = {
            print("deleted")
            self.delete_ticket(ticket_id: obj.ticket_id)
        }
        
        
        let Typeattributed: NSAttributedString = Type.attributedStringWithColor(["Type".localized()], color: maincolor)
        cell.lblType.attributedText = Typeattributed
        
        let Priorityattributed: NSAttributedString = Priority.attributedStringWithColor(["Priority".localized()], color: maincolor)
        cell.lblpriority.attributedText = Priorityattributed
        
        let Statusattributed: NSAttributedString = Status.attributedStringWithColor(["Status".localized()], color: maincolor)
        cell.lblStatus.attributedText = Statusattributed
        
        let Moduleattributed: NSAttributedString = Module.attributedStringWithColor(["Module".localized()], color: maincolor)
        cell.lblModule.attributedText = Moduleattributed
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc:TicketViewController = AppDelegate.TicketSB.instanceVC()
        let obj = arr_data[indexPath.item]
        vc.object = obj
        vc.ticket_id = obj.ticket_id
        //    vc.delegate = {params  in
        //
        //        self.params = params
        //        self.get_data(showLoading: true, loadOnly: true)
        //    }
        self.navigationController?.pushViewController(vc, animated: true)
        
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



