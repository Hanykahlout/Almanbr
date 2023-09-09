//
//  CheckListCell.swift
//  Almnabr
//
//  Created by MacBook on 14/05/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView

class CheckListCell: UITableViewCell ,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var startEndButton: UIButton!
    
    @IBOutlet weak var editTitleButton: UIButton!
    
    @IBOutlet weak var viewItemsButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var lblPercent: UILabel!
    @IBOutlet weak var Progress: UIProgressView!
    @IBOutlet weak var viewBack: UIView!
    
    @IBOutlet weak var addItemBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var containerStack: UIStackView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var itemTable: UITableView!
    @IBOutlet weak var dropView: UIView! {
        didSet {
            dropView.isHidden = true
        }
    }
    
    var btnStartEndTimer : (() -> Void)?
    var btnEditCheckListTitle : ((_ title:String)->())?
    var btnEditItemAction : ((_ data:SubCheckObj)->())?
    var btnViewItemAction : ((_ data:SubCheckObj)->())?
    var btnDeleteAction : (()->())?
    var btnAddItemAction : (()->())?
    var viewSelectedItemsAction : (()->())?
    var arr_data:[SubCheckObj] = []
    var hideSelectedItems = true
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        setUpTable()
        
        containerStack.layer.shadowColor = UIColor.systemGray.cgColor
        containerStack.layer.shadowOpacity = 0.4
        containerStack.layer.shadowOffset = .zero
        containerStack.layer.shadowRadius = 2
        containerStack.layer.cornerRadius = 10
        
        self.deleteBtn.titleLabel?.font = .kufiRegularFont(ofSize: 13)
        self.addItemBtn.titleLabel?.font = .kufiRegularFont(ofSize: 13)
            
        titleTextField.delegate = self
        
    }
    
    
    func setUpTable(){
        itemTable.dataSource = self
        itemTable.delegate = self
        
        let nib = UINib(nibName: "SubTaskTVCell", bundle: nil)
        itemTable.register(nib, forCellReuseIdentifier: "SubTaskTVCell")
        
        tableHeight.constant = CGFloat((hideSelectedItems ? arr_data.filter({$0.is_done == "1"}).count :arr_data.count) * 51 )
        
        self.itemTable.setNeedsLayout()
        
        self.itemTable.reloadData()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func editTitleAction(_ sender: Any) {
        titleTextField.isEnabled = true
        editTitleButton.isHidden = true
        titleTextField.becomeFirstResponder()
    }
    
    
    @IBAction func didTapDelete(_ sender: AnyObject) {
        btnDeleteAction!()
    }
    
    
    @IBAction func didTapAddItem(_ sender: AnyObject) {
        btnAddItemAction!()
    }
    
    
    @IBAction func viewSelectedItems(_ sender: Any) {
        self.viewSelectedItemsAction?()
    }
    
    @IBAction func startEndAction(_ sender: Any) {
        btnStartEndTimer?()
    }
    
    
    func successStartEndTimer(){
        if startEndButton.tag == 0 {
            startEndButton.setImage(UIImage(systemName: "stop.circle"), for: .normal)
            startEndButton.tag = 1
        }else{
            startEndButton.setImage(UIImage(systemName: "play"), for: .normal)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return arr_data[indexPath.item].is_done == "2" && hideSelectedItems ? 0 : 51
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubTaskTVCell", for: indexPath) as! SubTaskTVCell
        
        let obj = arr_data[indexPath.row]
        
        cell.lblTitle.text = obj.notes
        cell.lblDate.text =  "End Date:" + "\(obj.end_date)"
        
        cell.btnDownloadAction = {
            self.btnEditItemAction?(obj)
        }
        
        cell.arr_user = obj.users
        
        let check_id = obj.check_id
        
        if obj.is_done == "1"{
            print("not Check")
            cell.btnCheck.setImage(UIImage(systemName: "square"), for: .normal)
        }else{
            print("Check")
            cell.btnCheck.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }
        
        cell.btnViewAction = {
            self.btnViewItemAction?(obj)
        }
        
        
        cell.btnCheckAction = {
            self.showLoadingActivity()
            let param :[String:Any] = ["point_id" : obj.check_id]
            
            APIController.shard.sendRequestPostAuth(urlString: "tasks/change_task_point", parameters: param ) { (response) in
                self.hideLoadingActivity()
                
                let status = response["status"] as? Bool
                if status == true{
                    cell.btnCheck.setImage(obj.is_done == "1" ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square"), for: .normal)
                    
                    self.arr_data[indexPath.row].is_done = obj.is_done == "1" ? "2" : "1"
                }
                self.hideLoadingActivity()
            }
            
        }
        
        cell.btnDeleteAction = {
            self.showLoadingActivity()
            APIController.shard.deleteItemCheckList(param: ["point_id":check_id]) { data in
                DispatchQueue.main.async {
                    self.hideLoadingActivity()
                }
                if data.status == nil || data.status == false{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "There is an unknown error...")
                }
            }
        }
        
        return cell
    }
    
    
}


extension CheckListCell:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        btnEditCheckListTitle?(textField.text!)
        titleTextField.isEnabled = false
        editTitleButton.isHidden = false
    }
    
}
