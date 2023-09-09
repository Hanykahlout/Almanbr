//
//  LabelCell.swift
//  Almnabr
//
//  Created by MacBook on 03/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class LabelCell: UICollectionViewCell {
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewBack: UIView!
    
    var object: ModuleObj? { didSet{ set_info() } }
    
    
    override init(frame: CGRect) {
           super.init(frame: frame)
        viewBack.backgroundColor = HelperClassSwift.acolor.getUIColor()
        viewBack.setRounded(10)
        lblTitle.textColor = .white
        lblTitle.font = .kufiRegularFont(ofSize: 13)
        
       }
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    private func set_info() {
        guard let obj = object else { return }
        
       
        lblTitle.text = obj.label
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
    
    

}
