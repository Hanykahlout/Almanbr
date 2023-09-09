//
//  AccountSettingsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 03/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
import SCLAlertView
class AccountSettingsViewController: UIViewController {

    
    
    
    
    
    @IBOutlet weak var branchSelectionStackView: UIStackView!
    @IBOutlet weak var headerView: HeaderView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainStackView: UIStackView!
    
    private let bracnchSelection = BranchSelection(frame: .init())
    private var pageController: AccountSettingsPageViewController!
    private var data = [SectionInfo]()
    private var selectedIndex = 0
    static var branch_id = ""
    static var finance_id = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    private func initialization(){
        handleHeaderView()
        setUpPageCotroller()
        setCollectionData()
        setUpCollectionView()
        
        bracnchSelection.branchSelectionAction = { value in
            AccountSettingsViewController.branch_id = value
            self.mainStackView.isHidden = value == ""
            NotificationCenter.default.post(name: .init("ReloadPermissionMentions"), object: nil)
            NotificationCenter.default.post(name: .init("ReloadAccountsSettings"), object: nil)
            NotificationCenter.default.post(name: .init("ReloadAccountTax"), object: nil)
            NotificationCenter.default.post(name: .init("ReloadInvoiceSettings"), object: nil)
            NotificationCenter.default.post(name: .init("ReloadFinancialYears"), object: nil)
            NotificationCenter.default.post(name: .init("ReloadBlockAccounts"), object: nil)
        }
        
        
        bracnchSelection.financialYearSelectionAction = { value in
            AccountSettingsViewController.finance_id = value
            NotificationCenter.default.post(name: .init("ReloadInvoiceSettings"), object: nil)
            NotificationCenter.default.post(name: .init("ReloadBlockAccounts"), object: nil)
        }
        bracnchSelection.withFinancialYearSelection = true
        branchSelectionStackView.addArrangedSubview(bracnchSelection)
    }
    
    private func setUpPageCotroller(){
        pageController = AccountSettingsPageViewController()
        
        addChild(pageController)
        pageController.didMove(toParent: self)
        
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.addSubview(pageController.view)

        mainView.leadingAnchor.constraint(equalTo: pageController.view.leadingAnchor, constant: 0).isActive = true
        mainView.trailingAnchor.constraint(equalTo: pageController.view.trailingAnchor, constant: 0).isActive = true
        mainView.topAnchor.constraint(equalTo: pageController.view.topAnchor, constant: 0).isActive = true
        mainView.bottomAnchor.constraint(equalTo: pageController.view.bottomAnchor, constant: 0).isActive = true
    }
    
    
    private func setCollectionData(){

        data.append(.init(bgColor: UIColor(named: "AppColor")!, icon: UIImage(systemName: "person.3.fill")!, title: "Permission Mentions".localized()))
        data.append(.init(bgColor: UIColor.black, icon: UIImage(systemName: "gear.badge")!, title: "Accounts Settings".localized()))
        
        data.append(.init(bgColor: UIColor.black, icon: UIImage(systemName: "percent")!, title: "Tax".localized()))
        
        data.append(.init(bgColor: UIColor.black, icon: UIImage(systemName: "gearshape.fill")!, title: "Invoice Settings".localized()))
        
        data.append(.init(bgColor: UIColor.black, icon: UIImage(systemName: "dollarsign.circle.fill")!, title: "Financial Years".localized()))
        
        data.append(.init(bgColor: UIColor.black, icon: UIImage(systemName: "shareplay.slash")!, title: "Block Accounts".localized()))
        
    }

  
    private func handleHeaderView(){
        headerView.btnAction = {
            let language =  L102Language.currentAppleLanguage()
            if language == "ar"{
                self.panel?.openRight(animated: true)
            }else{
                self.panel?.openLeft(animated: true)
            }
        }
    }

}

extension AccountSettingsViewController:UICollectionViewDelegate , UICollectionViewDataSource{
    private func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(.init(nibName: "SectionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SectionCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionCollectionViewCell", for: indexPath) as! SectionCollectionViewCell
        cell.setData(data: data[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goToSelectedCell(indexPath: indexPath)
        selectedIndex = indexPath.row
        pageController.displayPageForIndex(index: selectedIndex,animated: true)
    }
    
    
    private func goToSelectedCell(indexPath:IndexPath){
        for index in 0..<data.count{
            if index == indexPath.row{
                data[index].bgColor = UIColor(named: "AppColor")!
            }else{
                data[index].bgColor = UIColor.black
            }
        }
        
        collectionView.reloadData()
        collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally], animated: false)
    }
    
    
}



