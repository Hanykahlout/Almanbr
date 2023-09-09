//
//  OtherDetailsVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 17/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class OtherDetailsVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var data = [("Contract Details","doc.on.doc.fill"),("Bank Details","building.columns.fill"),("Education Details","book.closed.fill"),("Passport Details","airplane"),("Insurance Details","building.2")]
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }
    
    
    private func initlization(){
        setUpCollectionView()
    }
    
    
}

extension OtherDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource{
    private func setUpCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(.init(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        let obj = data[indexPath.row]
        cell.lblTitle.text = obj.0
        cell.img_Category.image = UIImage(systemName: obj.1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            let vc = ViewEmpContractDetailsVC()
            vc.id = self.id
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = ViewEmpBankDetailsVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = ViewEmpEducationDetailsVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = ViewEmpPassportDetailsVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = ViewEmpInsuranceDetailsVC()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    
}
