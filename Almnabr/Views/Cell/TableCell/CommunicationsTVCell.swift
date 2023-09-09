//
//  CommunicationsTVCell.swift
//  Almnabr
//
//  Created by MacBook on 02/04/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class CommunicationsTVCell: UITableViewCell {

    @IBOutlet weak var lblRequestNo: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblModule: UILabel!
    @IBOutlet weak var lblBarcode: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblSubmitter: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var viewBack: UIView!
    
    var btn_PdfAction : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        viewBack.layer.shadowColor = UIColor.systemGray.cgColor
        viewBack.layer.shadowOpacity = 0.8
        viewBack.layer.shadowOffset = .zero
        viewBack.layer.shadowRadius = 4
        viewBack.layer.cornerRadius = 20
        
    }

    
  
    

    
    @IBAction func didLinkButtonPressd(_ sender: Any) {
       btn_PdfAction!()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
