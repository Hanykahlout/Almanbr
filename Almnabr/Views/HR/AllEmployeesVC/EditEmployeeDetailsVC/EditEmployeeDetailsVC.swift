//
//  EditEmployeeDetailsVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 08/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class EditEmployeeDetailsVC: UIViewController {
    
    @IBOutlet weak var nextButotn: UIButton!
    
    @IBOutlet weak var previousButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var data = [SectionInfo]()
    
    private var selectedSection:SelectedSection = .IDDetailsVC
    
    public var empImageString = ""
    public var empId = ""
    public static var editBody:EditBody = EditBody()
    public static var empImage: UIImage?
    
    private var pageController:EditEmployeePageViewController!
    
    private var selectedIndex = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        
    }
    
    
    private func initlization(){
        previousButton.isHidden = true
        setCollectionData()
        setUpCollectionView()
        getEmployeeData()
        addPageVCObserver()
        if L102Language.currentAppleLanguage() == "ar"{
            backButton.transform = .init(rotationAngle: .pi)
            data = data.reversed()
            collectionView.reloadData()
//            collectionView.scrollToItem(at: IndexPath.init(row: 5, section: 0), at: [.centeredHorizontally], animated: false)
        }
//        else{
//            collectionView.scrollToItem(at: IndexPath.init(row: 0, section: 0), at: [.centeredHorizontally], animated: false)
//        }
        
    }
    
    private func addPageVCObserver(){
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("ChangeSelectedSection"), object: nil, queue: .main) { notifi in
            guard let selectionSection = notifi.object as? (SelectedSection,IndexPath) else { return }
            self.selectedSection = selectionSection.0
            self.showSection()
            self.goToSelectedCell(indexPath: selectionSection.1)
        }
    }
    
    private func setUpPageViewController(){
        pageController = storyboard?.instantiateViewController(withIdentifier: "EditEmployeePageViewController") as? EditEmployeePageViewController
        
        pageController.empImageString = empImageString
        addChild(pageController)
        pageController.didMove(toParent: self)
        
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.addSubview(pageController.view)
        
        mainView.leadingAnchor.constraint(equalTo: pageController.view.leadingAnchor, constant: 0).isActive = true
        mainView.trailingAnchor.constraint(equalTo: pageController.view.trailingAnchor, constant: 0).isActive = true
        mainView.topAnchor.constraint(equalTo: pageController.view.topAnchor, constant: 0).isActive = true
        mainView.bottomAnchor.constraint(equalTo: pageController.view.bottomAnchor, constant: 0).isActive = true
    }
    
    
    private func setCollectionData(){
        data.append(.init(bgColor: UIColor(named: "AppColor")!, icon: UIImage(systemName: "person.fill")!, title: "ID Details".localized()))
        data.append(.init(bgColor: UIColor.black, icon: UIImage(systemName: "person.text.rectangle.fill")!, title: "Contact Details".localized()))
        data.append(.init(bgColor: UIColor.black, icon: UIImage(systemName: "building.columns.fill")!, title: "Bank Details".localized()))
        data.append(.init(bgColor: UIColor.black, icon: UIImage(systemName: "book.closed.fill")!, title: "Education Details".localized()))
        data.append(.init(bgColor: UIColor.black, icon: UIImage(systemName: "airplane")!, title: "Passport Details".localized()))
        data.append(.init(bgColor: UIColor.black, icon: UIImage(systemName: "building.2")!, title: "Insurance Details".localized()))
    
    }
    
    
    private func showSection(){
        switch selectedSection {
        case .IDDetailsVC:
            
            nextButotn.setTitle("Next".localized(), for: .normal)
            previousButton.isHidden = true
        case .ContactDetailsVC:
            
            nextButotn.setTitle("Next".localized(), for: .normal)
            previousButton.isHidden = false
        case .BankDetailsVC:
            
            nextButotn.setTitle("Next".localized(), for: .normal)
            previousButton.isHidden = false
            
            
        case .EducationDetailsVC:
            
            nextButotn.setTitle("Next".localized(), for: .normal)
            previousButton.isHidden = false
            
            
        case .PassportDetailsVC:
            
            nextButotn.setTitle("Next".localized(), for: .normal)
            previousButton.isHidden = false
            
            
        case .InsuranceDetailsVC:
            
            nextButotn.setTitle("Submit".localized(), for: .normal)
            previousButton.isHidden = false
        }
    }
    
    
    @IBAction func nextAction(_ sender: Any) {
        let lang = L102Language.currentAppleLanguage()
        if lang == "ar"{
            switch selectedSection {
            case .IDDetailsVC:
                selectedSection = .ContactDetailsVC
                goToSelectedCell(indexPath: IndexPath(item: 4, section: 0))
            case .ContactDetailsVC:
                selectedSection = .BankDetailsVC
                goToSelectedCell(indexPath: IndexPath(item: 3, section: 0))
            case .BankDetailsVC:
                selectedSection = .EducationDetailsVC
                goToSelectedCell(indexPath: IndexPath(item: 2, section: 0))
            case .EducationDetailsVC:
                selectedSection = .PassportDetailsVC
                goToSelectedCell(indexPath: IndexPath(item: 1, section: 0))
            case .PassportDetailsVC:
                selectedSection = .InsuranceDetailsVC
                goToSelectedCell(indexPath: IndexPath(item: 0, section: 0))
            case .InsuranceDetailsVC:
                submitAction()
                return
            }
        }else{
            switch selectedSection {
            case .IDDetailsVC:
                selectedSection = .ContactDetailsVC
                goToSelectedCell(indexPath: IndexPath(item: 1, section: 0))
            case .ContactDetailsVC:
                selectedSection = .BankDetailsVC
                goToSelectedCell(indexPath: IndexPath(item: 2, section: 0))
            case .BankDetailsVC:
                selectedSection = .EducationDetailsVC
                goToSelectedCell(indexPath: IndexPath(item: 3, section: 0))
            case .EducationDetailsVC:
                selectedSection = .PassportDetailsVC
                goToSelectedCell(indexPath: IndexPath(item: 4, section: 0))
            case .PassportDetailsVC:
                selectedSection = .InsuranceDetailsVC
                goToSelectedCell(indexPath: IndexPath(item: 5, section: 0))
            case .InsuranceDetailsVC:
                submitAction()
                return
            }
        }
        showSection()
        
        pageController.changeVC(selectedSection: selectedSection,direction: lang == "ar" ? .reverse : .forward)
    }
    
    
    @IBAction func previousAction(_ sender: Any) {
        let lang = L102Language.currentAppleLanguage()
        if lang == "ar"{
            switch selectedSection {
            case .IDDetailsVC:
                return
            case .ContactDetailsVC:
                selectedSection = .IDDetailsVC
                goToSelectedCell(indexPath: IndexPath(item: 5, section: 0))
            case .BankDetailsVC:
                selectedSection = .ContactDetailsVC
                goToSelectedCell(indexPath: IndexPath(item: 4, section: 0))
            case .EducationDetailsVC:
                selectedSection = .BankDetailsVC
                goToSelectedCell(indexPath: IndexPath(item: 3, section: 0))
            case .PassportDetailsVC:
                selectedSection = .EducationDetailsVC
                goToSelectedCell(indexPath: IndexPath(item: 2, section: 0))
            case .InsuranceDetailsVC:
                selectedSection = .PassportDetailsVC
                goToSelectedCell(indexPath: IndexPath(item: 1, section: 0))
            }
        }else{
            switch selectedSection {
            case .IDDetailsVC:
                return
            case .ContactDetailsVC:
                selectedSection = .IDDetailsVC
                goToSelectedCell(indexPath: IndexPath(item: 0, section: 0))
            case .BankDetailsVC:
                selectedSection = .ContactDetailsVC
                goToSelectedCell(indexPath: IndexPath(item: 1, section: 0))
            case .EducationDetailsVC:
                selectedSection = .BankDetailsVC
                goToSelectedCell(indexPath: IndexPath(item: 2, section: 0))
            case .PassportDetailsVC:
                selectedSection = .EducationDetailsVC
                goToSelectedCell(indexPath: IndexPath(item: 3, section: 0))
            case .InsuranceDetailsVC:
                selectedSection = .PassportDetailsVC
                goToSelectedCell(indexPath: IndexPath(item: 4, section: 0))
            }
        }
        showSection()
        
        pageController.changeVC(selectedSection: selectedSection,direction: lang == "ar" ? .forward : .reverse)
    }
    
    
    private func submitAction(){
        NotificationCenter.default.post(name: NSNotification.Name("Submit1"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("Submit2"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("Submit3"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("Submit4"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("Submit5"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("Submit6"), object: nil)
        showLoadingActivity()
        APIController.shard.updateEmployeeDetails(empImage: EditEmployeeDetailsVC.empImage,empID: empId, body: EditEmployeeDetailsVC.editBody) { data in
            self.hideLoadingActivity()
            DispatchQueue.main.async {
                if let status = data.status,status{
                    let alertVC = UIAlertController(title: "Success".localized(), message: data.msg ?? "", preferredStyle: .alert)
                    alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel,handler: { action in
                        EditEmployeeDetailsVC.empImage = nil
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alertVC, animated: true, completion: nil)
                }else{
                    let alertVC = UIAlertController(title: "error".localized(), message: data.error ?? "", preferredStyle: .alert)
                    alertVC.addAction(.init(title: "Cancel".localized(), style: .cancel))
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    
    @IBAction func backAction(_ sender: Any) {
        EditEmployeeDetailsVC.empImage = nil
        navigationController?.popViewController(animated: true)
    }
    
}


extension EditEmployeeDetailsVC:UICollectionViewDelegate,UICollectionViewDataSource{
    private func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(.init(nibName: "SectionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SectionCollectionViewCell")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionCollectionViewCell", for: indexPath ) as! SectionCollectionViewCell
        cell.setData(data: data[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goToSelectedCell(indexPath: indexPath)
        if L102Language.currentAppleLanguage() == "ar" {
            switch indexPath.row{
            case 0:
                selectedSection = .InsuranceDetailsVC
            case 1:
                selectedSection = .PassportDetailsVC
            case 2:
                selectedSection = .EducationDetailsVC
            case 3:
                selectedSection = .BankDetailsVC
            case 4:
                selectedSection = .ContactDetailsVC
            case 5:
                selectedSection = .IDDetailsVC
            default:
                break
            }
        }else{
            switch indexPath.row{
            case 0:
                selectedSection = .IDDetailsVC
            case 1:
                selectedSection = .ContactDetailsVC
            case 2:
                selectedSection = .BankDetailsVC
            case 3:
                selectedSection = .EducationDetailsVC
            case 4:
                selectedSection = .PassportDetailsVC
            case 5:
                selectedSection = .InsuranceDetailsVC
            default:
                break
            }
        }
        showSection()
        var direction:UIPageViewController.NavigationDirection!
        if L102Language.currentAppleLanguage() == "ar" {
            direction =  selectedIndex < indexPath.row ? .forward : .reverse
        }else{
            direction =  selectedIndex < indexPath.row ? .reverse : .forward
        }
        selectedIndex = indexPath.row
        pageController.changeVC(selectedSection: selectedSection,direction: direction)
    }
    
    
    private func goToSelectedCell(indexPath:IndexPath){
        for index in 0..<data.count{
            if index == indexPath.row{
                data[index].bgColor = UIColor(named: "AppColor")!
            }else{
                data[index].bgColor = UIColor.black
            }
        }
        
        collectionView.reloadData()
        collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally], animated: true)
    }
    
}

extension EditEmployeeDetailsVC{
    func getEmployeeData(){
        showLoadingActivity()
        APIController.shard.getEmployeeData(empID: empId) { data in
            self.hideLoadingActivity()
            if let status = data.status , status{
                if let data = data.data{
                    EditEmployeeDetailsVC.editBody = data
                    DispatchQueue.main.async {
                        self.setUpPageViewController()
                    }
                }
            }
        }
    }
}



enum SelectedSection{
    case IDDetailsVC,
         ContactDetailsVC,
         BankDetailsVC,
         EducationDetailsVC,
         PassportDetailsVC,
         InsuranceDetailsVC
}
