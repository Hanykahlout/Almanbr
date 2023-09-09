//
//  ContactDetailsTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 15/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

protocol ContactDetailsCellDelegate{
    func deleteCellAction(id:String,indexPath:IndexPath)
    func viewAction(data:ContactRecords)
    func updateAction(data:ContactRecords)
}

typealias ContactDetailsDelegate = ContactDetailsCellDelegate & UIViewController

class ContactDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    private var indexPath:IndexPath!
    private var data:ContactRecords!
    
    var delegate: ContactDetailsDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setData(data:ContactRecords,indexPath:IndexPath){
        self.indexPath = indexPath
        self.data = data
        nameLabel.text = data.contact_person_name ?? ""
        mobileLabel.text = data.contact_mobile_number ?? ""
        emailLabel.text = data.contact_email_address ?? ""
        writerLabel.text = data.name ?? ""
    }

    
    
    @IBAction func deleteAction(_ sender: Any) {
        delegate?.deleteCellAction(id:self.data.contact_id ?? "",indexPath: self.indexPath)
    }
    
    @IBAction func editAction(_ sender: Any) {
        delegate?.updateAction(data:self.data)
    }
    
    @IBAction func viewAction(_ sender: Any) {
        delegate?.viewAction(data:self.data)
    }
    
}
