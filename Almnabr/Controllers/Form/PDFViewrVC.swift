//
//  PDFViewrVC.swift
//  Almnabr
//
//  Created by MacBook on 16/11/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import PDFKit
import WebKit

class PDFViewrVC: UIViewController, CAAnimationDelegate {

    @IBOutlet var pdfView: PDFView!
    @IBOutlet var WebView: WKWebView!
    
    var Strurl :String = ""
    var subject :String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.get_PDF(url:  Strurl)
       
    }
    
    
    
    func get_PDF(url:String){
        
        self.showLoadingActivity()
        APIController.shard.sendRequestGetAuth(urlString: url ) { (response) in
            
            
            let status = response["status"] as? Bool
            if status == true{
                if  let base64 = response["base64"] as? String{
                    do { 
                        try self.savePdf(StrBase64: base64)
                        self.loadPDFAndShare()
                    } catch  {
                        self.hideLoadingActivity()
                        print("FALLO EL GUARDAR EL PDF")
                    }
                    // self.saveBase64StringToPDF(base64)
                    
                }
            }else{
                self.hideLoadingActivity()
            }
          
            
        }
    }
    
    
    func saveBase64StringToPDF(_ base64String: String) {

        guard
            var documentsURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last,
            let convertedData = Data(base64Encoded: base64String)
            else {
            //handle error when getting documents URL
            return
        }

        //name your file however you prefer
        let id =  UUID().uuidString
        documentsURL.appendPathComponent(id)
        //openPdfFile(StrUrl :documentsURL)
        
        do {
                   let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                   let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
                   for url in contents {
                       
                       if url.description.contains("\(documentsURL)") {
                           if let url = URL(string:  "\(documentsURL)" ), let document = PDFDocument(url: url) {
                                  pdfView.autoresizesSubviews = true
                                             pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin]
                                             pdfView.displayDirection = .vertical
                      
                                             pdfView.autoScales = true
                                             pdfView.displayMode = .singlePageContinuous
                                             pdfView.displaysPageBreaks = true
                                             pdfView.document = document
                                             pdfView.maxScaleFactor = 4.0
                                             pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
                      
                                }

                           
                   }
               }
           } catch {
               print("could not locate pdf file !!!!!!!")
           }
       

        do {
            try convertedData.write(to: documentsURL)
        } catch {
            //handle write error here
        }

        print(documentsURL)
    }
    
    
    
    func openPdfFile(StrUrl :Any){
        //let pdfView = PDFView()
        let webView = WKWebView()
        let documentDir = FileManager.SearchPathDirectory.documentDirectory
        let userDir    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(documentDir, userDir, true)
        if let dirPath          = paths.first
        {

            let pdfURL = URL(fileURLWithPath: StrUrl as! String).appendingPathComponent(".pdf")
            //let image    = UIImage(contentsOfFile: imageURL.path)
            do {
                let data = try Data(contentsOf: pdfURL)
                webView.load(data, mimeType: "application/pdf", characterEncodingName:"", baseURL: pdfURL.deletingPathExtension())
                print("pdf file loading...")
                 self.hideLoadingActivity()

            }
            catch {
                print("failed to open pdf")
            }
            return
        }
    }

    
    func savePdf(StrBase64:String) throws {
        let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let pdfDocURL = documentsURL.appendingPathComponent("document.pdf")
        let pdfData = Data(base64Encoded: StrBase64)
        try pdfData!.write(to: pdfDocURL)
        
       
        if let decodeData = NSData(base64Encoded: StrBase64, options: .ignoreUnknownCharacters) {
            WebView.load(decodeData as Data as Data, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: NSURL(fileURLWithPath: "") as URL)
             self.hideLoadingActivity()
        }
        
    }

    func loadPDFAndShare(){
        do {
            let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let pdfDocURL = documentsURL.appendingPathComponent("document.pdf")
            let document = NSData(contentsOf: pdfDocURL)
           
            self.hideLoadingActivity()
//            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [document!], applicationActivities: nil)
//            activityViewController.popoverPresentationController?.sourceView=self.view
//            present(activityViewController, animated: true, completion: nil)
            print("document was not found")
        } catch  {
            print("document was not found")
        }
      }
    
    
    @IBAction func btnCancel_Click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.hideLoadingActivity()
    }

    @objc func back(sender: UIBarButtonItem) {
        print("nav")
        _ =  dismiss(animated: true, completion: nil)
    }
    
    @IBAction func  backAction(_ sender: Any) {

        self.dismiss(animated: true, completion: nil)
        //only testing

    }
}
