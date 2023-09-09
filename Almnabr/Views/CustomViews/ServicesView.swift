//
//  ServicesView.swift
//  Almnabr
//
//  Created by MacBook on 14/10/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import FontAwesome_swift

class ServicesView: UIView {


    @IBOutlet weak var collection: UICollectionView!
    

    let fontStyle: FontAwesomeStyle = .solid
    var arr_Services:[ModuleObj] = []
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        let nib = UINib(nibName: "ServicesCVCell", bundle: nil)
        self.collection.register(nib, forCellWithReuseIdentifier: "ServicesCVCell")
        collection.dataSource = self
        collection.delegate = self

        
        self.collection.reloadData()
    }
}

extension ServicesView: UICollectionViewDataSource ,UICollectionViewDelegate{
    
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr_Services.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServicesCVCell", for: indexPath) as! ServicesCVCell
        
        
        cell.lblTitle.text = arr_Services[indexPath.item].value
        cell.view_img.backgroundColor = HelperClassSwift.acolor.getUIColor()
        cell.view_img.setBorderGray()
        cell.img.image = UIImage.fontAwesomeIcon(name: .leaf, style: self.fontStyle, textColor: .gray, size: CGSize(width: 40, height: 40))
              
        //cell.setRecord(arr_data[indexPath.section].barcode)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let obj = arr_data[indexPath.section - 1]
//        let vc:ProjectDetailsVC = AppDelegate.mainSB.instanceVC()
//        vc.title =  self.title
//        vc.Object = obj
//        //vc.arr_Services = self.arr_Services
//        vc.arr_Services  = self.arr_Services
//        vc.StrSubMenue =  self.StrSubMenue
//        vc.StrMenue = self.StrMenue
//        _ =  panel?.center(vc)
    }
    

    
    
    
    
    
}
