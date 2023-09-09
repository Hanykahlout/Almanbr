//
//  CommuncationListTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 22/12/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class CommuncationListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var transcationNumberLAbel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var formLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var submitterLabel: UILabel!
    @IBOutlet weak var requestNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var pdfAction: ( () -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func pdfAction(_ sender: Any) {
        pdfAction?()
    }
    
    func setData(data:CommunicationList){
        
        transcationNumberLAbel.text = data.transaction_request_id ?? "----"
        descriptionLabel.text = data.communication_subject ?? "----"
        typeLabel.text = data.modules_name ?? "----"
        formLabel.text = data.communication_from_name ?? "----"
        toLabel.text = data.communication_to_name ?? "----"
        writerLabel.text = data.communication_user_name_writer ?? "----"
        submitterLabel.text = data.transactions_submitter_user_name ?? "----"
        requestNumberLabel.text = data.tbv_barcodeData ?? "----"
        dateLabel.text = "\(data.communication_date_m ?? "--") - \(data.communication_date_h ?? "--")"
        
    }
    
}
    
