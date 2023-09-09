//
//  SpecialApproversCell.swift
//  Almnabr
//
//  Created by MacBook on 28/12/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class SpecialApproversCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var viewBack: UIView!
    
    var btnDeleteAction : (()->())?
    
    
    @IBAction func didReCancelButtonPressd(_ sender: Any) {
        btnDeleteAction!()
    }
    
}
