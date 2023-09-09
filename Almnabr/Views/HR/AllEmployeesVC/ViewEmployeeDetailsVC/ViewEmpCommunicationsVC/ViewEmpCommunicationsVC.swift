//
//  ViewEmpCommunicationsVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 12/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown

class ViewEmpCommunicationsVC: UIViewController {
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterArrow: UIImageView!
    @IBOutlet weak var seachTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    private var filterDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    
    private func initlization(){
        setUpDropDownLists()
    }
    
    private func setUpDropDownLists(){
        // Filter Drop Down
        filterDropDown.anchorView = filterView
        
        filterDropDown.bottomOffset = CGPoint(x: 0 , y:(filterDropDown.anchorView?.plainView.bounds.height)!)
        
        if L102Language.currentAppleLanguage() == "ar"{
            filterDropDown.convertToArLang()
        }
        
        
        filterDropDown.dataSource = ["Incoming".localized(),"Outgoing".localized()]
        filterLabel.text = "Outgoing".localized()
        
        filterDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.filterArrow.transform = .init(rotationAngle: 0)
            self.filterLabel.text = item
            
        }
        
        filterDropDown.cancelAction = { [unowned self] in
            self.filterArrow.transform = .init(rotationAngle: 0)
        }
        filterView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(filterViewAction)))
    }
    
    @objc private func filterViewAction(){
        self.filterArrow.transform = .init(rotationAngle: .pi)
        filterDropDown.show()
    }
    
    
    @IBAction func addAction(_ sender: Any) {
        let alertVC = UIAlertController(title: "Choose the type of connections you want to make ".localized(), message: "", preferredStyle: .actionSheet)
        alertVC.addAction(.init(title: "Incoming".localized(), style: .default, handler: { action in
            self.goToOutgoingVC(isIncoming: true)
        }))
        
        alertVC.addAction(.init(title: "Outgoing".localized(), style: .default, handler: { action in
            self.goToOutgoingVC(isIncoming: false)
        }))
        
        alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel, handler: nil))
        present(alertVC, animated: true)
    }
    
    
    private func goToOutgoingVC(isIncoming:Bool){
        let vc = OutgoingVC()
        vc.isIncoming = isIncoming
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.setNavigationBarHidden(true, animated: false)
        self.navigationController?.present(nav, animated: true)
    }
    
    
}
