//
//  ViewAttachTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 27/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ViewAttachTableViewCell: UITableViewCell {

    @IBOutlet weak var attachwithPdfStackView: UIStackView!
    @IBOutlet weak var officialPaperStackView: UIStackView!
    @IBOutlet weak var attachWithPdfLabel: UILabel!
    @IBOutlet weak var officialPaperLabel: UILabel!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    private var fileURL = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(isIncoming:Bool,data:form_c2_filesRecords){
        attachwithPdfStackView.isHidden = isIncoming
        officialPaperStackView.isHidden = isIncoming
        attachWithPdfLabel.text = data.form_c1_file_attach_with_the_document ?? "" == "1" ? "Yes" : "No"
        officialPaperLabel.text = data.form_c1_file_print_official_paper ?? "" == "1" ? "Yes" : "No"
        titleLabel.text = isIncoming ? data.form_c2_file_attach_title ?? "" : data.form_c1_file_attach_title ?? ""
        fileURL = data.link ?? ""
    }
    
    @IBAction func viewAttachAction(_ sender: Any) {
        NotificationCenter.default.post(name: .init(rawValue: "ViewAttachmentUrl"), object: fileURL)
    }
    
    
}
