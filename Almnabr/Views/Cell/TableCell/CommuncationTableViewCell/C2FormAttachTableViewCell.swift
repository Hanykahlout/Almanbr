//
//  C2FormAttachTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 23/12/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class C2FormAttachTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    var previewPDF : (()->Void)?
    
    
    
    @IBAction func previewAction(_ sender: Any) {
        previewPDF?()
    }
    
    
}
