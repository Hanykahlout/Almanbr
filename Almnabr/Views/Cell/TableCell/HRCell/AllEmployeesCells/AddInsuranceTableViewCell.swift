//
//  AddInsuranceTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 19/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import Fastis

protocol AddInsuranceCellDelegate{
    func deleteAction()
}

typealias AddInsuranceDelegate = UIViewController & AddInsuranceCellDelegate

class AddInsuranceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dependentNameTextField: UITextField!
    @IBOutlet weak var dependentIDTextField: UITextField!
    @IBOutlet weak var insuranceNumberTextField: UITextField!
    @IBOutlet weak var insuranceRelationshipTextField: UITextField!
    @IBOutlet weak var insuranceDateTextField: UITextField!
    
    @IBOutlet weak var relationArrow: UIImageView!
    
    private var relationshipData = ["Choose Options","Spouse","Son","Daugther","Others"]
    private var dateController = FastisController(mode: .single)
    private var dropDown = DropDown()
    var selectedRelationship:Int?
    var delegate:AddInsuranceDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpDropDownList()
        setUpDateController()
        // Initialization code
    }
    
    
    private func setUpDropDownList(){
        dropDown.anchorView = insuranceRelationshipTextField
        dropDown.dataSource = relationshipData
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            relationArrow.transform = .init(rotationAngle: 0)
            insuranceRelationshipTextField.text = item
            self.selectedRelationship = index
        }
        
        dropDown.cancelAction = { [unowned self] in
            relationArrow.transform = .init(rotationAngle: 0)
        }
        insuranceRelationshipTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(insuranceRelationshipAction)))
    }
    
    
    @objc private func insuranceRelationshipAction(){
        relationArrow.transform = .init(rotationAngle: .pi)
        dropDown.show()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    private func setUpDateController(){
        insuranceDateTextField.isEnabled = false
        dateController.title = "Choose Date"
        dateController.allowToChooseNilDate = true
        dateController.shortcuts = [.today]
        dateController.doneHandler = { result in
            if let result = result{
                self.insuranceDateTextField.text = self.delegate?.formatedDate(date: result) ?? ""
            }else{
                self.insuranceDateTextField.text = ""
            }
        }
    }
    
    
    @IBAction func calenderAction(_ sender: Any) {
        if let delegate = delegate {
            dateController.present(above: delegate.self)
        }
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        delegate?.deleteAction()
    }
    
}


