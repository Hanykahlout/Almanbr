//
//  ViewAttachTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 18/08/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView

class DocAttachTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    private var data:DocAttachsData!
    var downloadAction: ((_ url:String)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:DocAttachsData){
        self.data = data
        titleLabel.text = data.title_file ?? ""
        nameLabel.text = data.user_name ?? ""
        dateTimeLabel.text = data.insert_date ?? ""
    }
    
    @IBAction func downloadAction(_ sender: Any) {
        downloadAction?(data.file_path ?? "")
        
    }
    
    
}
