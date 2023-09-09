//
//  TicketDetailsVC.swift
//  Almnabr
//
//  Created by MacBook on 05/05/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class TicketDetailsVC: UIViewController {
    
    @IBOutlet weak var table_user: UITableView!
    @IBOutlet weak var lbl_ticket: UILabel!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_From: UILabel!
    @IBOutlet weak var lbl_To: UILabel!
    @IBOutlet weak var lbl_nearlyDate: UILabel!
    @IBOutlet weak var lbl_type: UILabel!
    @IBOutlet weak var lbl_signnatutre: UILabel!
    @IBOutlet weak var lbl_Property: UILabel!
    @IBOutlet weak var lbl_note: UILabel!
    @IBOutlet weak var lbl_desc: UILabel!
    @IBOutlet var tableHeight: NSLayoutConstraint!
    
    var object:TicketObj?
    var ticket_id:String = ""
    
    var arr_user:[HistoryObj] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get_data()
        configNavigation()
        get_emp_in_ticket()
        //        setupAddButtonItem()
        //TaskUserTVCell
    }
    
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        //        self.tableHeight?.constant = self.table_user.contentSize.height
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
        addNavigationBarTitle(navigationTitle: "Ticket Details".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
        
        //square.and.pencil
    }
    
    func setupAddButtonItem() {
        // let EditButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapEditButton(_:)))
        
        
        let EditImage  = UIImage.fontAwesomeIcon(name: .penSquare , style: .solid, textColor:  .white, size: CGSize(width: 25, height: 25))
        
        let EditButton   = UIBarButtonItem(image: EditImage,  style: .plain, target: self, action: #selector(didTapEditButton(sender:)))
        navigationItem.rightBarButtonItems = [EditButton]
        
        
    }
    
    @objc func didTapEditButton(sender: AnyObject){
        let vc:AddTicketVC = AppDelegate.TicketSB.instanceVC()
        vc.object =  object
        vc.users = self.arr_user
        vc.isEdit = true
        vc.ticket_id =  self.ticket_id
        vc.delegate = {
            self.get_data()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    //AhmedabuShahed95
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        
        self.lbl_ticket.font = .kufiRegularFont(ofSize: 14)
        self.lbl_ticket.text = "Ticket".localized()
        
        let No = "No.".localized() + ": \(object?.ticket_no ?? "---")        "
        let title = No +  "Subject".localized() + ": \(object?.ticket_titel ?? "---")"
        
        let title_atr: NSAttributedString = title.attributedStringWithColor(["Title".localized(),"No.".localized()], color: maincolor)
        self.lbl_title.attributedText = title_atr
        self.lbl_title.font = .kufiRegularFont(ofSize: 14)
        
        let From = "From".localized() + ": \(object?.start_date ?? "---")"
        let From_atr: NSAttributedString = From.attributedStringWithColor(["From".localized()], color: maincolor)
        self.lbl_From.attributedText = From_atr
        self.lbl_From.font = .kufiRegularFont(ofSize: 14)
        
        let To = "To".localized() + ": \(object?.end_date ?? "--/--/--")"
        let To_atr: NSAttributedString = To.attributedStringWithColor(["To".localized()], color: maincolor)
        self.lbl_To.attributedText = To_atr
        self.lbl_To.font = .kufiRegularFont(ofSize: 14)
        
        self.lbl_nearlyDate.text = object?.end_date_nearly ?? "---"
        self.lbl_nearlyDate.font = .kufiRegularFont(ofSize: 14)
        
        let Type = "Type".localized() + ": \(object?.ticket_type_name ?? "---")"
        let Type_atr: NSAttributedString = Type.attributedStringWithColor(["Type".localized()], color: maincolor)
        self.lbl_type.attributedText = Type_atr
        self.lbl_type.font = .kufiRegularFont(ofSize: 14)
        
        let signature = "Signature".localized() + ": \(object?.sig_name ?? "---")"
        let signature_atr: NSAttributedString = signature.attributedStringWithColor(["Signature".localized()], color: maincolor)
        self.lbl_signnatutre.attributedText = signature_atr
        self.lbl_signnatutre.font = .kufiRegularFont(ofSize: 14)
        
        let priorty = "Priorty".localized() + ": \(object?.important_name ?? "---")"
        let priorty_atr: NSAttributedString = priorty.attributedStringWithColor(["Priorty".localized()], color: maincolor)
        self.lbl_Property.attributedText = priorty_atr
        self.lbl_Property.font = .kufiRegularFont(ofSize: 14)
        
        let note = "Description".localized() + ": \(object?.notes ?? "---")"
        let note_atr: NSAttributedString = note.attributedStringWithColor(["Description".localized()], color: maincolor)
        self.lbl_note.attributedText = note_atr
        self.lbl_note.font = .kufiRegularFont(ofSize: 14)
        
        let desc = "Note".localized() + ": \(object?.ticket_detalis ?? "---")"
        let desc_atr: NSAttributedString = desc.attributedStringWithColor(["Note".localized()], color: maincolor)
        self.lbl_desc.attributedText = desc_atr
        self.lbl_desc.font = .kufiRegularFont(ofSize: 14)
        
        
        table_user.dataSource = self
        table_user.delegate = self
        let nib = UINib(nibName: "TaskUserTVCell", bundle: nil)
        table_user.register(nib, forCellReuseIdentifier: "TaskUserTVCell")
        
        if object?.is_ticket_admin == true {
            self.setupAddButtonItem()
        }
        
    }
    
    
    
    func get_data(){
        
        self.showLoadingActivity()
        
        let param:[String:Any] = ["ticket_id" : self.ticket_id]
        APIController.shard.sendRequestPostAuth(urlString: "tasks/get_ticket_row", parameters: param ) { (response) in
            self.hideLoadingActivity()
            
            let status = response["status"] as? Bool
            
            if status == true{
                
                if  let data = response["data"] as? [String:Any]{
                    
                    let obj =  TicketObj(data)
                    self.object = obj
                }
                self.configGUI()
            }
        }
    }
    
    func get_emp_in_ticket(){
        
        self.showLoadingActivity()
        
        let param:[String:Any] = ["ticket_id" : self.ticket_id]
        APIController.shard.sendRequestPostAuth(urlString: "tasks/emp_in_ticket", parameters: param ) { (response) in
            self.hideLoadingActivity()
            
            let status = response["status"] as? Bool
            
            self.table_user.reloadData()
            if status == true{
                
                if  let records = response["data"] as? NSArray{
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj =  HistoryObj.init(dict!)
                        self.arr_user.append(obj)
                    }
                    
                    self.table_user.reloadData()
                    self.hideLoadingActivity()
                }
                
            }else{
                self.hideLoadingActivity()
            }
        }
    }
    
    
    
    func unfollow_emp(emp_id:String){
        
        self.showLoadingActivity()
        
        let param : [String:Any] = ["ticket_id" : self.ticket_id,
                                    "emp_id" : emp_id]
        
        APIController.shard.sendRequestPostAuth(urlString: "tasks/unfollow_emp_by_admin", parameters: param ) { (response) in
            self.hideLoadingActivity()
            
            let status = response["status"] as? Bool
            let message = response["message"] as? [String:Any]
            
            if status == true{
                if let message = message?["msg"] as? String {
                    self.showAMessage(withTitle: "", message: message,  completion: {
                        
                        self.dismiss(animated: true)
                    })
                }
                
            }else{
                let error = response["error"] as? String ?? "something went wrong"
                self.showAMessage(withTitle: "error".localized(), message:  error)
                
            }
            self.hideLoadingActivity()
            
        }
    }
    
    
    func prevent_unfollow(emp_id:String){
        
        self.showLoadingActivity()
        
        let param : [String:Any] = ["ticket_id" : self.ticket_id,
                                    "emp_id" : emp_id]
        
        APIController.shard.sendRequestPostAuth(urlString: "tasks/prevent_unfollow", parameters: param ) { (response) in
            self.hideLoadingActivity()
            
            let status = response["status"] as? Bool
            let message = response["message"] as? [String:Any]
            
            if status == true{
                if let message = message?["msg"] as? String {
                    self.showAMessage(withTitle: "", message: message,  completion: {
                        
                        self.dismiss(animated: true)
                    })
                }
                
            }else{
                let error = response["error"] as? String ?? "something went wrong"
                self.showAMessage(withTitle: "error".localized(), message:  error)
                
            }
            self.hideLoadingActivity()
            
        }
    }
    
    
    @IBAction func btnEdit_Click(_ sender: Any) {
        
    }
    @IBAction func btnAddUser_Click(_ sender: Any) {
        
    }
    
}



extension TicketDetailsVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskUserTVCell", for: indexPath) as! TaskUserTVCell
        
        let obj = arr_user[indexPath.item]
        
        
        cell.lblUser.text = obj.emp_name
        cell.lblFirstName.text = obj.firstname_english
        cell.lblLastName.text = obj.lastname_english
        
        cell.btnLockAction = {
            self.prevent_unfollow(emp_id: obj.emp_id)
        }
        
        cell.btnUnfollowAction = {
            self.unfollow_emp(emp_id: obj.emp_id)
        }
        
        self.viewWillLayoutSubviews()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    
    
}
