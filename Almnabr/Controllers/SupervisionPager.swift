//
//  SupervisionPager.swift
//  Almnabr
//
//  Created by MacBook on 04/03/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class SupervisionPager: UIPageViewController {

    
    var pages = [UIViewController]()
    var newIndex = 1
    
    private var currentPageIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
       
        self.isPagingEnabled = false
        
        let page1 = storyboard?.instantiateViewController(withIdentifier: "SupervisionOperationDetailsVC") as! SupervisionOperationDetailsVC
        let page2 = storyboard?.instantiateViewController(withIdentifier: "ProjectRequestVC") as! ProjectRequestVC
        
        pages.append(page1)
        pages.append(page2)
        
        setViewControllers([page1], direction: .forward, animated: false, completion: nil)
        
        pager_observer()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //  displayPageForIndex(index: newIndex, animated: true)
    }
    
    
    private func pager_observer(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Change_Supervision"), object: nil, queue: .main) { notifi in
            guard let obj = notifi.object as? (Int,String) else { return }
            self.displayPageForIndex(index: obj.0)
            if obj.0 == 1{
                let vc = self.pages[1] as! ProjectRequestVC
                vc.projects_work_area_id = obj.1
            }
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

extension SupervisionPager: UIPageViewControllerDataSource {
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
        return 2
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

