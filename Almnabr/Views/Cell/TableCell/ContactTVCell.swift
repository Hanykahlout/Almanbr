//
//  ContactTVCell.swift
//  Almnabr
//
//  Created by MacBook on 11/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ContactTVCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnMoile: UIButton!
    @IBOutlet weak var btnfax: UIButton!
    @IBOutlet weak var btnwhats: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var viewBack: UIView!
    
    var btn_whatsAction : (()->())?
    var btn_EmailAction : (()->())?
    var btn_MobileAction : (()->())?
    var btn_FaxAction : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        viewBack.layer.shadowColor = UIColor.systemGray5.cgColor
        viewBack.layer.shadowOpacity = 0.8
        viewBack.layer.shadowOffset = .zero
        viewBack.layer.shadowRadius = 4
        
    }

    
    @IBAction func didFaxButtonPressd(_ sender: Any) {
        btn_FaxAction!()
    }
    
    @IBAction func didFwhatsButtonPressd(_ sender: Any) {
        btn_whatsAction!()
    }
    
    @IBAction func didEmailButtonPressd(_ sender: Any) {
        btn_EmailAction!()
    }
    
    @IBAction func didMobileButtonPressd(_ sender: Any) {
        btn_MobileAction!()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
