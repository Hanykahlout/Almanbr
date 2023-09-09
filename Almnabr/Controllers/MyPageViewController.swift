//
//  MyPageViewController.swift
//  Almnabr
//
//  Created by MacBook on 06/11/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class MyPageViewController: UIPageViewController {
    
    var pages = [UIViewController]()
    var newIndex = 1
    
    private var currentPageIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
       
        self.isPagingEnabled = false
        
        let page1 = storyboard!.instantiateViewController(withIdentifier: "FromTransactionVC") as! FromTransactionVC
        let page2 = storyboard!.instantiateViewController(withIdentifier: "TeamUserVC") as! TeamUserVC
        let page3 = storyboard!.instantiateViewController(withIdentifier: "ProjectImplementationPhasesVC")
        let page4 = storyboard!.instantiateViewController(withIdentifier: "ProjectContractorPaymentsVC") as! ProjectContractorPaymentsVC
        let page5 = storyboard!.instantiateViewController(withIdentifier: "DocumentsVC") as! DocumentsVC
        let page6 = storyboard!.instantiateViewController(withIdentifier: "TestReportsVC") as! TestReportsVC
        let page7 = storyboard!.instantiateViewController(withIdentifier: "ContactsVC") as! ContactsVC
        let page8 = storyboard!.instantiateViewController(withIdentifier: "ProjectOwnersVC") as! ProjectOwnersVC
        let page9 = storyboard!.instantiateViewController(withIdentifier: "ProjectRiskManagementVC") as! ProjectRiskManagementVC
        let page10 = storyboard!.instantiateViewController(withIdentifier: "ProjectWafiReportVC") as! ProjectWafiReportVC
        let page11 = storyboard!.instantiateViewController(withIdentifier: "ProjectCompletionVC") as! ProjectCompletionVC
        let page12 = storyboard!.instantiateViewController(withIdentifier: "ProjectSettingsVC") as! ProjectSettingsVC
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pages.append(page4)
        pages.append(page5)
        pages.append(page6)
        pages.append(page7)
        pages.append(page8)
        pages.append(page9)
        pages.append(page10)
        pages.append(page11)
        pages.append(page12)
        
        setViewControllers([page1], direction: .forward, animated: false, completion: nil)
        
        pager_observer()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //  displayPageForIndex(index: newIndex, animated: true)
    }
    
    
    private func pager_observer(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Change_Page"), object: nil, queue: .main) { notifi in
            guard let index = notifi.object as? Int else { return }
            self.displayPageForIndex(index: index)
        }
    }
    
    func displayPageForIndex(index: Int, animated: Bool = true) {
        assert(index >= 0 && index < self.pages.count, "Error: Attempting to display a page for an out of bounds index")
        
        
        // nop if index == self.currentPageIndex
        if self.currentPageIndex == index { return }
        
        if index < self.currentPageIndex {
            self.setViewControllers([self.pages[index]], direction: .reverse, animated: true, completion: nil)
        } else if index > self.currentPageIndex {
            self.setViewControllers([self.pages[index]], direction: .forward, animated: true, completion: nil)
        }
        
        self.currentPageIndex = index
    }
}

extension MyPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let currentIndex = pages.firstIndex(of: viewController)!
        
        // This version will not allow pages to wrap around
        guard currentIndex > 0 else {
            return nil
        }
        
        return pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let currentIndex = pages.firstIndex(of: viewController)!
        
        // This version will not allow pages to wrap around
        guard currentIndex < pages.count - 1 else {
            return nil
        }
        
        return pages[currentIndex + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 4
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

