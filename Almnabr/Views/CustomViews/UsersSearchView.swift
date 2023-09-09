//
//  SearchForUser.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 31/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown

enum UserSelectionType { case multiSelection , singleSelection }

class UsersSearchView: UIView {
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var usersArrow: UIImageView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    private var results = [SearchBranchRecords]()
    var selectedResults = [SearchBranchRecords]()
    private var dropDown = DropDown()
    var usersResult:((_ result:[SearchBranchRecords])->Void)?
    var selectionType: UserSelectionType = .singleSelection

    override init(frame: CGRect) {
        super.init(frame: frame)
        initlization()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initlization()
    }
    
    private func initlization(){
        Bundle.main.loadNibNamed("UsersSearchView", owner: self, options: nil)
        mainView.fixInView(self)
        setUpCollectionView()
        setUpDropDownList()
        searchTextField.addTarget(self, action: #selector(searchForUsers), for: .editingChanged)
    }
    
    private func setUpDropDownList(){
        dropDown.anchorView = searchTextField
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if !self.results.isEmpty{
                usersArrow.transform = .init(rotationAngle: 0)
                let objc = self.results[index]
                self.searchTextField.text = ""
                
                if selectionType == .singleSelection {
                    self.searchTextField.placeholder = objc.label ?? ""
                    self.usersResult?([objc])
                }else{
                    if !self.selectedResults.contains(where: {$0.value == objc.value}){
                        self.selectedResults.append(objc)
                        self.collectionView.reloadData()
                        self.collectionView.isHidden = false
                        self.usersResult?(self.selectedResults)
                    }
                }
            }
        }
        
        dropDown.cancelAction = { [unowned self] in
            self.usersArrow.transform = .init(rotationAngle: .pi)
        }
    }
}


//MARK: - Collection View Delegate
extension UsersSearchView:UICollectionViewDelegate,UICollectionViewDataSource{
    private func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(.init(nibName: "UsersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UsersCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsersCollectionViewCell", for: indexPath) as! UsersCollectionViewCell
        let obj = selectedResults[indexPath.row]
        cell.indexPath = indexPath
        cell.delegate = self
        cell.titleLabel.text = obj.label ?? ""
        return cell
    }
}

//MARK: - Collection View Cell Delegate
extension UsersSearchView: UsersCollectionViewCellDelegate{
    func removeAction(indexPath: IndexPath) {
        selectedResults.remove(at: indexPath.row)
        collectionView.reloadData()
        collectionView.isHidden = selectedResults.isEmpty
        usersResult?(selectedResults)
    }
}

// MARK: - API Handling
extension UsersSearchView{
    
    @objc private func searchForUsers(){
        APIController.shard.searchForUser(searchText: searchTextField.text!, lang: L102Language.currentAppleLanguage(), id: Auth_User.user_type_id) { data in
            if let status = data.status , status{
                self.results = data.list ?? []
                self.dropDown.dataSource = self.results.map{$0.label ?? ""}
                
            }else{
                self.results.removeAll()
                self.dropDown.dataSource = ["No items founded"]
            }
            self.usersArrow.transform = .init(rotationAngle: .pi)
            self.dropDown.show()
        }
    }
    
}


