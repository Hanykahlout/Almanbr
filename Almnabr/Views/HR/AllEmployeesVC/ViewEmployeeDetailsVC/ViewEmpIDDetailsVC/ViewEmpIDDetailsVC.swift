//
//  ViewEmpIDDetailsVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 12/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ViewEmpIDDetailsVC: UIViewController {
    
    @IBOutlet weak var profilePercentLabel: UILabel!
    @IBOutlet weak var profilePercentProgressView: UIProgressView!
    @IBOutlet weak var empAgeLabel: UILabel!
    @IBOutlet weak var empNumberLabel: UILabel!
    @IBOutlet weak var empImageView: UIImageView!
    @IBOutlet weak var empIDNumberLabel: UILabel!
    @IBOutlet weak var referenceNoLabel: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var nameEnglishLabel: UILabel!
    @IBOutlet weak var nameArabicLabel: UILabel!
    @IBOutlet weak var expiryDateLabel: UILabel!
    @IBOutlet weak var copyNumberLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var usersTypeLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var lang_human_resources_job_titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var maritalStatusLabel: UILabel!
    @IBOutlet weak var religionLabel: UILabel!
    @IBOutlet weak var workDomainLabel: UILabel!
    @IBOutlet weak var workLocationLabel: UILabel!
    @IBOutlet weak var workTypeLabel: UILabel!
    @IBOutlet weak var groupNameEnglishLabel: UILabel!
    @IBOutlet weak var onDateLabel: UILabel!
    private let workTypeData = ["Full Time".localized(),"Part Time".localized(),"Contract".localized(),"Others".localized()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }
    
    
    private func initlization(){
        setEmpData()
    }
    
    
    private func setEmpData(){
        let data = ViewEmployeeDetailsVC.empData
        let percentNumber = data.profile_percentage?.total ?? "00.00"
        profilePercentLabel.text = "\("Profile".localized()): \(percentNumber)%"
        profilePercentProgressView.progress = Float(percentNumber)! / 100
        empAgeLabel.text = "\("Age".localized()) \(data.data?.age_in_years ?? "")"
        empNumberLabel.text = data.data?.employee_number ?? ""
        self.getImagFormAPI(url: data.data?.profile_image ?? "")
        empIDNumberLabel.text = data.data?.employee_id_number ?? ""
        referenceNoLabel.text = data.data?.e_reference_no ?? ""
        branchLabel.text = data.data?.branch_name ?? ""
        nameEnglishLabel.text = "\(data.data?.firstname_english ?? "") \(data.data?.secondname_english ?? "") \(data.data?.thirdname_english ?? "") \(data.data?.lastname_english ?? "")"
        nameArabicLabel.text = "\(data.data?.firstname_arabic ?? "") \(data.data?.secondname_arabic ?? "") \(data.data?.thirdname_arabic ?? "") \(data.data?.lastname_arabic ?? "")"
        expiryDateLabel.text = "\(data.data?.iqama_expiry_date_english ?? "") - \(data.data?.iqama_expiry_date_arabic ?? "")"
        copyNumberLabel.text = data.data?.copy_number ?? ""
        dateOfBirthLabel.text = "\(data.data?.birth_date_english ?? "") - \(data.data?.birth_date_arabic ?? "")"
        genderLabel.text = data.data?.gender == "M" ? "Male".localized() : "FeMale".localized()
        nationalityLabel.text = data.data?.nationality ?? ""
        usersTypeLabel.text = data.data?.typename ?? ""
        jobTitleLabel.text = data.data?.job_title_iqama ?? ""
        lang_human_resources_job_titleLabel.text = data.data?.jobname ?? ""
        statusLabel.text = data.data?.employee_status == "1" ? "Active".localized() : "Inactive".localized()
        
        if data.data?.marital_status == "S"{
            self.maritalStatusLabel.text = "Single".localized()
        }else if data.data?.marital_status == "M"{
            self.maritalStatusLabel.text = "Married".localized()
        }else if data.data?.marital_status == "D"{
            self.maritalStatusLabel.text = "Diversed".localized()
        }else{
            self.maritalStatusLabel.text = "Others".localized()
        }
        
        
        religionLabel.text = data.data?.religion ?? ""
        workDomainLabel.text = data.data?.work_domain ?? ""
        workLocationLabel.text = data.data?.work_location ?? ""
        
        if let index = Int(data.data?.work_type ?? "0"){
            workTypeLabel.text =  workTypeData[index + 1]
        }
        
        groupNameEnglishLabel.text = data.data?.groupname ?? ""
        onDateLabel.text = data.data?.created_datetime ?? ""
        
    }
    
    
    private func convertBase64StringToImage (imageBase64String:String) -> UIImage? {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        if let imageData = imageData {
            let image = UIImage(data: imageData)
            return image
        }
        return nil
    }
    
    
    private func getImagFormAPI(url:String){
        APIController.shard.getImage(url: url) { data in
            DispatchQueue.main.async{
                if let status = data.status,status{
                    
                    if let image = self.convertBase64StringToImage(imageBase64String: data.base64 ?? ""){
                        self.empImageView.image = image
                        return
                    }
                    
                }
                self.empImageView.image = UIImage(named: "male")!
            }
        }
    }
    
}
