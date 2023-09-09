//
//  PersonDetailsVC.swift
//  Almnabr
//
//  Created by MacBook on 08/12/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class PersonDetailsVC: UIViewController {
    
    
    @IBOutlet weak var table: UITableView!
    
    var arr_data:[transactions_personsObj] = []
    var personalData:[TransactionsPersons]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configNavigation()
        SetupTable()
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
       addNavigationBarTitle(navigationTitle: "Person Details".localized())
        UINavigationBar.appearance().backgroundColor = maincolor
    }
    
    
    
    // MARK: - Setup Table
    
    func SetupTable(){
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "TransactionTVCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "TransactionTVCell")
        self.table.reloadData()
    }
}




extension PersonDetailsVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personalData == nil ? arr_data.count : personalData!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTVCell", for: indexPath) as! TransactionTVCell
       
        var no:String = ""
        var Name:String = ""
        var Type:String = ""
        var View:String = ""
        var ViewTime:String = ""
        var LastViewTime:String = ""
        var step:String = ""
        var DateTime:String = ""
        
        
        if let personalData = personalData{
            
            let obj = personalData[indexPath.item]
            
            no =  "#".localized() + "  \(indexPath.item + 1)"
            Name = "Name".localized() + " \(obj.person_name ?? "") "
            Type = "Type".localized() + "  \(obj.transaction_persons_type ?? "")"
            View = "View".localized()
            ViewTime = "View Time".localized() + "  \(obj.transactions_persons_view_datetime ?? "")"
            LastViewTime = "Last View Time".localized() + "  \(obj.transactions_persons_view_datetime_lastupdate ?? "")"
            step = "step".localized() + "  \(obj.transactions_persons_last_step ?? "")"
            DateTime = "Date & Time".localized() + "  \(obj.transactions_persons_action_datetime ?? "")"
            
            cell.img_mark.isHidden = false
            if obj.transactions_persons_view == "1" {
                cell.img_mark.image = UIImage(systemName: "checkmark")
                cell.img_mark.tintColor = "#4ca832".getUIColor()
            }else{
                cell.img_mark.tintColor = "#bf2a2a".getUIColor()
                cell.img_mark.image = UIImage(systemName: "xmark")
            }
            
            
        }else{
            let obj = arr_data[indexPath.item]
            
            no =  "#".localized() + "  \(indexPath.item + 1)"
            Name = "Name".localized() + "  \(obj.first_name ) \(obj.last_name)"
            Type = "Type".localized() + "  \(obj.transaction_persons_type)"
            View = "View".localized()
            ViewTime = "View Time".localized() + "  \(obj.transactions_persons_view_datetime)"
            LastViewTime = "Last View Time".localized() + "  \(obj.transactions_persons_view_datetime_lastupdate)"
            step = "step".localized() + "  \(obj.transactions_persons_last_step)"
            DateTime = "Date & Time".localized() + "  \(obj.transactions_persons_action_datetime)"
            
            cell.img_mark.isHidden = false
            if obj.transactions_persons_view == "1" {
                cell.img_mark.image = UIImage(systemName: "checkmark")
                cell.img_mark.tintColor = "#4ca832".getUIColor()
            }else{
                cell.img_mark.tintColor = "#bf2a2a".getUIColor()
                cell.img_mark.image = UIImage(systemName: "xmark")
            }
            
        }


        cell.lbKeylNo.text = no
        cell.lblKeyDesc.text = Name
        cell.lblKeyFrom.text = Type
        cell.lblKeyTo.text = View
        cell.lblKeyBarCode.text = ViewTime
        cell.lblKeyType.text = LastViewTime
        cell.lblKeyModule.text = step
        cell.lblKeyWriter.text = DateTime
        
        cell.lblKeyLastUpdate.isHidden = true
        cell.lblKeySubmitter.isHidden = true
        cell.lblKeyStatus.isHidden = true
        
        let attributedWithTextColor: NSAttributedString = no.attributedStringWithColor(["#".localized()], color: maincolor)
        cell.lbKeylNo.attributedText = attributedWithTextColor
        
        let Nameattributed: NSAttributedString = Name.attributedStringWithColor(["Name".localized()], color: maincolor)
        cell.lblKeyDesc.attributedText = Nameattributed
        
       
        let Typeattributed: NSAttributedString = Type.attributedStringWithColor(["Type".localized()], color: maincolor)
        cell.lblKeyFrom.attributedText = Typeattributed
        
        let Viewattributed: NSAttributedString = View.attributedStringWithColor(["View".localized()], color: maincolor)
        cell.lblKeyTo.attributedText = Viewattributed
        
        let ViewTimeattributed: NSAttributedString = ViewTime.attributedStringWithColor(["View Time".localized()], color: maincolor)
        cell.lblKeyBarCode.attributedText = ViewTimeattributed
        
        
        let LastViewTimeattributed: NSAttributedString = LastViewTime.attributedStringWithColor(["Last View Time".localized()], color: maincolor)
        cell.lblKeyType.attributedText = LastViewTimeattributed
        
        
        let stepattributed: NSAttributedString = step.attributedStringWithColor(["step".localized()], color: maincolor)
        cell.lblKeyModule.attributedText = stepattributed
        
        let DateTimeattributed: NSAttributedString = DateTime.attributedStringWithColor(["Date & Time".localized()], color: maincolor)
        cell.lblKeyWriter.attributedText = DateTimeattributed
         
        cell.viewBack.setcorner()
        
       
        return cell
        
    }
    
    
    
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
       
    }
    
    
}

