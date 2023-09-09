//
//  DropDownView.swift
//  Almnabr
//
//  Created by MacBook on 15/01/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class DropDownView:  UIView {
    
    @IBOutlet weak var lbl_searchTitle: UILabel!
    @IBOutlet weak var tf_searchTitle: UITextField!
    @IBOutlet weak var view_search: UIView!
    @IBOutlet weak var btn_search: UIButton!
    @IBOutlet weak var img_Drop: UIImageView!
    
    @IBOutlet var contentView: UIView!
    
    var btnSearchAction : (()->())?
    var btnDeleteAction : (()->())?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initNib()
    }
    
    func initNib() {
        let bundle = Bundle(for: DropDownView.self)
        bundle.loadNibNamed("DropDownView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.backgroundColor = .white
    
        
        lbl_searchTitle.font = UIFont.kufiBoldFont(ofSize: 16)
       
        self.btn_search.isHidden = true
        
        
        self.view_search.setBorderGray()
    }
    
    
    @IBAction func btnDelete_Click(_ sender: Any) {
        
        self.tf_searchTitle.text = ""
        self.btn_search.isHidden = true
    }
    
    
    @IBAction func btnSearch_Click(_ sender: Any) {
        btnSearchAction?()
        
    }
    
    
}
