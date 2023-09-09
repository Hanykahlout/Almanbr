//
//  ViewOutgoingViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 26/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class ViewOutgoingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var backButton: UIButton!
    private var pageController:ViewOutgoingPageVC!
    private var data = [SectionInfo]()
    private var selectedIndex = 0
    var id = ""
    public static var data:TransactionResponse?
    var isIncoming = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
    }
    
    private func initlization(){
        setCollectionViewData()
        addObservers()
        setUpPageViewController()
        setUpCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if L102Language.currentAppleLanguage() == "ar"{
            backButton.transform = .init(rotationAngle: .pi)
            data = data.reversed()
            goToSelectedCell(indexPath: IndexPath.init(row: data.count - 1, section: 0))
        }
    }
    
    
    private func addObservers(){
        NotificationCenter.default.addObserver(forName: .init("ChangeDescriptionTitle"), object: nil, queue: . main) { notify in
            guard let description = notify.object as? String else { return }
            self.data[L102Language.currentAppleLanguage() == "ar" ? self.data.count - 2 : 1].title = description
        }
        
        NotificationCenter.default.addObserver(forName: .init("ViewOutgoingPageControllerScrolled"), object: nil, queue: .main) { notify in
            guard let index = notify.object as? Int else { return }
            let lang = L102Language.currentAppleLanguage()
            self.goToSelectedCell(indexPath: IndexPath(row: lang == "en" ? index : (self.data.count - 1) - index, section: 0))
            
        }
    }
    
    private func setCollectionViewData(){
        data.append(.init(bgColor: UIColor(named: "AppColor")!, icon: UIImage(systemName: "doc.on.doc")!, title: "Request Details".localized()))
        data.append(.init(bgColor: .black, icon: UIImage(systemName: "doc.on.doc")!, title: "Description".localized()))
        data.append(.init(bgColor: .black, icon: UIImage(systemName: "doc.on.doc")!, title: "Person Details".localized()))
        data.append(.init(bgColor: .black, icon: UIImage(systemName: "doc.on.doc")!, title: "Attachments".localized()))
        data.append(.init(bgColor: .black, icon: UIImage(systemName: "doc.on.doc")!, title: "History".localized()))
        
    }

    
    
    private func setUpPageViewController(){
        pageController = storyboard?.instantiateViewController(withIdentifier: "ViewOutgoingPageVC") as? ViewOutgoingPageVC
        pageController.isIncoming = isIncoming
        pageController.id = id
        addChild(pageController)
        pageController.didMove(toParent: self)
        
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.addSubview(pageController.view)

        mainView.leadingAnchor.constraint(equalTo: pageController.view.leadingAnchor, constant: 0).isActive = true
        mainView.trailingAnchor.constraint(equalTo: pageController.view.trailingAnchor, constant: 0).isActive = true
        mainView.topAnchor.constraint(equalTo: pageController.view.topAnchor, constant: 0).isActive = true
        mainView.bottomAnchor.constraint(equalTo: pageController.view.bottomAnchor, constant: 0).isActive = true
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }

}
extension ViewOutgoingViewController:UICollectionViewDelegate,UICollectionViewDataSource{
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
        collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally], animated: true)
    }

}
