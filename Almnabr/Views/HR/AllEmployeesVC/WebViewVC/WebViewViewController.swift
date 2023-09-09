

import UIKit
import WebKit
class WebViewViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var webView: WKWebView!
    
    var data:GetImageResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if L102Language.currentAppleLanguage() == "ar"{
            backButton.transform = .init(rotationAngle: .pi)
        }
        if let data = data {
            if let fileData = Data(base64Encoded: data.base64 ?? ""){
                webView.load(fileData, mimeType: data.content_type ?? "", characterEncodingName: "", baseURL: URL(string: APIController.shard.serverURL)!)
            }
        }
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    

}
