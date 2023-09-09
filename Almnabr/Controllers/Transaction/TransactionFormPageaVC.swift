//
//  TransactionFormPageaVC.swift
//  Almnabr
//
//  Created by MacBook on 07/12/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit

class TransactionFormPageaVC: UIPageViewController {
    
    
    var pages : [UIViewController] = []
    var newIndex = 1
    
    private var currentPageIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        self.isPagingEnabled = false
      
        let vc: LanguageVC = AppDelegate.mainSB.instanceVC()
        let page1 = UINavigationController(rootViewController: vc)

        let page2: ContractorTeamApprovalVC = AppDelegate.TransactionSB.instanceVC()
        let page3: ContractorManagerApprovalVC = AppDelegate.TransactionSB.instanceVC()
        let page4: RecipientVerificationVC = AppDelegate.TransactionSB.instanceVC()
        let page5: TechinicalAssistantVC = AppDelegate.TransactionSB.instanceVC()
        let page6: SpecialApprovalVC = AppDelegate.TransactionSB.instanceVC()
        let page7: EvaluationResultVC = AppDelegate.TransactionSB.instanceVC()
        let page8: AuthorizedPositionsApprovalVC = AppDelegate.TransactionSB.instanceVC()
        let page9: ManagerApprovalVC = AppDelegate.TransactionSB.instanceVC()
        let page10: OwnersRepresentativeVC = AppDelegate.TransactionSB.instanceVC()
        let page11: FinalResultVC = AppDelegate.TransactionSB.instanceVC()
        
        
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
        
        setViewControllers([page1], direction: .forward, animated: true, completion: nil)
        
        pager_observer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // self.displayPageForIndex(index: index)
       //  displayPageForIndex(index: newIndex, animated: true)
    }
    
    
    private func pager_observer(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Change_Form_Step"), object: nil, queue: .main) { notifi in
            guard let index = notifi.object as? Int else { return }
            self.displayPageForIndex(index: index)
        }
    }
    
    func displayPageForIndex(index: Int, animated: Bool = true) {
        
//        guard index < self.pages.count else { return }
        
        assert((index >= 0 && index <= self.pages.count), "Error: Attempting to display a page for an out of bounds index")
        
        if self.currentPageIndex == index { return }
        if index == 0 { return}
        print("index\( index)")
        print("currentPageIndex\( currentPageIndex)")
        if index  < self.currentPageIndex {
            
            DispatchQueue.main.async {
                self.setViewControllers([self.pages[index - 1]], direction: .reverse, animated: true, completion: nil)
            }
          
        } else if index > self.currentPageIndex   {
            DispatchQueue.main.async {
                self.setViewControllers([self.pages[index - 1]], direction: .forward, animated: true, completion: nil)
            }
          
        }
        
        self.currentPageIndex = index
    }
}


extension TransactionFormPageaVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let id = indexOfViewController(viewController) else {return nil}
        let prev = id - 1
        guard prev >= 0 else {return nil}
        guard pages.count > prev  else {return nil}
        return viewControllerAtIndex(prev)
        
//        let currentIndex = pages.index(of: viewController)!
//
//        // This version will not allow pages to wrap around
//        guard currentIndex > 0 else {
//            return nil
//        }
//
//        return pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//
//        let currentIndex = pages.index(of: viewController)!
//
//        // This version will not allow pages to wrap around
//        guard currentIndex < pages.count - 1 else {
//            return nil
//        }
//
//        return pages[currentIndex + 1]
//    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard finished else {return}
        guard let current = self.viewControllers?.first else {return}
        guard let i = pages.firstIndex(of: current) else { return}
        debugPrint("i is \(i)")
        newIndex = i
    }
    
    private func viewControllerAfter(_ viewController:UIViewController) -> UIViewController? {
        guard let id = indexOfViewController(viewController) else {return nil}
        let next = id + 1
        guard next < pages.count else { return nil }
        guard pages.count > next else { return nil }
        newIndex += 1
        return viewControllerAtIndex(next)
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

//extension TransactionFormPageaVC {
//    fileprivate func viewControllerAtIndex(_ index: Int) -> UIViewController? {
//        if vc_array.count == 0 || index >= vc_array.count {
//            return nil
//        }
//        return vc_array[index]
//    }
//    
//    fileprivate func indexOfViewController(_ viewController: UIViewController) -> Int? {
//        return vc_array.firstIndex(of: viewController)
//    }
//    
//    private func getCurrentIndex() -> Int? {
//        guard let current = self.pageViewController.viewControllers?.first else {return nil }
//        return vc_array.firstIndex(of: current)
//    }
//}

extension TransactionFormPageaVC {
    fileprivate func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        if pages.count == 0 || index >= pages.count {
            return nil
        }
        return pages[index]
    }
    
    fileprivate func indexOfViewController(_ viewController: UIViewController) -> Int? {
        return pages.firstIndex(of: viewController)
    }
    
    private func getCurrentIndex() -> Int? {
        guard let current = self.viewControllers?.first else {return nil }
        return pages.firstIndex(of: current)
    }
}

