//
//  ProfileVC.swift
//  Almnabr
//
//  Created by MacBook on 29/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileVC: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var view_Status: UIView!
    @IBOutlet weak var view_collection: UIView!
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var view_profile: UIView!
    
    @IBOutlet weak var header: HeaderView!
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var collection_category: UICollectionView!
    
    var arr_category :[String] = ["Contract","Job","Communications","Contact","Bank","Education","Passport","Insurance","Vacations","Notes","Attachments","Modules","Signature","Finanial Details"]
    var arr_img:[String] = ["doc.on.doc.fill","bag.fill","link","person.2.fill","iphone.homebutton","text.book.closed.fill","airplane","building.fill","person.crop.rectangle.stack.fill","doc","paperclip","rectangle.stack.person.crop.fill","signature","dollarsign"]
    var profile_obj:ProfileObj?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        get_profile()
        header.btnAction = self.menu_select
        
        view_profile.layer.applySketchShadow(
            color: .gray,
            alpha: 0.6,
            x: 2,
            y: 2,
            blur: 4,
            spread: 0)
        view_collection.layer.applySketchShadow(
            color: .gray,
            alpha: 0.6,
            x: 2,
            y: 2,
            blur: 4,
            spread: 0)
        
        view_collection.setRounded(10)
        collection_category.register(.init(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileCollectionViewCell")
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    func menu_select(){
        let language =  L102Language.currentAppleLanguage()
        if language == "ar"{
            panel?.openRight(animated: true)
        }else{
            panel?.openLeft(animated: true)
        }
    }
    
    
    func get_profile(){
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: "profile" ) { (response) in
            self.hideLoadingActivity()
            
            let status = response["status"] as? Bool
            if status == true{
                if let data = response["data"] as? [String:Any] {
                    let profile = ProfileObj(data)
                    
                    self.profile_obj = profile
                    self.lblName.text = profile.employee_title_name + " " + profile.firstname_english + " " + profile.secondname_english + " " + profile.lastname_english
                    self.lblJobTitle.text =  "," + profile.job_title_iqama
                    self.lblLocation.text = profile.countryname
                    if profile.employee_status == "1" {
                        // self.lblStatus.text = "Active"
                        self.view_Status.backgroundColor = "32CD32".getUIColor()
                    }else{
                        // self.lblStatus.text = "Not Active"
                        self.view_Status.backgroundColor = "FF0000".getUIColor()
                        
                    }
                    
                    
                    let url = URL(string: APIController.shard.serverURL + profile.profile_image)
                    // imageView.kf.setImage(with: url)
                    print(url)
                    
                    // self.imgProfile.kf.setImage(with: url)
                }
            }
        }
    }
    
}




extension ProfileVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource ,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr_category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        
        let item = arr_category[indexPath.item]
        
        cell.lblTitle.font = .kufiRegularFont(ofSize: 12)
        //cell.lblTitle.textColor = maincolor
        cell.lblTitle.text = item
        cell.img_Category.image = UIImage(systemName: arr_img[indexPath.item])
        cell.img_Category.tintColor = maincolor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = arr_category[indexPath.item]
        
        switch item {
        case "Contract":
            let vc:ContractDetailsVC = AppDelegate.HRSB.instanceVC()
            vc.profile_obj = self.profile_obj
            self.navigationController?.pushViewController(vc, animated: true)
        case "Job":
            let vc:JobDetailsVC = AppDelegate.HRSB.instanceVC()
            vc.profile_obj = self.profile_obj
            self.navigationController?.pushViewController(vc, animated: true)
        case "Communications":
            let vc:CommunicationsVC = AppDelegate.HRSB.instanceVC()
            vc.profile_obj = self.profile_obj
            self.navigationController?.pushViewController(vc, animated: true)
        case "Contact":
            let vc:ContactDetailsVC = AppDelegate.HRSB.instanceVC()
            vc.profile_obj = self.profile_obj
            self.navigationController?.pushViewController(vc, animated: true)
        case "Bank":
            let vc:BankDetailsVC = AppDelegate.HRSB.instanceVC()
            vc.profile_obj = self.profile_obj
            self.navigationController?.pushViewController(vc, animated: true)
        case "Education":
            let vc:EducationDetailsVC = AppDelegate.HRSB.instanceVC()
            vc.profile_obj = self.profile_obj
            self.navigationController?.pushViewController(vc, animated: true)
        case "Passport":
            let vc:PassportDetailsVC = AppDelegate.HRSB.instanceVC()
            vc.profile_obj = self.profile_obj
            self.navigationController?.pushViewController(vc, animated: true)
        case "Insurance":
            let vc:InsuranceDetailsVC = AppDelegate.HRSB.instanceVC()
            vc.profile_obj = self.profile_obj
            self.navigationController?.pushViewController(vc, animated: true)
        case "Vacations":
            let vc:VacationFormVC = AppDelegate.HRSB.instanceVC()
            vc.profile_obj = self.profile_obj
            self.navigationController?.pushViewController(vc, animated: true)
        case "Notes":
            let vc:UserNotesVC = AppDelegate.HRSB.instanceVC()
            vc.profile_obj = self.profile_obj
            self.navigationController?.pushViewController(vc, animated: true)
        case "Attachments":
            let vc:UserAttachmentsVC = AppDelegate.HRSB.instanceVC()
            vc.profile_obj = self.profile_obj
            self.navigationController?.pushViewController(vc, animated: true)
        case "Modules":
            let vc:ModulesVC = AppDelegate.HRSB.instanceVC()
            vc.profile_obj = self.profile_obj
            self.navigationController?.pushViewController(vc, animated: true)
        case "Signature":
            let vc:SignatureVC = AppDelegate.HRSB.instanceVC()
            vc.profile_obj = self.profile_obj
            self.navigationController?.pushViewController(vc, animated: true)
        case "Finanial Details":
            let vc:FinanialDetailsViewController = AppDelegate.HRSB.instanceVC()
            vc.profile_obj = self.profile_obj
            self.navigationController?.pushViewController(vc, animated: true)
            
        default:
            print("nil")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 10) / 4.0
        return CGSize(width: width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
