

import AVFoundation
import UIKit
import FAPanels
import SCLAlertView

class QRScannerViewController:  UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var mainView: UIView!
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var isFromWidget = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = self.navigationController?.preferredStatusBarStyle
        view.backgroundColor = UIColor(hexString: "1A3665")
        navigationController?.navigationBar.tintColor = .white
        
        let button = UIButton(type: .system)
        button.setTitle("Cancel".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        navigationItem.leftBarButtonItem = .init(customView: button)
        
        addNavigationBarTitle(navigationTitle: "Scan QR Code")
        
        
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = mainView.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        mainView.layer.addSublayer(previewLayer)
        DispatchQueue.global(qos:.background).async {
            self.captureSession.startRunning()
        }
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        DispatchQueue.global(qos:.background).async {
            if (self.captureSession?.isRunning == false) {
                self.captureSession.startRunning()
            }
        }
    }
    
    @objc private func cancelAction(){
        if !isFromWidget{
            navigationController?.dismiss(animated: true)
        }else{
            let vc = AppDelegate.mainSB.instantiateViewController(withIdentifier: "HomeVC")
            
            let nav = UINavigationController.init(rootViewController: vc)
            let sideMenu: MenuVC = AppDelegate.mainSB.instanceVC()
            let rootController : FAPanelController = AppDelegate.mainSB.instanceVC()
            let center : MenuVC = AppDelegate.mainSB.instanceVC()
            
            _ = rootController.center(nav).right(center).left(sideMenu)
            rootController.rightPanelPosition = .front
            rootController.leftPanelPosition = .front
            
            // rootController.configs.rightPanelWidth = (window?.frame.size.width)!
            let width = UIScreen.main.bounds.width - 150
            
            rootController.configs.leftPanelWidth = width
            rootController.configs.rightPanelWidth = width
            
            rootController.configs.maxAnimDuration = 0.3
            rootController.configs.canRightSwipe = true
            rootController.configs.canLeftSwipe = true
            rootController.configs.changeCenterPanelAnimated = false
            if let window = self.view.window{
                window.rootViewController = rootController
                UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
            }
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
        dismiss(animated: true)
    }
    
    
    func found(code: String) {
        
        APIController.shard.sendQRCode(code: code) { data in
            DispatchQueue.main.async {
                let alert = SCLAlertView()
                if let status = data.status,status{
                    let appearance = SCLAlertView.SCLAppearance(
                        showCloseButton: false
                    )
                    
                    let alert = SCLAlertView(appearance: appearance)
                    
                    alert.addButton("Ok".localized()) {
                        self.goToDashboard()
                    }
                    
                    alert.showSuccess("Successfully Scanned".localized(), subTitle: "You can see your account logged in from the website.".localized())
                    
                }else{
                    alert.showError("Failed Scanned".localized(), subTitle: "")
                }
            }
        }
    }
    
    
    private func goToDashboard(){
        let vc = AppDelegate.mainSB.instantiateViewController(withIdentifier: "HomeVC")
        
        let nav = UINavigationController.init(rootViewController: vc)
        let sideMenu: MenuVC = AppDelegate.mainSB.instanceVC()
        let rootController : FAPanelController = AppDelegate.mainSB.instanceVC()
        let center : MenuVC = AppDelegate.mainSB.instanceVC()
        
        _ = rootController.center(nav).right(center).left(sideMenu)
        rootController.rightPanelPosition = .front
        rootController.leftPanelPosition = .front
        
        // rootController.configs.rightPanelWidth = (window?.frame.size.width)!
        let width = UIScreen.main.bounds.width - 150
        
        
        rootController.configs.leftPanelWidth = width
        rootController.configs.rightPanelWidth = width
        
        rootController.configs.maxAnimDuration = 0.3
        rootController.configs.canRightSwipe = true
        rootController.configs.canLeftSwipe = true
        rootController.configs.changeCenterPanelAnimated = false
        
        guard let window = UIApplication.shared.windows.last else {return}
        
        window.rootViewController = rootController
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
}

