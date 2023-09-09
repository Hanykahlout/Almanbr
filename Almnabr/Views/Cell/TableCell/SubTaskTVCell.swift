//
//  SubTaskTVCell.swift
//  Almnabr
//
//  Created by MacBook on 15/05/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class SubTaskTVCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var viewBack: UIView!
    
    @IBOutlet weak var deleteEditStackView: UIStackView!
    var arr_user:[ProfileObj] = []
    
    var btnCheckAction : (()->())?
    var btnDeleteAction : (()->())?
    var btnViewAction : (()->())?
    var btnDownloadAction : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        let nib = UINib(nibName: "TaskUsersCVCell", bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: "TaskUsersCVCell")
        collection.delegate = self
        collection.dataSource = self
        collection.reloadData()
    }
    
    
    @IBAction func didDownloadButtonPressd(_ sender: Any) {
        btnDownloadAction!()
    }
    
    
    @IBAction func didDeleteButtonPressd(_ sender: Any) {
        btnDeleteAction!()
    }
    
    
    @IBAction func didCheckButtonPressd(_ sender: Any) {
        btnCheckAction!()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr_user.count
    }
    
    
    @IBAction func viewAction(_ sender: Any) {
        btnViewAction?()
    }
    
  
}

extension SubTaskTVCell: UICollectionViewDataSource , UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaskUsersCVCell", for: indexPath) as! TaskUsersCVCell
        
        cell.lblTitle.text = arr_user[indexPath.row].username
        cell.lblTitle.font = .kufiRegularFont(ofSize: 10)
        
        return cell
        
    }
}

