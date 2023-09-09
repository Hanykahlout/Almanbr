//
//  OngoingViewDetailsViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 26/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class OngoingViewDetailsViewController: UIViewController {
    
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var fromLAbel: UILabel!
    @IBOutlet weak var organizationLabel: UILabel!
    @IBOutlet weak var issueDateArLabel: UILabel!
    @IBOutlet weak var issueDateEnLabel: UILabel!
    @IBOutlet weak var issuedNumberLabel: UILabel!
    @IBOutlet weak var attachmentsLabel: UILabel!
    @IBOutlet weak var receipientLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var markersLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var issueDateEnglishStackView: UIStackView!
    @IBOutlet weak var issueDateArabicStackView: UIStackView!
    @IBOutlet weak var issuedNumberStackView: UIStackView!
    @IBOutlet weak var receipientStackView: UIStackView!
    
    @IBOutlet weak var signatureStampView: UIView!
    @IBOutlet weak var reviewersView: UIView!
    
    @IBOutlet weak var jobTitleALabel: UILabel!
    @IBOutlet weak var employeeNameALabel: UILabel!
    @IBOutlet weak var jobTitleBLabel: UILabel!
    @IBOutlet weak var employeeNameBLabel: UILabel!
    @IBOutlet weak var jobTitleCLabel: UILabel!
    @IBOutlet weak var employeeNameCLabel: UILabel!
    
    @IBOutlet weak var reviewersLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlziation()
        // Do any additional setup after loading the view.
    }
    
    private func initlziation(){
        setData()
    }
    
    private func setData(){
        let isIncoming = ViewOutgoingViewController.data?.isIncoming ?? false
        languageLabel.text = ViewOutgoingViewController.data?.transactions_request?.language_name ?? ""
        subjectLabel.text = ViewOutgoingViewController.data?.transactions_request?.transaction_request_description ?? ""
        headerLabel.text = subjectLabel.text!.uppercased()
        fromLAbel.text = ViewOutgoingViewController.data?.transactions_request?.transaction_from_name ?? ""
        organizationLabel.text = ViewOutgoingViewController.data?.transactions_request?.transaction_to_name ?? ""
        descriptionLabel.text = isIncoming ? ViewOutgoingViewController.data?.form_c2_data?.records?.first?.content ?? "" :  ViewOutgoingViewController.data?.form_c1_data?.records?.first?.content ?? ""
        attachmentsLabel.text = isIncoming ? ViewOutgoingViewController.data?.form_c2_data?.records?.first?.attachment ?? "" : ViewOutgoingViewController.data?.form_c1_data?.records?.first?.attachment ?? ""
        
        if let records = ViewOutgoingViewController.data?.transactions_persons?.records {
            var markers = ""
            var reviewer = ""
            
            for index in 0..<records.count{
                switch records[index].transaction_persons_type {
                case "marks":
                    markers.append(",\(records[index].person_name ?? "")")
                case "signature":
                    switch records[index].transactions_persons_val1 {
                    case "A":
                        employeeNameALabel.text = records[index].person_name ?? ""
                        jobTitleALabel.text = records[index].transactions_persons_val2 ?? ""
                    case "B":
                        employeeNameBLabel.text = records[index].person_name ?? ""
                        jobTitleBLabel.text = records[index].transactions_persons_val2 ?? ""
                    case "C":
                        employeeNameCLabel.text = records[index].person_name ?? ""
                        jobTitleCLabel.text = records[index].transactions_persons_val2 ?? ""
                    default:
                        break
                    }
                case "reviews":
                    reviewer.append(",\(records[index].person_name ?? "")")
                default:
                    break
                }
            }
            
            
            markersLabel.text = markers
            reviewersLabel.text = reviewer
        }
        
        signatureStampView.isHidden = isIncoming
        reviewersView.isHidden = isIncoming
        issueDateEnglishStackView.isHidden = !isIncoming
        issueDateArabicStackView.isHidden = !isIncoming
        issuedNumberStackView.isHidden = !isIncoming
        receipientStackView.isHidden = !isIncoming
        
        
        
        issueDateArLabel.text = ViewOutgoingViewController.data?.form_c2_data?.records?.first?.issued_date_h ?? ""
        issueDateEnLabel.text = ViewOutgoingViewController.data?.form_c2_data?.records?.first?.issued_date_m ?? ""
        issuedNumberLabel.text = ViewOutgoingViewController.data?.form_c2_data?.records?.first?.issued_number ?? ""
        receipientLabel.text = ViewOutgoingViewController.data?.transactions_persons?.records?.first?.person_name ?? ""
        
        
        
        
    }
    
    
}
