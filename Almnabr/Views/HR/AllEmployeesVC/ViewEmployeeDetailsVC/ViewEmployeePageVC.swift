//
//  ViewEmployeePageVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 13/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ViewEmployeePageVC: UIPageViewController {
    
    private var containerVCs = [UIViewController]()
    var empID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let idDetailsVC = ViewEmpIDDetailsVC()
        let otherDetailsVC = OtherDetailsVC()
        otherDetailsVC.id = empID
        let contractDetailsVC = ContractDetailsOptionsVC()
        contractDetailsVC.id = empID
        let viewEmpDocumentsVC = ViewEmpDocumentsVC()
        let langVacationsVC = ViewEmpLangVacationsVC()
        let modulesVC = ViewEmpModulesVC()
        let langFinanialDetailsVC:FinanialDetailsViewController = AppDelegate.HRSB.instanceVC()
        langFinanialDetailsVC.isFromHR = true
        langFinanialDetailsVC.profile_obj = .init(["employee_number":empID])
        containerVCs.append(idDetailsVC)
        containerVCs.append(otherDetailsVC)
        containerVCs.append(contractDetailsVC)
        containerVCs.append(viewEmpDocumentsVC)
        containerVCs.append(langVacationsVC)
        containerVCs.append(modulesVC)
        containerVCs.append(langFinanialDetailsVC)
  

        if let firstVC = containerVCs.first{
            setViewControllers([firstVC], direction: .forward, animated: true)
        }
    }

    
    func changeVC(index:Int,direction:UIPageViewController.NavigationDirection){
        setViewControllers([containerVCs[index]], direction: direction, animated: true)
    }

}
