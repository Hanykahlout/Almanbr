//
//  NotesVC.swift
//  Almnabr
//
//  Created by MacBook on 07/12/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class NotesVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    var arr_data:[transactions_notesObj] = []
    
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
       addNavigationBarTitle(navigationTitle: "Notes".localized())
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




extension NotesVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTVCell", for: indexPath) as! TransactionTVCell
        
        let obj = arr_data[indexPath.item]
       
        
        let no =  "#".localized() + "  \(indexPath.item + 1)"
        let Notes = "Notes".localized() + "  \(obj.transactions_notes_text)"
        let writer = "Writer".localized() + "  \(obj.transactions_notes_user_name)"
        let OnDate = "On Date".localized() + "  \(obj.transactions_notes_datetime)"
        
       
        cell.lbKeylNo.text = no
        cell.lblKeyDesc.text = Notes
        cell.lblKeyWriter.text = writer
        cell.lblKeyLastUpdate.text = OnDate
       
        cell.lblKeyFrom.isHidden = true
        cell.lblKeyTo.isHidden = true
        cell.lblKeyBarCode.isHidden = true
        cell.lblKeyType.isHidden = true
        cell.lblKeyModule.isHidden = true
        cell.lblKeySubmitter.isHidden = true
        cell.lblKeyStatus.isHidden = true
        
        let attributedWithTextColor: NSAttributedString = no.attributedStringWithColor(["#".localized()], color: maincolor)
        cell.lbKeylNo.attributedText = attributedWithTextColor
        
        let Descriptionattributed: NSAttributedString = Notes.attributedStringWithColor(["Notes".localized()], color: maincolor)
        cell.lblKeyDesc.attributedText = Descriptionattributed
        
       
        let Writerattributed: NSAttributedString = writer.attributedStringWithColor(["Writer".localized()], color: maincolor)
        cell.lblKeyWriter.attributedText = Writerattributed
        
        let Lastattributed: NSAttributedString = OnDate.attributedStringWithColor(["On Date".localized()], color: maincolor)
        cell.lblKeyLastUpdate.attributedText = Lastattributed
        
        cell.viewBack.setcorner()
        
       
        return cell
        
    }
    
    
    
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
       
    }
    
    
}

