//
//  PagerVC.swift
//  Almnabr
//
//  Created by MacBook on 10/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class PagerVC: UIViewController {
    
    @IBOutlet weak var pager_view: UIView!
    
    var pageViewController: UIPageViewController!
    var index = 0
    
    private var vc_array : [UIViewController] = []
    
    var isFromHome: Bool = false
    var isFromFinish: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageController()
    }
    @IBAction func next_Click(_ sender: Any) {
        
    }
    @IBAction func previous_Click(_ sender: Any) {
        
    }
    
}

extension PagerVC {
    private func setupPageController() {
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        // Append VCS
        // vc_array -> Your Array
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

        
        vc_array.append(page1)
        vc_array.append(page2)
        vc_array.append(page3)
        vc_array.append(page4)
        vc_array.append(page5)
        vc_array.append(page6)
        vc_array.append(page7)
        vc_array.append(page8)
        vc_array.append(page9)
        vc_array.append(page10)
        vc_array.append(page11)
        
//        setViewControllers([page1], direction: .forward, animated: false, completion: nil)
        
        
        let viewController = viewControllerAtIndex(index)
        guard let vc = viewController else { return }
        
        pageViewController.setViewControllers([vc], direction: .forward, animated: true)
        pageViewController.dataSource = self
        
        addChild(pageViewController)
        pager_view.addSubview(pageViewController.view)
        
        pageViewController!.view.frame = pager_view.bounds
        pageViewController.didMove(toParent: self)
        
        // Add the page view controller's gesture recognizers to the view controller's view so that the gestures are started more easily.
        view.gestureRecognizers = pageViewController.gestureRecognizers
    }

}

extension PagerVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let id = indexOfViewController(viewController) else {return nil}
        let prev = id - 1
        guard prev >= 0 else {return nil}
        guard vc_array.count > prev  else {return nil}
        return viewControllerAtIndex(prev)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard finished else {return}
        guard let current = self.pageViewController.viewControllers?.first else {return}
        guard let i = vc_array.firstIndex(of: current) else { return}
        debugPrint("i is \(i)")
        index = i
    }
    
    private func viewControllerAfter(_ viewController:UIViewController) -> UIViewController? {
        guard let id = indexOfViewController(viewController) else {return nil}
        let next = id + 1
        guard next < vc_array.count else { return nil }
        guard vc_array.count > next else { return nil }
        index += 1
        return viewControllerAtIndex(next)
    }
}

extension PagerVC {
    fileprivate func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        if vc_array.count == 0 || index >= vc_array.count {
            return nil
        }
        return vc_array[index]
    }
    
    fileprivate func indexOfViewController(_ viewController: UIViewController) -> Int? {
        return vc_array.firstIndex(of: viewController)
    }
    
    private func getCurrentIndex() -> Int? {
        guard let current = self.pageViewController.viewControllers?.first else {return nil }
        return vc_array.firstIndex(of: current)
    }
}


