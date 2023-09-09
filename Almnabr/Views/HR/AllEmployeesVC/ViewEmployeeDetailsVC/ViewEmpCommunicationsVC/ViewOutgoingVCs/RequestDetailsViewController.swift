//
//  RequestDetailsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 26/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class RequestDetailsViewController: UIViewController {

    @IBOutlet weak var requestNoLabel: UILabel!
    @IBOutlet weak var barcodeLabel: UILabel!
    @IBOutlet weak var createdByLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    var id = ""
    @IBOutlet weak var statusLabel: UILabel!
    var isIncoming = false
    override func viewDidLoad() {
        super.viewDidLoad()
        initlizaiton()
        // Do any additional setup after loading the view.
    }
    
    
    private func initlizaiton(){
        let url = isIncoming ? "form/FORM_C2/vr/\(id)" : "form/FORM_C1/vr/\(id)"
        showLoadingActivity()
        APIController.shard.getMyTransactionData(url: url) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status, status{
                    ViewOutgoingViewController.data = data
                    ViewOutgoingViewController.data?.isIncoming = self.isIncoming
                    NotificationCenter.default.post(name: .init(rawValue: "ChangeDescriptionTitle"), object: data.transactions_request?.transaction_request_description ?? "")
                    self.setData()
                }
            }
        }
    }
    
    
    private func setData(){
        requestNoLabel.text = ViewOutgoingViewController.data?.transactions_request?.transaction_request_id ?? ""
        barcodeLabel.text = ViewOutgoingViewController.data?.transactions_request?.tbv_barcodeData ?? ""
        createdByLabel.text = ViewOutgoingViewController.data?.transactions_request?.created_name ?? ""
        createdDateLabel.text = ViewOutgoingViewController.data?.transactions_request?.created_name ?? ""
        statusLabel.text = ViewOutgoingViewController.data?.transactions_request?.transaction_request_status ?? ""
        statusLabel.textColor = .white
        statusLabel.backgroundColor = statusLabel.text == "new" ? .orange : .gray
    }

    
}
