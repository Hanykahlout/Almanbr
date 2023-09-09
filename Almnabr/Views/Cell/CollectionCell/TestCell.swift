//
//  TestCell.swift
//  Almnabr
//
//  Created by MacBook on 13/10/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class TestCell: UICollectionViewCell {
    
    
    @IBOutlet weak var lbl_Title: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var view_img: UIView!
    
    var obj_ModuleObj :  ProjectDetilaService? { didSet{ set_info() }}
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private func set_info() {
        guard let obj = obj_ModuleObj else { return }
        lbl_Title.text = obj.label
        
    }
    
}
