//
//  SupervisionOperationDetailsVC.swift
//  Almnabr
//
//  Created by MacBook on 04/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit


class SupervisionOperationDetailsVC: UIViewController {

    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var collection: UICollectionView!

    var parentPageViewController: MyPageViewController!
    
    var SelectedIndex:Int = 0
    var MenuObj:MenuObj?
    
    var index = 0
    
    var Object:projectObj?
    var arrFormStep:[String] = ["Form Transaction".localized(),
                                "Users".localized(),
                                "Implementation Phases",
                                "Contractor Payments",
                                "Documents".localized(),
                                "Test Reports",
                                "Contacts".localized(),
                                "Owners",
                                "Risk Management",
                                "Wafi Report",
                                "Project Completion",
                                "Settings"
    ]
    
    var arrIcons:[String] = ["person.text.rectangle.fill",
                             "person.3.fill",
                             "building.fill",
                             "dollarsign.circle.fill",
                             "doc.on.doc.fill",
                             "flag.fill",
                             "iphone.gen1",
                             "bag.fill",
                             "exclamationmark",
                             "doc.text.fill",
                             "xmark",
                             "gearshape.fill"
    ]
    
    var arr_view :[UIViewController] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configGUI()
       
    }
 
    func configNavigation() {
        _ = self.navigationController?.preferredStatusBarStyle
        self.view.backgroundColor = "FFFFFF".getUIColor() //F0F4F8
        navigationController?.navigationBar.barTintColor = .red
        
    }
    
    
    func configGUI() {

        collection.delegate = self
        collection.dataSource = self
        collection.reloadData()
        ProjectName = Object?.projects_profile_name_en

    }
    
    @IBAction func btnProjectRequest_Click(_ sender: Any) {
        let shared = NotifiRoute()
        guard let top_vc = shared.menu_vc() else { return }
        let vc: ProjectRequestVC = AppDelegate.mainSB.instanceVC()
        top_vc.navigationController?.pushViewController(vc, animated: true)
    }

    
}

extension SupervisionOperationDetailsVC: UICollectionViewDataSource,
                                         UICollectionViewDelegate,
                                         UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrFormStep.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCell", for: indexPath) as! TestCell
        
        let item = arrFormStep[indexPath.item]
        cell.lbl_Title.text = item
        cell.lbl_Title.font = .kufiRegularFont(ofSize: 13)
        cell.lbl_Title.textColor = maincolor
        cell.view_img.setBorderGrayWidth(3)
        
        if indexPath.item == SelectedIndex {
            cell.view_img.backgroundColor = maincolor
        }else{
            cell.view_img.backgroundColor = HelperClassSwift.bcolor.getUIColor()
        }
        
        cell.view_img.setRounded()
        cell.img.image = UIImage(systemName: arrIcons[indexPath.item])
        

        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.SelectedIndex = indexPath.item
        self.collection.reloadData()
        self.change_page()
    }
    
    
    private func change_page() {
        NotificationCenter.default.post(name: NSNotification.Name("Change_Page"), object: SelectedIndex)
    }
    
    
}
