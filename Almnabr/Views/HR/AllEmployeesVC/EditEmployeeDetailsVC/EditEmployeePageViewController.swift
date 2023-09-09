//
//  EditEmployeePageViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 13/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class EditEmployeePageViewController: UIPageViewController {
    
    
    private var containerVCs = [UIViewController]()
    public var empImageString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let idDetailsVC = IDDetailsViewController()
        idDetailsVC.empImageString = self.empImageString
        let contactDetailsVC = ContactDetailsViewController()
        let bankDetailsVC = BankDetailsViewController()
        let educationDetailsVC = EducationDetailsViewController()
        let passportDetailsVC = PassportDetailsViewController()
        let insuranceDetailsVC = InsuranceDetailsViewController()
        containerVCs.append(idDetailsVC)
        containerVCs.append(contactDetailsVC)
        containerVCs.append(bankDetailsVC)
        containerVCs.append(educationDetailsVC)
        containerVCs.append(passportDetailsVC)
        containerVCs.append(insuranceDetailsVC)
        delegate = self
        dataSource = self
        if let firstVC = containerVCs.first{
            setViewControllers([firstVC], direction: .forward, animated: true)
        }
        
    }

    func changeVC(selectedSection:SelectedSection,direction:UIPageViewController.NavigationDirection){
        switch selectedSection {
        case .IDDetailsVC:
            setViewControllers([containerVCs[0]], direction: direction, animated: true)
        case .ContactDetailsVC:
            setViewControllers([containerVCs[1]], direction: direction, animated: true)
        case .BankDetailsVC:
            setViewControllers([containerVCs[2]], direction: direction, animated: true)
        case .EducationDetailsVC:
            setViewControllers([containerVCs[3]], direction: direction, animated: true)
        case .PassportDetailsVC:
            setViewControllers([containerVCs[4]], direction: direction, animated: true)
        case .InsuranceDetailsVC:
            setViewControllers([containerVCs[5]], direction: direction, animated: true)
        }
    }
    
    private func getSelectedSection(index:Int) -> (SelectedSection,IndexPath)?{
        if L102Language.currentAppleLanguage() == "en"{
        switch index{
        case 0:
            return (.IDDetailsVC,IndexPath(item: 0, section: 0))
        case 1:
            return (.ContactDetailsVC,IndexPath(item: 1, section: 0))
        case 2:
            return (.BankDetailsVC,IndexPath(item: 2, section: 0))
        case 3:
            return (.EducationDetailsVC,IndexPath(item: 3, section: 0))
        case 4:
            return (.PassportDetailsVC,IndexPath(item: 4, section: 0))
        case 5:
            return (.InsuranceDetailsVC,IndexPath(item: 5, section: 0))
        default:
            return nil
        }
        }else{
            switch index{
            case 0:
                return (.IDDetailsVC,IndexPath(item: 5, section: 0))
            case 1:
                return (.ContactDetailsVC,IndexPath(item: 4, section: 0))
            case 2:
                return (.BankDetailsVC,IndexPath(item: 3, section: 0))
            case 3:
                return (.EducationDetailsVC,IndexPath(item: 2, section: 0))
            case 4:
                return (.PassportDetailsVC,IndexPath(item: 1, section: 0))
            case 5:
                return (.InsuranceDetailsVC,IndexPath(item: 0, section: 0))
            default:
                return nil
            }
        }
    }
    
    
}


extension EditEmployeePageViewController: UIPageViewControllerDelegate,UIPageViewControllerDataSource{
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = containerVCs.firstIndex(of: viewController) else{
            return nil
        }
        let index = currentIndex - 1
        guard index >= 0 else { return nil }
        if let selectedSection = getSelectedSection(index: index){
            NotificationCenter.default.post(name: NSNotification.Name("ChangeSelectedSection"), object: selectedSection)
        }
        
        return containerVCs[index]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = containerVCs.firstIndex(of: viewController) else{
            return nil
        }
        
        let index = currentIndex + 1
        guard index < containerVCs.count  else { return nil }
        
        if let selectedSection = getSelectedSection(index: index){
            NotificationCenter.default.post(name: NSNotification.Name("ChangeSelectedSection"), object: selectedSection)
        }
        
        return containerVCs[index]
    }
    
    
}
