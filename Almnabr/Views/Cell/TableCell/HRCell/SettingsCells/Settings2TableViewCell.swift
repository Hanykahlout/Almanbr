//
//  Settings2TableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 02/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

protocol Settings2TableViewCellDelegate{
    func goToSettingsAlert(data:SettingsDataRecords)
    func goToUpdateVC(data:SettingsDataRecords)
    func deleteAction(indexPath:IndexPath)
}

typealias SettingsAlertDelegate = Settings2TableViewCellDelegate & UIViewController

class Settings2TableViewCell: UITableViewCell {

  
    @IBOutlet weak var settingsTypeLabel: UILabel!
    @IBOutlet weak var titleENLabel: UILabel!
    @IBOutlet weak var titleARLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    weak var delegate :SettingsAlertDelegate?
    private var data:SettingsDataRecords!
    private var indexPath:IndexPath!
    func setData(data: SettingsDataRecords,indexPath:IndexPath){
        self.indexPath = indexPath
        self.data = data
        settingsTypeLabel.text = getSettingsType(type: data.settings_type ?? "")
        titleENLabel.text = data.settings_name_english ?? ""
        titleARLabel.text = data.settings_name_arabic ?? ""
        statusView.backgroundColor = (data.settings_status ?? "") == "1" ? .green : .gray
    }
    
    private func getSettingsType(type:String)->String{
        switch type{
        case "BANK":
            return "Bank Name"
        case "ETIT":
            return "Employee Title"
        case "JTIT":
            return "Job Positions"
        default:
            return ""
        }
    }
    
    
    @IBAction func eyeAction(_ sender: Any) {
        self.delegate?.goToSettingsAlert(data:data)
    }
    
    
    @IBAction func editAction(_ sender: Any) {
        delegate?.goToUpdateVC(data: data)
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        delegate?.deleteAction(indexPath:indexPath)
    }
    
}
