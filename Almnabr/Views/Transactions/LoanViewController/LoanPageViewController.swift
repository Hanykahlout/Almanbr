//
//  LoanPageViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 20/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class LoanPageViewController: UIPageViewController {
    
    var containerVCs = [UIViewController]()
    var currentIndex = 0
    
//    private var contractDataVC:ContractDataVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//
//        contractDataVC = ContractDataVC()
//
//        containerVCs.append(contractDataVC)
         
//        if let firstVC = containerVCs.first{
//            setViewControllers([firstVC], direction: .forward, animated: true)
//        }

    }
    
    func changeVC(direction:UIPageViewController.NavigationDirection){
//        let vc = containerVCs[currentIndex]
//        setViewControllers([vc], direction: direction, animated: true)
    }

//    func setContractData(data:Form_ct1_data?,addtionalAllowances:Form_ct1_data_additional_terms?){
//        contractDataVC.setData(data: data,addtionalAllowances: addtionalAllowances)
//    }
    
}
