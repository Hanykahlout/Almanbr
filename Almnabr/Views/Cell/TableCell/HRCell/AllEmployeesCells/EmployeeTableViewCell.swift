//
//  EmployeeTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 05/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import Kingfisher
import DropDown
protocol EmployeeTableViewCellDelegate{
    func deleteAction(id:String,indexPath:IndexPath)
    func goToEdiVC(empID:String,empImage:String)
    func goToViewVC(empID:String,branchId:String,empImage:String)
}

typealias EmployeeDelegate = UIViewController & EmployeeTableViewCellDelegate

class EmployeeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var employeeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var employeeNumberLabel: UILabel!
    @IBOutlet weak var idNumberLabel: UILabel!
    @IBOutlet weak var referenceNoLabel: UILabel!
    @IBOutlet weak var jopTitleLabel: UILabel!
    @IBOutlet weak var idDetailsLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var cardView: UIView!
    
    weak var delegate:EmployeeDelegate?
    private var data:AllEmployeeRecords!
    private var indexPath:IndexPath!
    private var dropDown = DropDown()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dropDown.anchorView = menuButton
        dropDown.dataSource = ["View".localized(),"Edit".localized(),"Upload Signature".localized(),"Delete".localized()]
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.width = contentView.bounds.width - 100
        dropDown.selectionAction = { (index: Int, item: String) in
            switch index{
            case 0:
                self.delegate?.goToViewVC(empID: self.data.employee_number ?? "",branchId: self.data.branch_id ?? "",empImage: self.data.profile_image ?? "")
                break
            case 1:
                self.delegate?.goToEdiVC(empID: self.data.employee_number ?? "",empImage: self.data.profile_image ?? "")
                break
            case 2:
                break
            case 3:
                self.delegate?.deleteAction(id: self.data.employee_number ?? "", indexPath: self.indexPath)
            default:
                break
            }
        }
    }
    
    
    func setData(data:AllEmployeeRecords,indexPath:IndexPath){
        self.indexPath = indexPath
        self.data = data
        var imageStr = (data.profile_image ?? "")
        
        if let index = imageStr.firstIndex(of: ","){
            imageStr.removeSubrange(imageStr.startIndex...index)
            if let image = convertBase64StringToImage(imageBase64String: imageStr){
                employeeImageView.image = image
            }
        }else{
            employeeImageView.image = UIImage(named: "male")!
        }

        
        nameLabel.text = (data.employee_name ?? "------").uppercased()
        employeeNumberLabel.text = data.employee_number ?? "------"
        idNumberLabel.text = data.employee_id_number ?? "------"
        referenceNoLabel.text = data.e_reference_no ?? "------"
        jopTitleLabel.text = data.job_title_iqama ?? "------"
        idDetailsLabel.text = data.employee_id_number ?? "------"
        nationalityLabel.text = data.nationality ?? "------"
        writerLabel.text = data.name ?? "------"
        statusLabel.text = (data.employee_status ?? "") == "0" ? "InActive" : "Active"
    }
    
    private func convertBase64StringToImage (imageBase64String:String) -> UIImage? {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        if let imageData = imageData {
            let image = UIImage(data: imageData)
            return image
        }
        
        return nil
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        delegate?.deleteAction(id: data.employee_number ?? "", indexPath: indexPath)
    }
    
    @IBAction func moreAction(_ sender: Any) {
        dropDown.show()
    }
}
