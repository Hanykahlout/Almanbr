//
//  HistoryVC.swift
//  Almnabr
//
//  Created by MacBook on 09/12/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class HistoryVC: UIViewController {

    
    @IBOutlet weak var table: UITableView!
    
    var arr_data:[transactions_recordsObj] = []
    var jobOfferData:[Transactions_notes_record] = []
    var recordsData:[TransactionsContractRecord]?
    
    
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
       addNavigationBarTitle(navigationTitle: "History".localized())
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




extension HistoryVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let recordsData = recordsData{
            return recordsData.count
        }else if !arr_data.isEmpty{
            return arr_data.count
        }
        return jobOfferData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTVCell", for: indexPath) as! TransactionTVCell
        


        var no:String = ""
        var Name:String = ""
        var Notes:String = ""
        var OnDate:String = ""
        
        if let recordsData = recordsData{
            let obj = recordsData[indexPath.item]
            no =  "#".localized() + "  \(indexPath.item + 1)"
            Name = "Name".localized() + "  \(obj.transactions_records_user_name ?? "" )"
            Notes = "Notes".localized() + "  \(obj.transactions_records_note ?? "")"
            OnDate = "On Date".localized() + "  \(obj.transactions_records_datetime ?? "")"
        }else if !arr_data.isEmpty{
            let obj = arr_data[indexPath.item]
            no =  "#".localized() + "  \(indexPath.item + 1)"
            Name = "Name".localized() + "  \(obj.transactions_records_user_name )"
            Notes = "Notes".localized() + "  \(obj.transactions_records_note)"
            OnDate = "On Date".localized() + "  \(obj.transactions_records_datetime)"
        }else{
            let obj = jobOfferData[indexPath.item]
            no =  "#".localized() + "  \(indexPath.item + 1)"
            Name = "Name".localized() + "  \(obj.transactions_notes_user_name ?? "" )"
            Notes = "Notes".localized() + "  \(obj.transactions_notes_text ?? "")"
            OnDate = "On Date".localized() + "  \(obj.transactions_notes_datetime ?? "")"
        }
        
    
        
    
        cell.lbKeylNo.text = no
        cell.lblKeyDesc.text = Name
        cell.lblKeyFrom.text = Notes
        cell.lblKeyLastUpdate.text = OnDate
        
        cell.lblKeyBarCode.isHidden = true
        cell.lblKeyType.isHidden = true
        cell.lblKeyModule.isHidden = true
        cell.lblKeyWriter.isHidden = true
        cell.lblKeySubmitter.isHidden = true
        cell.lblKeyStatus.isHidden = true
        cell.lblKeyTo.isHidden = true
        
        
        let attributedWithTextColor: NSAttributedString = no.attributedStringWithColor(["#".localized()], color: maincolor)
        cell.lbKeylNo.attributedText = attributedWithTextColor
        
        let Nameattributed: NSAttributedString = Name.attributedStringWithColor(["Name".localized()], color: maincolor)
        cell.lblKeyDesc.attributedText = Nameattributed
        
       
        let Notesattributed: NSAttributedString = Notes.attributedStringWithColor(["Notes".localized()], color: maincolor)
        cell.lblKeyFrom.attributedText = Notesattributed
        
        
        let Lastattributed: NSAttributedString = OnDate.attributedStringWithColor(["On Date".localized()], color: maincolor)
        cell.lblKeyLastUpdate.attributedText = Lastattributed
        
        
        cell.viewBack.setcorner()
        
       
        return cell
        
    }
    
    
}

