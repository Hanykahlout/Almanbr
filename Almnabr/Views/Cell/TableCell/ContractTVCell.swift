//
//  ContractTVCell.swift
//  Almnabr
//
//  Created by MacBook on 01/04/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ContractTVCell: UITableViewCell {

    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var lblContractDate: UILabel!
    @IBOutlet weak var lblWorkDomain: UILabel!
    @IBOutlet weak var lblWorkLocation: UILabel!
    @IBOutlet weak var lblApprovedDate: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var viewStatus: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        viewBack.layer.shadowColor = UIColor.systemGray.cgColor
        viewBack.layer.shadowOpacity = 0.8
        viewBack.layer.shadowOffset = .zero
        viewBack.layer.shadowRadius = 4
        viewBack.layer.cornerRadius = 20
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:ContractData){
        
        self.lblSubject.text = data.subject ?? ""
        self.lblContractDate.text = "\(data.joining_date_english ?? "") - \(data.joining_date_arabic ?? "")"
        self.lblWorkDomain.text = data.work_domain ?? ""
        self.lblWorkLocation.text = data.work_location ?? ""
        self.lblApprovedDate.text = "\(data.contract_approved_date_english ?? "") - \(data.contract_approved_date_arabic ?? "")"
        self.lblWriter.text = data.writer ?? ""
        self.viewStatus.backgroundColor = data.contract_status == "1" ? .green : .red
        
    }
    
}
