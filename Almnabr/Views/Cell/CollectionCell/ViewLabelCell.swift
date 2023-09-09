//
//  ViewLabelCell.swift
//  Almnabr
//
//  Created by MacBook on 18/01/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ViewLabelCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var viewBack: UIView!
    
    var object: ModuleObj? { didSet{ set_info() } }
    
    var btnDeleteAction : (()->())?
    
    //let item = arr_meals[indexPath.row]
    //cell.obj_Product = item
    private func set_info() {
        guard let obj = object else { return }
         
        lblTitle.text = obj.label
        

        self.viewBack.backgroundColor = HelperClassSwift.acolor.getUIColor()
        self.lblTitle.textColor = .white
         
        self.btnDeleteAction = {

//            self.arr_special_approvers.remove(at: indexPath.item)
//            self.arr_special_id.remove(at: indexPath.item)
//            self.Collection.reloadData()

        }
    }
    
    @IBAction func didReCancelButtonPressd(_ sender: Any) {
        btnDeleteAction!()
    }
    
}
