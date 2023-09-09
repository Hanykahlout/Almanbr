//
//  UpdateSettingsTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 02/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

protocol UpdateSettingsDelegate{
    func removeAction(indexPath: IndexPath)
    func updateData(indexPath:IndexPath,en:String,ar:String)
}

 typealias UpdateDelegate = UIViewController & UpdateSettingsDelegate

class UpdateSettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameEnTextField: UITextField!
    @IBOutlet weak var nameArTextField: UITextField!
    
    weak var delegate:UpdateDelegate?
    private var indexPath:IndexPath!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameEnTextField.addTarget(self, action: #selector(updateFields), for: .editingChanged)
        nameArTextField.addTarget(self, action: #selector(updateFields), for: .editingChanged)
        
    }

    
    func setData(data: LicenceData,indexPath:IndexPath){
        self.indexPath = indexPath
        nameEnTextField.text = data.licence_name_english ?? ""
        nameArTextField.text = data.licence_name_arabic ?? ""
    }
    
    
    @objc private func updateFields(){
        self.delegate?.updateData(indexPath:indexPath, en: nameEnTextField.text!, ar: nameArTextField.text!)
    }
 
    
    
    @IBAction func removeAction(_ sender: Any) {
        delegate?.removeAction(indexPath: indexPath)
    }
    
    
}
