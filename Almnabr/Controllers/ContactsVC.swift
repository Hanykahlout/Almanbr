//
//  ContactsVC.swift
//  Almnabr
//
//  Created by MacBook on 20/10/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//
import UIKit
import DPLocalization
import FontAwesome_swift
import DropDown

class ContactsVC: UIViewController {

    
    @IBOutlet weak var lblContact: UILabel!
    
    @IBOutlet weak var viewContact: UIView!
    
    @IBOutlet weak var btnContact: UIButton!
    
    @IBOutlet weak var imgDropContact: UIImageView!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var viewsearch: UIView!
    @IBOutlet weak var img_nodata: UIImageView!
    @IBOutlet weak var tableHeightConstraint:NSLayoutConstraint!
    
    
    var StrTitle:String = ""
    var StrSubMenue:String = ""
    var StrContact:String = ""
    var SearchKey:String = ""
    
    
    var pageNumber = 1
    var total:Int = 0
    var allItemDownloaded = false
    var MenuObj:MenuObj?
    var SubMenuObj:MenuObj?
    var arr_data:[ContactObj] = []
    var arr_ContactLabel:[String] = ["All".localized(),"Contractors".localized(),"Customers".localized(),"Others".localized()]
    var arr_Contactvalue:[String] = ["","1","2","3"]
    var arr_NoData:[String] = ["No items found".localized()]
    
    let dropUpmage =  UIImage.fontAwesomeIcon(name: .chevronUp , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    let dropDownmage =  UIImage.fontAwesomeIcon(name: .chevronDown , style: .solid, textColor:  .gray, size: CGSize(width: 40, height: 40))
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        configGUI()
        get_Contact_data(showLoading: true, loadOnly: true)
        
        
    }
    
    
    // MARK: - Config Navigation
    func configNavigation() {
        _ = self.navigationController?.preferredStatusBarStyle
        self.view.backgroundColor = "FFFFFF".getUIColor() //F0F4F8
        navigationController?.navigationBar.barTintColor = .red
        
        addNavigationBarTitle(navigationTitle: StrTitle)
    }
    
//    override func viewDidLayoutSubviews() {
//        tableHeightConstraint.constant = table.contentSize.height
//        
//    }
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        self.viewsearch.setBorderGrayWidthCorner(1, 20)
        
        
        self.viewContact.setBorderGrayWidthCorner(1, 20)
        self.lblContact.text =  "All".localized()
        self.lblContact.font = .kufiRegularFont(ofSize: 15)
        
        
        searchBar.delegate = self
        btnContact.isHidden = true
        
        self.imgDropContact.image = dropDownmage
        
        
        table.dataSource = self
        table.delegate = self
        let nib = UINib(nibName: "ContactTVCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "ContactTVCell")
        
        
    }
    
    func get_Contact_data(showLoading: Bool, loadOnly: Bool){
        
        if showLoading {
            self.showLoadingActivity()
        }
        let search:String = SearchKey.replacingOccurrences(of: " ", with: "%20").trim()
        
        APIController.shard.sendRequestGetAuth(urlString: "ckhGSW9rIyAlGX6/\(projects_profile_id)/\(projects_supervision_id)/\(pageNumber)/10?searchKey=\(search)&contacts_type=\(StrContact)" ) { (response) in
            
            if self.pageNumber == 1 {
                self.arr_data.removeAll()
            }
            let status = response["status"] as? Bool
            // let total = response["total"] as? Int
            if loadOnly {
                self.table.reloadData()
            }
            
            let page = response["page"] as? [String:Any]
            // let list = response["list"] as? [String:Any]
            if status == true{
                //   self.total = total!
                
                if  let records = response["records"] as? NSArray{
                    for i in records {
                        let dict = i as? [String:Any]
                        let obj = ContactObj.init(dict!)
                        self.arr_data.append(obj)
                    }
                    
                    let pageObj = PageObj(page!)
                    
                    
                    if self.arr_data.count == 0 {
                        self.img_nodata.isHidden = false
                    }else{
                        self.img_nodata.isHidden = true
                    }
                    if pageObj.total_pages > self.pageNumber {
                        self.allItemDownloaded = false
                    }else{
                        self.allItemDownloaded = true
                    }
                    self.table.reloadData()
                    
                    self.hideLoadingActivity()
                }
                
            }else{
                self.hideLoadingActivity()
                self.img_nodata.isHidden = false
            }
            
            
        }
        
     
        
    }
    
    
//    func get_Contact(){
//
//        self.showLoadingActivity()
//        APIManager.sendRequestGetAuth(urlString: "/366484fd45" ) { (response) in
//
//
//            let status = response["status"] as? Bool
//            if status == true{
//                if  let list = response["records"] as? NSArray{
//                    for i in list {
//                        let dict = i as? [String:Any]
//                        let obj = ModuleObj.init(dict!)
//                        self.arr_Contact.append(obj)
//
//                        self.arr_ContactLabel.append(obj.label)
//
//
//                    }
//                    self.hideLoadingActivity()
//                }
//            }
//            self.hideLoadingActivity()
//
//        }
//    }
    
    
    
    @IBAction func btnContact_Click(_ sender: Any) {
        
        self.imgDropContact.image = dropUpmage
        let vc :PickerVC = AppDelegate.mainSB.instanceVC()
        vc.arr_data =  arr_ContactLabel
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .overFullScreen
        vc.definesPresentationContext = true
        vc.delegate = {name , index in
            if name == self.arr_ContactLabel[index] {
                self.lblContact.text =  name
                let i =  self.arr_Contactvalue[index]
                self.StrContact = i
                self.imgDropContact.image = self.dropDownmage
                //self.btnContact.isHidden = false
                self.get_Contact_data(showLoading: true, loadOnly: true)
                
            }
        }
        self.present(vc, animated: true, completion: nil)
        
//        self.imgDropContact.image = dropUpmage
//        let dropDown = DropDown()
//        dropDown.anchorView = view
//        dropDown.backgroundColor = .white
//        dropDown.cornerRadius = 2.0
//
//        if self.arr_ContactLabel.count == 0 {
//            dropDown.dataSource = self.arr_NoData
//            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//                self.imgDropContact.image = dropDownmage
//            }
//            dropDown.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        }else{
//
//        dropDown.dataSource = self.arr_ContactLabel
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//
//            if item == self.arr_ContactLabel[index] {
//                self.lblContact.text =  item
//                let i =  self.arr_Contactvalue[index]
//                self.StrContact = i
//                self.imgDropContact.image = dropDownmage
//                //self.btnContact.isHidden = false
//                get_Contact_data(showLoading: true, loadOnly: true)
//
//            }
//
//        }}
//        dropDown.direction = .bottom
//        dropDown.anchorView = viewContact
//        dropDown.bottomOffset = CGPoint(x: 0, y: viewContact.bounds.height)
//        dropDown.width = viewContact.bounds.width
//        dropDown.show()
    }
    
    
    @IBAction func btnContactDelete_Click(_ sender: Any) {
        self.lblContact.text = "All".localized()
        self.btnContact.isHidden = true
        self.StrContact = ""
        get_Contact_data(showLoading: true, loadOnly: true)
    }
    
}


extension ContactsVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTVCell", for: indexPath) as! ContactTVCell
        
        let obj = arr_data[indexPath.item]
        
        let Name =  "\(obj.contacts_name)"
        let Type = "Type".localized() + "  \(obj.contacts_type)"
        let Email = "\(obj.contacts_email)"
        let Mobile = "\(obj.contacts_mobile)"
        
        let Whatsapp = "\(obj.contacts_whatsapp)"
        let Fax = "\(obj.contacts_fax)"
        let writer = "By".localized() + ":  \(obj.writer)"
        let Date =  "\(obj.contacts_created_datetime)"
        
        let maincolor = "#1A3665".getUIColor()
        
        
        cell.lblName.text = Name
        cell.lblWriter.text = writer
        cell.lblDate.text = Date
        
        cell.btnfax.setTitle(Fax, for: .normal)
        cell.btnwhats.setTitle(Whatsapp, for: .normal)
        cell.btnMoile.setTitle(Mobile, for: .normal)
        cell.btnEmail.setTitle(Email, for: .normal)
        
        cell.viewBack.setRounded(12)
        
        let Typeattribute: NSAttributedString = Type.attributedStringWithColor(["Type"], color: maincolor)
        cell.lblType.attributedText = Typeattribute
        
        
        let writerattribute: NSAttributedString = writer.attributedStringWithColor(["By"], color: maincolor)
        cell.lblWriter.attributedText = writerattribute
        
      
        cell.btn_FaxAction = {
            print("nil")
        }
        
        cell.btn_EmailAction = {
            let googleUrlString = "googlegmail:///co?to=\(Email)"

            if let googleUrl = URL(string: googleUrlString) {
                UIApplication.shared.open(googleUrl, options: [:]) {
                    success in
                    if !success {
                         // Notify user or handle failure as appropriate
                    }
                }
            }
            
        }
        
        cell.btn_whatsAction = {
            UIApplication.shared.openURL(URL(string:"https://api.whatsapp.com/send?phone=\(Whatsapp)")!)
        }
        
        cell.btn_MobileAction = {
            
            
            if let url = URL(string: "tel://\(Mobile)"),
              UIApplication.shared.canOpenURL(url) {
                 if #available(iOS 10, *) {
                   UIApplication.shared.open(url, options: [:], completionHandler:nil)
                  } else {
                      UIApplication.shared.openURL(url)
                  }
              } else {
                       // add error message here
              }
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.tag == 0 {
            
            print(indexPath.section)
            if indexPath.row   == arr_data.count - 1  {
                
                updateNextSet()
                print("next step")
                
            }
        }
    }
    
    func updateNextSet(){
        print("On Completetion")
        if !allItemDownloaded {
            pageNumber = pageNumber + 1
            get_Contact_data(showLoading: false, loadOnly: false)
        }
    }
}

extension ContactsVC:UISearchBarDelegate {
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
       self.SearchKey = searchBar.text!
        get_Contact_data(showLoading: false, loadOnly: false)
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
}
