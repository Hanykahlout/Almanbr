//
//  CFormAttachViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 23/12/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import SCLAlertView
class CFormAttachViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var c1Attachments = [FormC1File]()
    var c2Attachments = [form_c2_filesRecords]()
    
    var isOutgoing = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBarTitle(navigationTitle: "Attachments")
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func initialization(){
        setUpTableView()
    }
    
}

extension CFormAttachViewController: UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "C1FormAttachTableViewCell", bundle: nil), forCellReuseIdentifier: "C1FormAttachTableViewCell")
        tableView.register(.init(nibName: "C2FormAttachTableViewCell", bundle: nil), forCellReuseIdentifier: "C2FormAttachTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isOutgoing ? c1Attachments.count : c2Attachments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isOutgoing{
            let cell = tableView.dequeueReusableCell(withIdentifier: "C1FormAttachTableViewCell", for: indexPath) as! C1FormAttachTableViewCell
            cell.setData(index: indexPath.row + 1, data: c1Attachments[indexPath.row])
            cell.previewAction = {
                self.previewPDF(url: self.c1Attachments[indexPath.row].link ?? "")
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "C2FormAttachTableViewCell", for: indexPath) as! C2FormAttachTableViewCell
        cell.titleLabel.text = c2Attachments[indexPath.row].form_c2_file_attach_title ?? "- - - -"
        cell.previewPDF = {
            self.previewPDF(url: self.c2Attachments[indexPath.row].link ?? "")
        }
        return cell
        
    }
    
    
}

extension CFormAttachViewController {
    private func previewPDF(url:String){
        showLoadingActivity()
        APIController.shard.getImage(url: url) { data in
            DispatchQueue.main.async {
                self.hideLoadingActivity()
                if let status = data.status,status{
                    let vc = WebViewViewController()
                    vc.data = data
                    self.navigationController?.present(UINavigationController(rootViewController: vc), animated: true)
                }else{
                    SCLAlertView().showError("error".localized(), subTitle: data.error ?? "There is an unknow error!!")
                }
            }
        }
    }
}
