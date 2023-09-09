//
//  SubmitCostCenteAlertVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 16/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class SubmitCostCenteAlertVC: UIViewController {

    @IBOutlet weak var totalCostsLabel: UILabel!
    @IBOutlet weak var mainStackView: UIStackView!
    private var cardCosts:AddCardCost?
    var data:[(card:SearchBranchRecords?,amount:String)]?
    var total = ""
    var branchId = ""
    var submitDataAction:((_ data:[(card:SearchBranchRecords?,amount:String)])->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        // Do any additional setup after loading the view.
    }

    private func initialization(){
        setUpCardCostsViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        totalCostsLabel.text = total
        cardCosts?.addCardCost(cost: data ?? [])
    }
    
    private func setUpCardCostsViews(){
        
        cardCosts = AddCardCost()
        cardCosts?.branch_id = branchId
        cardCosts!.isDebit = true
//        cardCosts?.addCardCost(cost: data ?? [])
        cardCosts!.titleLabel.text = "Cost *"
        cardCosts!.debitCostTextField.placeholder = "Cost"
        
        mainStackView.insertArrangedSubview(cardCosts!, at: 3)
    }
    
    
    @IBAction func closeAction(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
    @IBAction func submitAction(_ sender: Any) {
        guard let cardCosts = cardCosts else { return }
        submitDataAction?(cardCosts.getSelectedCardCosts())
        navigationController?.dismiss(animated: true)
    }
    
    
}
