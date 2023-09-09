//
//  CFormAttachTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 23/12/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class C1FormAttachTableViewCell: UITableViewCell {

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var attachwithPdfLabel: UILabel!
    @IBOutlet weak var printTheAttachmentLabel: UILabel!

    var previewAction : ( () -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setData(index:Int,data:FormC1File){
        counterLabel.text = "#\(index)"
        titleLabel.text = data.form_c1_file_attach_title ?? "- - - -"
        attachwithPdfLabel.text = data.attach_with_pdf ?? "0" == "1" ? "Yes" : "No"
        printTheAttachmentLabel.text = data.form_c1_file_print_official_paper ?? "0" == "1" ? "Yes" : "No"
    }
    
    
    
    @IBAction func pdfPerviewAction(_ sender: Any) {
        previewAction?()
    }
    
    
    
}



