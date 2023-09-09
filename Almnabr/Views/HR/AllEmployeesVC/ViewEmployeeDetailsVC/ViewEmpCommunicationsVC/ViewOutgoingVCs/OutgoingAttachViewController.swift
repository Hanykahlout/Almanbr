//
//  OutgoingAttachViewController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 27/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class OutgoingAttachViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!
    private var data = [form_c2_filesRecords]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        
        // Do any additional setup after loading the view.
    }
    
    private func initlization(){
        addObserver()
        setUpTableView()
        self.data = ViewOutgoingViewController.data?.isIncoming ?? true ? ViewOutgoingViewController.data?.form_c2_files?.records ?? [] : ViewOutgoingViewController.data?.form_c1_files?.records ?? []
        messageLabel.text = "There Are No Data !!!".localized()
        messageLabel.isHidden = !data.isEmpty
    }

    
    private func addObserver(){
        NotificationCenter.default.addObserver(forName: .init(rawValue: "ViewAttachmentUrl"), object: nil, queue: .main) { notify in
            guard let link = notify.object as? String else { return }
            APIController.shard.getImage(url: link) { data in
                if let status = data.status ,status{
                    DispatchQueue.main.async {
                        let vc = WebViewViewController()
                        vc.data = data
                        self.navigationController?.present(UINavigationController(rootViewController: vc), animated: true)
                    }
                }
            }
        }
    }
    
    
}

extension OutgoingAttachViewController:UITableViewDelegate,UITableViewDataSource{
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "ViewAttachTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewAttachTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewAttachTableViewCell", for: indexPath) as! ViewAttachTableViewCell
        cell.setData(isIncoming: ViewOutgoingViewController.data?.isIncoming ?? true,data: data[indexPath.row])
        return cell
    }
}
