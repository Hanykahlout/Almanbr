//
//  ModulesTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 23/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ModulesTableViewCell: UITableViewCell {

    @IBOutlet weak var moduleLabel: UILabel!
    @IBOutlet weak var moduleIdsLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var onDateLabel: UILabel!
    private var data:AllModulesRecords!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:AllModulesRecords){
        self.data = data
        moduleLabel.text = data.modulename ?? ""
        moduleIdsLabel.text = data.private_value ?? ""
        writerLabel.text = data.writer ?? ""
        onDateLabel.text = data.create_date ?? ""
    }
    
    @IBAction func viewAction(_ sender: Any) {
        NotificationCenter.default.post(name: .init(rawValue: "GoToUsersVC"), object: data)
    }
}
