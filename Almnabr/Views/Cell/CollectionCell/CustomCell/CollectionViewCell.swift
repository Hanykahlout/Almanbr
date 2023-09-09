//
//  CollectionViewCell.swift
//  Almnabr
//
//  Created by MacBook on 05/11/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewCollection: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initNib()
    }
    
    func initNib() {
    
 
    }
    
    
}
