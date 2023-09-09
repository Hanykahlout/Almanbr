//
//  AccountSettingsPageViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 03/01/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit

class AccountSettingsPageViewController: UIPageViewController {
    
    var pages = [UIViewController]()
    var newIndex = 1
    
    private var currentPageIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let page1 = PermissionMentionsViewController()
        let page2 = AccountsSettingsViewController()
        let page3 = AccountTaxViewController()
        let page4 = InvoiceSettingsViewController()
        let page5 = FinancialYearsViewController()
        let page6 = BlockAccountsViewController()
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pages.append(page4)
        pages.append(page5)
        pages.append(page6)
       
        
        setViewControllers([page1], direction: .forward, animated: false, completion: nil)

    }

    func refresh(){
        
    }
    
//    private func pager_observer(){
//        NotificationCenter.default.addObserver(forName: NSNotification.Name("Change_Page"), object: nil, queue: .main) { notifi in
//            guard let index = notifi.object as? Int else { return }
//            self.displayPageForIndex(index: index)
//        }
//    }
    
    func displayPageForIndex(index: Int, animated: Bool = true) {
        assert(index >= 0 && index < self.pages.count, "Error: Attempting to display a page for an out of bounds index")


        if self.currentPageIndex == index { return }

        if index < self.currentPageIndex {
            self.setViewControllers([self.pages[index]], direction: .reverse, animated: true, completion: nil)
        } else if index > self.currentPageIndex {
            self.setViewControllers([self.pages[index]], direction: .forward, animated: true, completion: nil)
        }

        self.currentPageIndex = index
    }
}

//extension AccountSettingsPageViewController: UIPageViewControllerDataSource {
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//
//        let currentIndex = pages.firstIndex(of: viewController)!
//
//        // This version will not allow pages to wrap around
//        guard currentIndex > 0 else {
//            return nil
//        }
//
//        return pages[currentIndex - 1]
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//
//        let currentIndex = pages.firstIndex(of: viewController)!
//
//        // This version will not allow pages to wrap around
//        guard currentIndex < pages.count - 1 else {
//            return nil
//        }
//
//        return pages[currentIndex + 1]
//    }
//
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return 4
//    }
//
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
//}

