//
//  ViewEmployeeDetailsVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 12/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
class ViewEmployeeDetailsVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mainView: UIView!

    public var empImageString = ""
    private var pageController:ViewEmployeePageVC!
    private var data = [SectionInfo]()
    
    @IBOutlet weak var forwordImageView: UIImageView!
    @IBOutlet weak var reverseImageView: UIImageView!
    var empId = ""
    var branchId = ""
    private var selectedIndex = 0
    public static var empData = EmpViewResponse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intilization()
    }

    
    private func intilization(){
        setUpCollectionView()
        setCollectionData()
        addObserver()
        if L102Language.currentAppleLanguage() == "ar"{
            backButton.transform = .init(rotationAngle: .pi)
            forwordImageView.transform = .init(rotationAngle: .pi)
            reverseImageView.transform = .init(rotationAngle: .pi)
            data = data.reversed()
            collectionView.reloadData()
        }
        getEmployeeViewData()
    }
    
    
    private func addObserver(){
        NotificationCenter.default.addObserver(forName: .init("ViewEmpPageControllerScrolled"), object: nil, queue: .main) { notify in
            guard let index = notify.object as? Int else { return }
            let lang = L102Language.currentAppleLanguage()
            self.goToSelectedCell(indexPath:  IndexPath(row: lang == "en" ? index : (self.data.count - 1) - index, section: 0))
        }
    }
    
    
    private func setUpPageViewController(){
        pageController = storyboard?.instantiateViewController(withIdentifier: "ViewEmployeePageVC") as? ViewEmployeePageVC
        pageController.empID = empId
        addChild(pageController)
        pageController.didMove(toParent: self)
        
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.addSubview(pageController.view)

        mainView.leadingAnchor.constraint(equalTo: pageController.view.leadingAnchor, constant: 0).isActive = true
        mainView.trailingAnchor.constraint(equalTo: pageController.view.trailingAnchor, constant: 0).isActive = true
        mainView.topAnchor.constraint(equalTo: pageController.view.topAnchor, constant: 0).isActive = true
        mainView.bottomAnchor.constraint(equalTo: pageController.view.bottomAnchor, constant: 0).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setCollectionData(){
        
        data.append(.init(bgColor: UIColor(named: "AppColor")!, icon: UIImage(systemName: "person.fill")!, title: "ID Details".localized()))
        data.append(.init(bgColor: UIColor.black, icon: UIImage(systemName: "doc.on.doc")!, title: "Other Details".localized()))
        
        data.append(.init(bgColor: UIColor.black, icon: UIImage(systemName: "doc.on.doc")!, title: "Contract Details".localized()))
        
        data.append(.init(bgColor: UIColor.black, icon: UIImage(systemName: "bag.fill")!, title: "Documents".localized()))
        
        data.append(.init(bgColor: UIColor.black, icon: UIImage(systemName: "person.text.rectangle.fill")!, title: "Vacations".localized()))
        
        data.append(.init(bgColor: UIColor.black, icon: UIImage(systemName: "person.text.rectangle.fill")!, title: "Modules".localized()))
        
        data.append(.init(bgColor: UIColor.black, icon: UIImage(systemName: "dollarsign.circle.fill")!, title: "Financial Details".localized()))
        
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func forwordAction(_ sender: Any) {
        if selectedIndex < data.count - 1{
            selectedIndex += 1
        }
        
        let lang = L102Language.currentAppleLanguage()
        pageController.changeVC(index: selectedIndex, direction: lang == "en" ? .forward : .reverse)
        print("ASSSA--> ",lang)
        let index = lang == "en" ? selectedIndex : (data.count - 1) - selectedIndex
        goToSelectedCell(indexPath: IndexPath(row: index, section: 0))
        
    }
    
    
    @IBAction func reverseAction(_ sender: Any) {
        if selectedIndex > 0{
            selectedIndex -= 1
        }
        let lang = L102Language.currentAppleLanguage()
        pageController.changeVC(index: selectedIndex, direction: lang == "en" ? .reverse : .forward)
        let index = lang == "en" ? selectedIndex : (data.count - 1) - selectedIndex
        goToSelectedCell(indexPath: IndexPath(row: index , section: 0))
    }
    
}


extension ViewEmployeeDetailsVC: UICollectionViewDelegate , UICollectionViewDataSource {
    private func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(.init(nibName: "SectionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SectionCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionCollectionViewCell", for: indexPath) as! SectionCollectionViewCell
        cell.setData(data: data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goToSelectedCell(indexPath: indexPath)
        let oldIndex = selectedIndex
        selectedIndex = indexPath.row
        pageController.changeVC(index: L102Language.currentAppleLanguage() == "en" ? selectedIndex : (data.count - 1) - selectedIndex , direction: oldIndex < selectedIndex ? .forward : .reverse)
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
        collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally], animated: false)
        
    }
    

}

// MARK: - API Handling

extension ViewEmployeeDetailsVC{
    
    private func getEmployeeViewData(){
        showLoadingActivity()
        APIController.shard.getEmployeeViewData(empId: empId,branchId: branchId) { data in
            self.hideLoadingActivity()
            if let status = data.status,status{
                ViewEmployeeDetailsVC.empData = data
                DispatchQueue.main.async {
                    self.setUpPageViewController()
                    self.collectionView.scrollToItem(at: .init(row: 0, section: 0), at: [.centeredHorizontally], animated: false)
                }
            }
        }
    }
    
    
}
