//
//  AddCardCost.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 02/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import SCLAlertView
class AddCardCost: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var debitCostTextField: UITextField!
    
    @IBOutlet weak var debitCostArrow: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var cardCosts = [(card:SearchBranchRecords?,amount:String)]()
    private var debitCostDropDown = DropDown()
    private var debitCosts = [SearchBranchRecords]()
    private var selectedDebitCost:SearchBranchRecords?
    var branch_id = ""
    var isDebit = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialization()
    }
    
    
    private func initialization(){
        Bundle.main.loadNibNamed("AddCardCost", owner: self, options: nil)
        mainView.fixInView(self)
        setUpDropDown()
        debitCostTextField.addTarget(self, action: #selector(searchInDebitCost), for: .editingChanged)
        setUpCollectionView()
     
    }
    
    
    private func setUpDropDown(){
        
        // debitCostDropDown
        debitCostDropDown.anchorView = debitCostTextField
        debitCostDropDown.bottomOffset = CGPoint(x: 0, y:(debitCostDropDown.anchorView?.plainView.bounds.height)!)
        debitCostDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.debitCostArrow.transform = .init(rotationAngle: 0)
            self?.selectedDebitCost = self?.debitCosts[index]
            self?.debitCostTextField.placeholder = item
            self?.debitCostTextField.text = ""
        }
        
        debitCostDropDown.cancelAction = { [weak self] in
            self?.debitCostArrow.transform = .init(rotationAngle: .pi)
            self?.debitCostTextField.text = ""
        }
        
    }
    

    func getSelectedCardCosts() -> [(card:SearchBranchRecords?,amount:String)]{
        return cardCosts
    }
    
    func addCardCost(cost:[(card:SearchBranchRecords?,amount:String)]){
        cardCosts.append(contentsOf: cost)
        collectionView.isHidden = cardCosts.isEmpty
        collectionView.reloadData()
        amountTextField.text = ""
        selectedDebitCost = nil
        debitCostTextField.placeholder = isDebit ? "Debit Cost" : "Credit Cost"
        debitCostTextField.text = ""
    }
    
    
    @objc private func searchInDebitCost(){
        searchForCardCost()
    }
   
    private func validate()->Bool{
        return selectedDebitCost != nil && !amountTextField.text!.isEmpty
    }
    
    @IBAction func addAction(_ sender: Any) {
        if validate(){
            cardCosts.append((card: selectedDebitCost, amount: amountTextField.text!))
            collectionView.isHidden = false
            collectionView.reloadData()
            amountTextField.text = ""
            selectedDebitCost = nil
            debitCostTextField.placeholder = isDebit ? "Debit Cost" : "Credit Cost"
            debitCostTextField.text = ""
        }else{
            SCLAlertView().showError("error".localized(), subTitle: "Invalid Input !!")
        }
    }
    
}

// MARK: - Collection View Delegate and Data Sourc
extension AddCardCost:UICollectionViewDelegate,UICollectionViewDataSource{
    private func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(.init(nibName: "AddCardCostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddCardCostCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardCosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddCardCostCollectionViewCell", for: indexPath) as! AddCardCostCollectionViewCell
        cell.setData(cardTitle: isDebit ? "Debit Card" : "Credit Card", data: cardCosts[indexPath.row])
        cell.didClickOnDelete = { [weak self] in
            self?.cardCosts.remove(at: indexPath.row)
            self?.collectionView.reloadData()
            self?.collectionView.isHidden = self?.cardCosts.isEmpty ?? true
        }
        return cell
    }
    
}



// MARK: - API Handling
extension AddCardCost{
    private func searchForCardCost(){
        APIController.shard.searchForCostCenter(branch_id: branch_id, search_text: debitCostTextField.text!) { data in
            DispatchQueue.main.async { [weak self] in
                if data.status ?? false{
                    self?.debitCosts = data.records ?? []
                    self?.debitCostDropDown.dataSource = (data.records ?? []).map{$0.label ?? ""}
                    self?.debitCostArrow.transform = .init(rotationAngle: .pi)
                }else{
                    self?.debitCosts.removeAll()
                    self?.debitCostDropDown.dataSource.removeAll()
                }
                self?.debitCostDropDown.show()
            }
        }
    }
    
}



