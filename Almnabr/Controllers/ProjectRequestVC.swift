//
//  ProjectRequestVC.swift
//  Almnabr
//
//  Created by MacBook on 11/01/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import FontAwesome_swift

class ProjectRequestVC: UIViewController , filterDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var imgnodata: UIImageView!
    @IBOutlet weak var view_filter: UIView!
    @IBOutlet weak var view_sort: UIView!
    
    var arr_data:[ProjectRequestObj] = []
    var params:[String:Any] = [:]
    
    var pageNumber = 1
    var allItemDownloaded = false
    var projects_work_area_id = ""
    var arr_filter:[FilterObj] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configGUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        get_Form(showLoading: true, loadOnly: true)
    }
    

    func configNavigation() {
        _ = self.navigationController?.preferredStatusBarStyle
        self.view.backgroundColor = .clear
        //HelperClassSwift.acolor.getUIColor() //F0F4F8
        //navigationController?.navigationBar.barTintColor = .buttonBackgroundColor()
        navigationController?.navigationBar.barTintColor = HelperClassSwift.acolor.getUIColor()
       addNavigationBarTitle(navigationTitle: "Project Request".localized())
        UINavigationBar.appearance().backgroundColor = HelperClassSwift.acolor.getUIColor()
        
    }
    
    
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        self.table.dataSource = self
        self.table.delegate = self
        
        let nib = UINib(nibName: "ProjectRequestTVCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "ProjectRequestTVCell")
        
        view_filter.setBorderGray()
        view_sort.setBorderGray()
        
        view_filter.setRounded()
        view_sort.setRounded()
//       let sortImage  =  UIImage.fontAwesomeIcon(name: .sortAmountDownAlt , style: .solid, textColor:  .gray, size: CGSize(width: 25, height: 25))
//        let filterImage  = UIImage.fontAwesomeIcon(name: .filter , style: .solid, textColor:  .gray, size: CGSize(width: 25, height: 25))
//
//        
//        let filterButton   = UIBarButtonItem(image: filterImage,  style: .plain, target: self, action: #selector(didTapFilterButton(sender:)))
//        let sortButton = UIBarButtonItem(image: sortImage,  style: .plain, target: self, action: #selector(didTapSortButton(sender:)))
//
//
//        navigationItem.rightBarButtonItems = [filterButton, sortButton]
        
       
        
        
    }
    
    @IBAction func didTapFilterButton(_ sender: Any) {
        
        let vc:FilterVC  = AppDelegate.mainSB.instanceVC()
        
        vc.delegate = self
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func didTapSortButton(_ sender: Any) {
        
        let vc:SortVC  = AppDelegate.mainSB.instanceVC()
        
        vc.delegate = self
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    @objc func didTapFilterButton(sender: AnyObject){
//
//
//        //self.present(vc, animated: true, completion: nil)
//    }
    
//    @objc func didTapSortButton(sender: AnyObject){
//
//
//       // self.present(vc, animated: true, completion: nil)
//    }
    
    
    func get_Form(showLoading: Bool, loadOnly: Bool){
        
        
        if showLoading {
            self.showLoadingActivity()
        }
        
        self.params["projects_supervision_id"] = projects_supervision_id
        
        APIController.shard.sendRequestPostAuth(urlString: "pr/qtp/\(projects_work_area_id)/pages/\(pageNumber)/10", parameters: self.params ) { (response) in
            self.hideLoadingActivity()
            
            
            if self.pageNumber == 1 {
                self.arr_data.removeAll()
            }
            if loadOnly {
                self.table.reloadData()
            }
            
            let status = response["status"] as? Bool
            
            if status == true{
                
                let page = response["page"] as? [String:Any]
                
                if  let list = response["records"] as? NSArray{
                    for i in list {
                        let dict = i as? [String:Any]
                        let obj = ProjectRequestObj.init(dict!)
                        self.arr_data.append(obj)
                    }
                    self.table.reloadData()
                    let pageObj = PageObj(page!)
                    
                    if pageObj.total_pages > self.pageNumber {
                        self.allItemDownloaded = false
                    }else{
                        self.allItemDownloaded = true
                    }
                    if list.count == 0 {
                        self.imgnodata.isHidden = false
                    }else{
                        self.imgnodata.isHidden = true
                    }
                    self.hideLoadingActivity()
                }
            }else{
                
                self.imgnodata.isHidden = false
                self.hideLoadingActivity()
            }
            
            
            
        }
    }
    
    
    func pass(param: [String:Any]) { //conforms to protocol
     // implement your own implementation
        self.arr_data = []
        pageNumber = 1
        self.params = param
        get_Form(showLoading: true, loadOnly: true)
        
      }
    
   
    
    
}


extension ProjectRequestVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return arr_data.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectRequestTVCell", for: indexPath) as! ProjectRequestTVCell
        
        let obj = arr_data[indexPath.item]
          
        
        cell.lblPlatformTitle.text = "\(obj.platform_name)"
        cell.lblChapter.text = "\(obj.group1_name)"
        cell.lblDivision.text = "\(obj.group2_name)"
        
        cell.lblBarcode.text = "\(obj.barcode)"
        cell.lblRequestNo.text = "\(obj.transaction_request_id)"
        cell.lblStep.text = "\(obj.transaction_request_last_step)"
        
        cell.lblPlatformCodeSystem.text = "Request No : \(obj.platform_code_system)"
        
        let color = "696969".getUIColor()
        
        cell.lblUnit.setFontAndcolor(stringValue: "\(obj.unit_id)", coloredValue: "Unit \n".localized(), withTextSize: 11, color: color )
        cell.lblByPhases.setFontAndcolor(stringValue: "   \(obj.phase_short_code)", coloredValue: "ByPhases \n".localized(), withTextSize: 11, color: color)
        cell.lblLevel.setFontAndcolor(stringValue: "   \(obj.level_name)", coloredValue: "Level \n".localized(), withTextSize: 11, color: color)
        cell.btn_Action = {
            
            if obj.file_path != "" {
                let vc:PDFViewrVC  = AppDelegate.mainSB.instanceVC()
                
                vc.isModalInPresentation = true
                //vc.modalPresentationStyle = .overFullScreen
                vc.definesPresentationContext = true
                vc.Strurl = obj.file_path
                self.present(vc, animated: true, completion: nil)
            }
            
        }
       
        switch obj.color {
        case "RED":
            cell.viewStep.backgroundColor = "ff1a1a".getUIColor()
        case "ORANGE":
            cell.viewStep.backgroundColor = "ffad33".getUIColor()
        case "GREEN":
            cell.viewStep.backgroundColor = "#32a852".getUIColor()
        default:
            cell.viewStep.backgroundColor = .lightGray
        }
        
        
        
        
        return cell
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let obj = arr_data[indexPath.item]
        
        guard HeaderView.shared.menu_vc() != nil else { return }
        
        let vc : TransactionFormDetailsVC = AppDelegate.TransactionSB.instanceVC()
        
        vc.request_id =  obj.transaction_request_id
        vc.IsFromNotification = false
        vc.filePath = obj.file_path
        self.navigationController?.pushViewController(vc, animated: true)
        
//        if let top_vc = UIApplication.get_topvc() {
//
//
//
//            top_vc.navigationController?.pushViewController(vc, animated: true)
//            //top_vc.navigationController?.pushViewController(vc, animated: true)
//        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.tag == 0 {
            
            
            print(indexPath.section)
            if indexPath.row   == arr_data.count - 1  {
                updateNextSet()
                print("next step")
                print("XXXX-Testing")
            }
        }
    }
    
    func updateNextSet(){
        print("On Completetion")
        if !allItemDownloaded {
            pageNumber = pageNumber + 1
            get_Form(showLoading: false, loadOnly: true)
        }
    }
    
    
}



extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

