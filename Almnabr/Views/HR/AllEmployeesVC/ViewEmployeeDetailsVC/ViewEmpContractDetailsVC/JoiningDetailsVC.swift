//
//  JoiningDetailsVC.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 17/11/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
class JoiningDetailsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var empNum = ""
    private var pageNumber = 1
    private var totlaPages = 1
    private var data = [JoiningDetailsRecord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getJoiningDetailsData(isFromBottom: true)
        addNavigationBarTitle(navigationTitle: "Joining Details")
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func initialization(){
        setUpTableView()
    }
    
    
}


extension JoiningDetailsVC:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "JoiningDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "JoiningDetailsTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JoiningDetailsTableViewCell", for: indexPath) as! JoiningDetailsTableViewCell
        let objc = data[indexPath.row]
        cell.setData(data: objc)
        cell.docAction = {
            self.viewPDFFile(urlPath: objc.link ?? "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1{
            if pageNumber < totlaPages{
                pageNumber += 1
                getJoiningDetailsData(isFromBottom: true)
            }
        }
    }
}

// MARK: - API Handling
extension JoiningDetailsVC{
    private func getJoiningDetailsData(isFromBottom:Bool){
        if !isFromBottom{
            pageNumber = 1
        }
        showLoadingActivity()
        APIController.shard.getJoiningDetails(pageNumber: String(pageNumber), empNum: empNum) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    if isFromBottom{
                        self.data.append(contentsOf: data.records ?? [])
                    }else{
                        self.data = data.records ?? []
                    }
                    self.totlaPages = data.page?.total_pages ?? 1
                }else{
                    self.data.removeAll()
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
                }
                self.tableView.reloadData()
            }
        }
    }
    
    
    private func viewPDFFile(urlPath:String){
        APIController.shard.getImage(url: urlPath) { data in
            if let status = data.status , status{
                let vc = WebViewViewController()
                vc.data = data
                let nav = UINavigationController(rootViewController: vc)
                self.navigationController?.present(nav, animated: true)
            }else{
                SCLAlertView().showError("error".localized(), subTitle: data.error ?? "")
            }
        }
    }
    
    
    
}

