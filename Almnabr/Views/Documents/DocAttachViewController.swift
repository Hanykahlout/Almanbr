//
//  DocAttachViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 18/08/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView

class DocAttachViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var counter = 1
    private var pageNumber = 1
    var document_id = ""
    private var data = [DocAttachsData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }

    private func initlization(){
        addNavigationBarTitle(navigationTitle: "Attachments")
        setUpTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAttachs()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
}

extension DocAttachViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "DocAttachTableViewCell", bundle: nil), forCellReuseIdentifier: "DocAttachTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocAttachTableViewCell", for: indexPath) as! DocAttachTableViewCell
        cell.setData(data: data[indexPath.row])
        cell.downloadAction = { [unowned self] filePath in
            self.getDoc(filePath: filePath)
        }
        return cell
    }
    
}
// MARK: - API Handling
extension DocAttachViewController{
    private func getAttachs(){
        showLoadingActivity()
        APIController.shard.getDocAttchs(pageNumber: pageNumber,document_id: document_id) { data in
            self.hideLoadingActivity()
            if let status = data.status ,status{
                self.data = data.data ?? []
                self.tableView.reloadData()
            }else{
                SCLAlertView().showEdit("error".localized(), subTitle: data.error ?? "")
            }
        }
    }
    
    private func getDoc(filePath:String){
        showLoadingActivity()
        APIController.shard.getImage(url: filePath) { [unowned self] data in
            self.hideLoadingActivity()
            if let status = data.status,status{
                let vc = WebViewViewController()
                vc.data = data
                let nav = UINavigationController(rootViewController: vc)
                self.navigationController?.present(nav, animated: true)
            }
        }
    }
    
    
}
