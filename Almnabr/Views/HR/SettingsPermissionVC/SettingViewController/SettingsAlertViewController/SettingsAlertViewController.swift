//
//  SettingsAlertViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 02/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class SettingsAlertViewController: UIViewController {
    @IBOutlet weak var settingType: UILabel!
    @IBOutlet weak var titleEnLabel: UILabel!
    @IBOutlet weak var titleARLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var shortCodeLabel: UILabel!
    var data:SettingsDataRecords!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setData()
    }

    
    private func setData(){
        settingType.text = data.settings_type ?? ""
        titleEnLabel.text = data.settings_name_english ?? ""
        titleARLabel.text = data.settings_name_arabic ?? ""
        statusLabel.text = data.settings_status ?? ""
        shortCodeLabel.text = data.settings_short_code ?? ""
    }
    
    
    @IBAction func closeAction(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
}
