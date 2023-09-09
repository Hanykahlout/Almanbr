//
//  ViewOutgoingPageVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 26/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ViewOutgoingPageVC: UIPageViewController {
    
    private var containerVCs = [UIViewController]()
    var id = ""
    var isIncoming = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let requestDetailsVC = RequestDetailsViewController()
        requestDetailsVC.id = id
        requestDetailsVC.isIncoming = isIncoming
        containerVCs.append(requestDetailsVC)
        containerVCs.append(OngoingViewDetailsViewController())
        containerVCs.append(PresonDetailsViewController())
        let outgoingAttachVC = OutgoingAttachViewController()
        containerVCs.append(outgoingAttachVC)
        
        containerVCs.append(OutgoingHistoryViewController())
        delegate = self
        dataSource = self
        if let firstVC = containerVCs.first{
            setViewControllers([firstVC], direction: .forward, animated: true)
        }
        
    }
    
    
    func changeVC(index:Int,direction:UIPageViewController.NavigationDirection){
        setViewControllers([containerVCs[index]], direction: direction, animated: true)
    }

}


extension ViewOutgoingPageVC: UIPageViewControllerDelegate , UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = containerVCs.firstIndex(of: viewController) else{
            return nil
        }
        let index = currentIndex - 1
        guard index >= 0 else { return nil }
        NotificationCenter.default.post(name: .init("ViewOutgoingPageControllerScrolled"), object: index)
        return containerVCs[index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = containerVCs.firstIndex(of: viewController) else{
            return nil
        }

        let index = currentIndex + 1
        guard index < containerVCs.count  else { return nil }
        NotificationCenter.default.post(name: .init("ViewOutgoingPageControllerScrolled"), object: index)
        return containerVCs[index]
    }
    
}
