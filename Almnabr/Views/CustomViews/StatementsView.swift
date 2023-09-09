//
//  StatementsView.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 04/03/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class StatementsView: UIView {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var collecitonView: UICollectionView!
    
    var trasactionCellButtonAction: ((_ data:AssetsRecord) -> Void)?
    var data = [AssetsRecord]()
    var title = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialization()
    }
    
    
    private func initialization(){
        Bundle.main.loadNibNamed("StatementsView", owner: self, options: nil)
        mainView.fixInView(self)
        setUpCollectionView()
        
    }
    
    
}

extension StatementsView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    private func setUpCollectionView(){
        collecitonView.delegate = self
        collecitonView.dataSource = self
        collecitonView.register(.init(nibName: "StatementsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StatementsCollectionViewCell")
    }
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatementsCollectionViewCell", for: indexPath) as! StatementsCollectionViewCell
        cell.setData(data:data[indexPath.row])
        cell.transactionButtonAction = { [weak self] in
            self?.trasactionCellButtonAction?(self!.data[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 200)
    }
}
