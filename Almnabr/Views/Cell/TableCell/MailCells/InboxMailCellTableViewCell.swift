//
//  InboxMailCellTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 31/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class InboxMailCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setData(data:MailData){
        
        headerLabel.text = String(data.from?.name?.prefix(1) ?? "-").uppercased()
        titleLabel.text = data.from?.name ?? "----"
        addressLabel.text = data.from?.address ?? "----"
        subtitleLabel.text = data.subject ?? "----"
        messageLabel.text = data.message ?? "-----"
        dateLabel.text = APIController.shard.getDateString(with: data.date ?? "") ?? "--:-- --"
        
    }
    
    func setData(data:MessageInfo){
        let from = data.payload?.headers?.first(where: {$0.name == "From"})?.value ?? ""
        let subject = data.payload?.headers?.first(where: {$0.name == "Subject"})?.value ?? ""
        
        headerLabel.text = from.prefix(1).uppercased()
        titleLabel.text = from
//        addressLabel.text = data.from?.address ?? "----"
        subtitleLabel.text = subject
        messageLabel.text = data.snippet ?? "------"
        dateLabel.text = APIController.shard.getDateString(with: data.internalDate ?? "") ?? "--:-- --"
        
    }
    
    

    @IBAction func starAction(_ sender: Any) {
    }
    
    
}



extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
