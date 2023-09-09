//
//  ViewSellingInvoiceViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 22/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class ViewSellingInvoiceViewController: UIViewController {
    
    var invoice_id = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        addNavigationBarTitle(navigationTitle: "View Selling Invoices")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}
