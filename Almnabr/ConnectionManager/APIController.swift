//
//  APIController.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 01/06/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import AlamofireObjectMapper


class APIController{
    
    //Nahid
    //Almnabr.NAHIDH 1.1   16
    //socket --- https://node.nahidh.sa/
    //server url ---- https://dev.nahidh.sa/backend
    //Api key "12345"
    
    //Almnabr
    //com.ERP.ALMNABR 1.0  3
    //socket --- https://node.almnabr.com/
    //server url ---- https://erp.almnabr.com/backend
    //Api key "PCGYdyKBJFya8LMaFP6baRrraRpSFc"
    
    let serverURL = "https://erp.almnabr.com/backend"
    private let api_key = "PCGYdyKBJFya8LMaFP6baRrraRpSFc"
    
    
    public static var shard:APIController = {
        let apiController = APIController()
        return apiController
    }()
    
    private init(){}
    
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
    func convertToArrayDictionary(text: String) -> [[String: Any]]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func getDateString(with string:String)-> String?{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "en")
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ssaa"
        let date = dateFormatter.date(from: string)
        dateFormatter.dateFormat = "h:mm aa"
        if let date = date{
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    //MARK: - get data with param
    //-----------------------------------------------------
    
    func getDataParamAPI(queryString: String, isArrayReturn: Bool, param: Parameters, keyValue: String, completionHandler: @escaping (_ responseString: Dictionary<String, Any>,_ error: Error?) -> Void) {
        let strURL = "\(serverURL )/\(queryString)"
        let urlStr : String = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let getApi = URL(string: urlStr)!
        print(getApi)
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        manager.request(getApi, method: .get, parameters: param, encoding: URLEncoding.default, headers: setHeaderInformation()).responseString{ [self] (response) in
            switch response.result{
            case .failure(let error):
                print("Error : \(error.localizedDescription)" )
                print("\(getApi) API fail issue")
                let answer = "static_error_api_wrong_json".localized()
                let errorString = #"{"message":"The given data was invalid.","errors":{"unknown":["\#(answer)"]}}"#
                let dict = convertToDictionary(text: errorString)
                completionHandler(dict!, nil)
                break
            case .success(_):
                if let responseModelObject = response.result.value {
                    if let responseStatus = response.response?.statusCode {
                        if responseStatus == 403 {
                            let dict = convertToDictionary(text: "\(responseModelObject)")
                            if dict != nil {
                                let answer = dict!["message"]!
                                let errorString = #"{"message":"The given data was invalid.","errors":{"unknown":["\#(answer)"]}}"#
                                let dict = convertToDictionary(text: errorString)
                                completionHandler(dict!, nil)
                            } else {
                                let answer = "static_error_404".localized()
                                let errorString = #"{"message":"The given data was invalid.","errors":{"unknown":["\#(answer)"]}}"#
                                let dict = convertToDictionary(text: errorString)
                                completionHandler(dict!, nil)
                            }
                            
                        } else if responseStatus == 404 {
                            let answer = "static_error_404".localized()
                            let errorString = #"{"message":"The given data was invalid.","errors":{"unknown":["\#(answer)"]}}"#
                            let dict = convertToDictionary(text: errorString)
                            completionHandler(dict!, nil)
                        } else if responseStatus > 400 && responseStatus < 500 && responseStatus != 422 {
                            let answer = "static_error_unautorized".localized()
                            let errorString = #"{"message":"Unauthenticated.","unautorized":{"unautorized":["\#(answer)"]}}"#
                            let dict = convertToDictionary(text: errorString)
                            completionHandler(dict!, nil)
                            
                        } else {
                            //print("\(responseModelObject)login  available")
                            if isArrayReturn {
                                if let arrayDict = convertToArrayDictionary(text: "\(responseModelObject)") {
                                    let dict = [keyValue : arrayDict]
                                    completionHandler(dict as Dictionary<String, Any>, nil)
                                } else {
                                    completionHandler(["" : ""], nil)
                                }
                            } else {
                                print(getApi)
                                if let dict = convertToDictionary(text: "\(responseModelObject)") {
                                    completionHandler(dict, nil)
                                } else {
                                    completionHandler(["" : ""], nil)
                                }
                            }
                        }
                    }
                } else {
                    print("\(queryString) API has issue with response")
                    let answer = "static_error_unknown".localized()
                    let errorString = #"{"message":"The given data was invalid.","errors":{"unknown":["\#(answer)"]}}"#
                    let dict = convertToDictionary(text: errorString)
                    completionHandler(dict!, nil)
                }
                
                break
            }
        }
    }
    
    
    func getDataAPI(queryString: String, isArrayReturn: Bool, keyValue: String, completionHandler: @escaping (_ responseString: Dictionary<String, Any>,_ error: Error?) -> Void) {
        let strURL = "\(serverURL )/\(queryString)"
        let urlStr : String = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let getApi = URL(string: urlStr)!
        print(getApi)
        let params = ["":""]
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        manager.request(getApi, method: .get, parameters: params, encoding: URLEncoding.default, headers: setHeaderInformation()).responseString{ [self] (response) in
            switch response.result{
            case .failure(let error):
                print("Error : \(error.localizedDescription)" )
                print("\(getApi) API fail issue")
                let answer = "static_error_api_wrong_json".localized()
                let errorString = #"{"message":"The given data was invalid.","errors":{"unknown":["\#(answer)"]}}"#
                let dict = convertToDictionary(text: errorString)
                completionHandler(dict!, nil)
                break
            case .success(_):
                if let responseModelObject = response.result.value {
                    if let responseStatus = response.response?.statusCode {
                        if responseStatus == 403 {
                            let dict = convertToDictionary(text: "\(responseModelObject)")
                            if dict != nil {
                                let answer = dict!["message"]!
                                let errorString = #"{"message":"The given data was invalid.","errors":{"unknown":["\#(answer)"]}}"#
                                let dict = convertToDictionary(text: errorString)
                                completionHandler(dict!, nil)
                            } else {
                                let answer = "static_error_404".localized()
                                let errorString = #"{"message":"The given data was invalid.","errors":{"unknown":["\#(answer)"]}}"#
                                let dict = convertToDictionary(text: errorString)
                                completionHandler(dict!, nil)
                            }
                            
                        } else if responseStatus == 404 {
                            let answer = "static_error_404".localized()
                            let errorString = #"{"message":"The given data was invalid.","errors":{"unknown":["\#(answer)"]}}"#
                            let dict = convertToDictionary(text: errorString)
                            completionHandler(dict!, nil)
                        } else if responseStatus > 400 && responseStatus < 500 && responseStatus != 422 {
                            let answer = "static_error_unautorized".localized()
                            let errorString = #"{"message":"Unauthenticated.","unautorized":{"unautorized":["\#(answer)"]}}"#
                            let dict = convertToDictionary(text: errorString)
                            completionHandler(dict!, nil)
                            
                        } else {
                            //print("\(responseModelObject)login  available")
                            if isArrayReturn {
                                if let arrayDict = convertToArrayDictionary(text: "\(responseModelObject)") {
                                    let dict = [keyValue : arrayDict]
                                    completionHandler(dict as Dictionary<String, Any>, nil)
                                } else {
                                    completionHandler(["" : ""], nil)
                                }
                            } else {
                                print(getApi)
                                if let dict = convertToDictionary(text: "\(responseModelObject)") {
                                    completionHandler(dict, nil)
                                } else {
                                    completionHandler(["" : ""], nil)
                                }
                            }
                        }
                    }
                } else {
                    print("\(queryString) API has issue with response")
                    let answer = "static_error_unknown".localized()
                    let errorString = #"{"message":"The given data was invalid.","errors":{"unknown":["\#(answer)"]}}"#
                    let dict = convertToDictionary(text: errorString)
                    completionHandler(dict!, nil)
                }
                
                break
            }
        }
        
        
    }
    
    
    func setHeaderInformation() -> HTTPHeaders {
        var headers: HTTPHeaders?
        var language = L102Language.currentAppleLanguage()
        if language.count == 0 {
            language = "en"
        }
        headers = [
            //"Content-Type" : "multipart/form-data",
            "Accept": "application/json",
            "Authorization": "Bearer \(Constants.token_api)",
            "lang": language
        ]
        return headers!
    }
    
    func setMultipartHeaderInformation() -> HTTPHeaders {
        var headers: HTTPHeaders?
        var language = L102Language.currentAppleLanguage()
        if language.count == 0 {
            language = "en"
        }
        
        headers = [
            "Content-Type" : "multipart/form-data",
            "Authorization": "Bearer \(Constants.token_api)",
            "Accept": "application/json",
            "lang": language
        ]
        
        return headers!
    }
    
    func postAnyDataJawab(queryString: String, parameters: Parameters, completionHandler: @escaping (_ responseObject: ResponseModel,_ error: Error?) -> Void) {
        
        let urlStr : String = queryString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let getApi = URL(string: urlStr)!
        
        Alamofire.request(getApi, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<ResponseModel>) in
            if(response.result.isSuccess){
                print(response.result.value as Any)
                let someString = String(data: response.data!, encoding: .utf8)
                print(someString!)
                
                if let sString = someString {
                    if sString == "Successfully added" {
                        let responseErrorData = ResponseModel(JSON: ["status":true, "message":"\(sString)"])
                        completionHandler(responseErrorData!, nil)
                    } else if let responseModelObject = response.result.value{
                        responseModelObject.status = true
                        completionHandler(responseModelObject, nil)
                    } else {
                        let responseErrorData = ResponseModel(JSON: ["status":false, "message":"\(sString)"])
                        completionHandler(responseErrorData!, nil)
                    }
                } else if let responseModelObject = response.result.value{
                    responseModelObject.status = true
                    completionHandler(responseModelObject, nil)
                } else {
                    let responseErrorData = ResponseModel(JSON: ["status":false, "message":"Json object error from server"])
                    completionHandler(responseErrorData!, nil)
                }
            }else {
                let someString = String(data: response.data!, encoding: .utf8)
                print(someString!)
                if let sString = someString {
                    if sString == "Successfully added" || sString == "\"Successfully added\""{
                        let responseErrorData = ResponseModel(JSON: ["status":true, "message":"\(sString)"])
                        completionHandler(responseErrorData!, nil)
                    } else {
                        let responseErrorData = ResponseModel(JSON: ["status":false, "message":"Error from Server"])
                        completionHandler(responseErrorData!, nil)
                        
                    }
                } else {
                    let responseErrorData = ResponseModel(JSON: ["status":false, "message":"Error from Server"])
                    completionHandler(responseErrorData!, nil)
                    
                }
            }
        }
    }
    
    
    
    func postAnyData(queryString: String, parameters: Parameters, completionHandler: @escaping (_ responseObject: ResponseModel,_ error: Error?) -> Void) {
        
        let strURL = "\(serverURL )/\(queryString)"
        let urlStr : String = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let getApi = URL(string: urlStr)!
        
        let auth = [ "X-API-KEY": api_key,
                     "Content-Type":"application/x-www-form-urlencoded"]
        
        
        //        let auth = [ "X-API-KEY":"12345",
        //                     "Content-Type":"application/x-www-form-urlencoded"]
        Alamofire.request(getApi, method: .post, parameters: parameters, encoding:  URLEncoding.default, headers: auth).responseObject { (response: DataResponse<ResponseModel>) in
            if(response.result.isSuccess){
                print(response.result.value as Any)
                let someString = String(data: response.data!, encoding: .utf8)
                print(someString!)
                
                if let sString = someString {
                    if sString == "Successfully added" {
                        let responseErrorData = ResponseModel(JSON: ["status":true, "message":"\(sString)"])
                        completionHandler(responseErrorData!, nil)
                    } else if let responseModelObject = response.result.value{
                        responseModelObject.status = true
                        completionHandler(responseModelObject, nil)
                    } else {
                        let responseErrorData = ResponseModel(JSON: ["status":false, "message":"\(sString)"])
                        completionHandler(responseErrorData!, nil)
                    }
                } else if let responseModelObject = response.result.value{
                    responseModelObject.status = true
                    completionHandler(responseModelObject, nil)
                } else {
                    let responseErrorData = ResponseModel(JSON: ["status":false, "message":"Json object error from server"])
                    completionHandler(responseErrorData!, nil)
                }
            }else {
                let someString = String(data: response.data!, encoding: .utf8)
                print(someString!)
                if let sString = someString {
                    if sString == "Successfully added" || sString == "\"Successfully added\""{
                        let responseErrorData = ResponseModel(JSON: ["status":true, "message":"\(sString)"])
                        completionHandler(responseErrorData!, nil)
                    } else {
                        let responseErrorData = ResponseModel(JSON: ["status":false, "message":"Error from Server"])
                        completionHandler(responseErrorData!, nil)
                        
                    }
                } else {
                    let responseErrorData = ResponseModel(JSON: ["status":false, "message":"Error from Server"])
                    completionHandler(responseErrorData!, nil)
                    
                }
            }
        }
    }
    
    
    func postAnyDataHeader(queryString: String, parameters: Parameters, completionHandler: @escaping (_ responseObject: ResponseModel,_ error: Error?) -> Void) {
        
        let strURL = "\(serverURL )/\(queryString)"
        let urlStr : String = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let getApi = URL(string: urlStr)!
        
        
        let auth = [ "X-API-KEY":api_key,
                     "Content-Type":"application/x-www-form-urlencoded",
                     "authorization":
                        "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"]
        Alamofire.request(getApi, method: .post, parameters: parameters, encoding:  URLEncoding.default, headers: auth).responseObject { (response: DataResponse<ResponseModel>) in
            if(response.result.isSuccess){
                print(response.result.value as Any)
                let someString = String(data: response.data!, encoding: .utf8)
                print(someString!)
                
                if let sString = someString {
                    if sString == "Successfully added" {
                        let responseErrorData = ResponseModel(JSON: ["status":true, "message":"\(sString)"])
                        completionHandler(responseErrorData!, nil)
                    } else if let responseModelObject = response.result.value{
                        responseModelObject.status = true
                        completionHandler(responseModelObject, nil)
                    } else {
                        let responseErrorData = ResponseModel(JSON: ["status":false, "message":"\(sString)"])
                        completionHandler(responseErrorData!, nil)
                    }
                } else if let responseModelObject = response.result.value{
                    responseModelObject.status = true
                    completionHandler(responseModelObject, nil)
                } else {
                    let responseErrorData = ResponseModel(JSON: ["status":false, "message":"Json object error from server"])
                    completionHandler(responseErrorData!, nil)
                }
            }else {
                let someString = String(data: response.data!, encoding: .utf8)
                print(someString!)
                if let sString = someString {
                    if sString == "Successfully added" || sString == "\"Successfully added\""{
                        let responseErrorData = ResponseModel(JSON: ["status":true, "message":"\(sString)"])
                        completionHandler(responseErrorData!, nil)
                    } else {
                        let responseErrorData = ResponseModel(JSON: ["status":false, "message":"Error from Server"])
                        completionHandler(responseErrorData!, nil)
                        
                    }
                } else {
                    let responseErrorData = ResponseModel(JSON: ["status":false, "message":"Error from Server"])
                    completionHandler(responseErrorData!, nil)
                    
                }
            }
        }
    }
    
    
    func makeUserLogout() {
        if NewSuccessModel.getLoginSuccessToken() != nil {
            
            UIApplication.shared.applicationIconBadgeNumber = 0
            NewSuccessModel.removeLoginSuccessToken()
            
            guard let window = UIApplication.shared.windows.first else {return}
            
            let vc : SignInVC = AppDelegate.mainSB.instanceVC()
            let rootNC = UINavigationController(rootViewController: vc)
            window.rootViewController = rootNC
            window.makeKeyAndVisible()
            
        }
    }
    
    func sendRequestGetAuth(urlString:String , completion: @escaping (_ response : [String : Any] ) -> Void)
    {
        
        let strURL = "\(serverURL )/\(urlString)"
        let auth = [ "authorization":
                        "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        Alamofire.request( strURL , method: .get, parameters: nil,
                           encoding:  URLEncoding.default, headers: auth).responseJSON
        { response in
            if(response.result.isSuccess)
            {
                
                if   let resp = response.result.value as? NSDictionary {
                    let status = resp.value(forKey: "status") as? Bool
                    let error = resp.value(forKey: "error") as? String
                    
                    if status == false {
                        if error == "Token incorrect!" || error == "Signature verification failed"{
                            self.makeUserLogout()
                        }else{
                            completion(resp as! [String : Any])
                        }
                        
                    }else{
                        completion(resp as! [String : Any])
                    }
                    
                }
                
            }
        }
    }
    
    
    func sendRequestPostAuth(urlString:String ,parameters: Parameters, completion: @escaping (_ response : [String : Any] ) -> Void)
    {
        
        let strURL = "\(serverURL)/\(urlString)"
        let auth = [ "authorization":
                        "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request( strURL , method: .post, parameters: parameters,
                           encoding:  URLEncoding.default, headers: auth).responseJSON
        { response in
            
            if(response.result.isSuccess)
            {
                
                if   let resp = response.result.value as? NSDictionary {
                    let status = resp.value(forKey: "status") as? Bool
                    let error = resp.value(forKey: "error") as? String
                    
                    if status == false {
                        if error == "Token incorrect!" || error == "Signature verification failed"{
                            self.makeUserLogout()
                            
                        }else{
                            completion(resp as! [String : Any])
                        }
                        
                    }else{
                        completion(resp as! [String : Any])
                    }
                    
                }
                
            }
        }}
    
    
    func sendRequestGetAuthTheme(urlString:String , completion: @escaping (_ response : [String : Any] ) -> Void)
    {
        
        let strURL = "\(serverURL )/\(urlString)"
        let auth = [ "authorization":
                        "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        Alamofire.request( strURL , method: .get, parameters: nil,
                           encoding:  URLEncoding.default, headers: auth).responseJSON
        { response in
            
            if(response.result.isSuccess)
            {
                
                if   let resp = response.result.value as? NSDictionary {
                    _ = resp.value(forKey: "status") as? Bool
                    completion(resp as! [String : Any])
                    
                    
                }
                
            }}}
    
    
    func func_Upload(queryString:String , _ arr_attach: [attachment] , param:[String:String],completion: @escaping (_ response : [String : Any])->Void)
    {
        
        let auth = [ "authorization":
                        "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let strURL = "\(serverURL )/\(queryString)"
        
        let urlStr : String = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let getApi = URL(string: urlStr)!
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            let myId = Date().millisecondsSince1970
            
            
            
            for (key, value) in param {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            
            for i in arr_attach {
                
                switch i.type {
                case "img":
                    
                    let data = i.img!.jpegData(compressionQuality: 0.4)
                    if let imageData = data{
                        multipartFormData.append(imageData,
                                                 withName: "attachments[\(i.index)][file]",
                                                 fileName: "\(myId).jpg",
                                                 mimeType: "image/jpeg")
                        
                    }
                    
                case "file":
                    if i.IsNew == false && i.url != nil{
                        do {
                            let file = try Data(contentsOf: i.url!)
                            
                            multipartFormData.append( file as Data, withName: "attachments[0][file]", fileName: "\(myId)", mimeType: "text/plain")
                        } catch {
                            debugPrint("Couldn't get Data from URL: \(String(describing: i.url)): \(error)")
                        }
                    }
                    
                    
                    
                default:
                    print("no data")
                    
                }
            }
            
            
            
        }, usingThreshold: UInt64.init(), to: getApi, method: .post, headers: auth) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded",response.result.value ?? "No Value")
                    if let result = response.result.value as? NSDictionary {
                        //let data = result.value(forKey: "data") as? NSDictionary
                        completion(result as! [String : Any])
                    }else {
                        print(result)
                        Auth_User.topVC()?.hideLoadingActivity()
                        
                        completion( ["Status" : false])
                        
                    }
                }
            case .failure(_):
                completion([:])
            }
        }
    }
    
    func func_UploadTechnical(queryString:String , _ arr_attach: [Technical_Assistants] , param:[String:String],completion: @escaping (_ response : [String : Any])->Void)
    {
        
        let auth = [ "authorization":
                        "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let strURL = "\(serverURL )/\(queryString)"
        
        let urlStr : String = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let getApi = URL(string: urlStr)!
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            let myId = Date().millisecondsSince1970
            
            
            
            for (key, value) in param {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            
            for i in arr_attach {
                
                switch i.type {
                case "img":
                    let data = i.img!.jpegData(compressionQuality: 0.4)
                    if let imageData = data{
                        multipartFormData.append(imageData,
                                                 withName: "Technical_Assistants_Evaluation[\(i.index)][attachments][0][file]",
                                                 fileName: "\(myId).jpg",
                                                 mimeType: "image/jpeg")
                        
                    }
                    
                case "file":
                    if i.IsNew == false && i.url != nil{
                        do {
                            let file = try Data(contentsOf: i.url!)
                            
                            multipartFormData.append( file as Data, withName: "Technical_Assistants_Evaluation[\(i.index)][attachments][0][file]", fileName: "\(myId)", mimeType: "text/plain")
                        } catch {
                            debugPrint("Couldn't get Data from URL: \(String(describing: i.url)): \(error)")
                        }
                    }
                    
                    
                    
                default:
                    print("no data")
                    
                    
                }
            }
            
            
            
        }, usingThreshold: UInt64.init(), to: getApi, method: .post, headers: auth) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    if let result = response.result.value as? NSDictionary {
                        //let data = result.value(forKey: "data") as? NSDictionary
                        completion(result as! [String : Any])
                    }else {
                        print(result)
                        // completion(result as! [String : Any])
                        
                    }
                }
            case .failure(_):
                //                completion(result as? [String : Any] ?? [:])
                break
            }
        }
    }
    
    
    
    func func_UploadEvalution(queryString:String , _ arr_attach: [AttachNotes] , param:[String:String],completion: @escaping (_ response : [String : Any])->Void)
    {
        
        let auth = [ "authorization":
                        "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let strURL = "\(serverURL )/\(queryString)"
        
        let urlStr : String = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let getApi = URL(string: urlStr)!
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            let myId = Date().millisecondsSince1970
            
            
            
            for (key, value) in param {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            
            for item in arr_attach {
                
                for i in item.arr {
                    
                    switch i.type {
                    case "img":
                        let data = i.img!.jpegData(compressionQuality: 0.4)
                        if let imageData = data{
                            multipartFormData.append(imageData,
                                                     withName: "Evaludation_Result[\(item.index)][attachments][\(i.index)][file]",
                                                     fileName: "\(myId).jpg",
                                                     mimeType: "image/jpeg")
                            
                        }
                    case "file":
                        if i.IsNew == false && i.url != nil{
                            do {
                                let file = try Data(contentsOf: i.url!)
                                
                                multipartFormData.append( file as Data, withName: "Evaludation_Result[\(item.index)][attachments][\(i.index)][file]", fileName: "\(myId)", mimeType: "text/plain")
                            } catch {
                                debugPrint("Couldn't get Data from URL: \(String(describing: i.url)): \(error)")
                            }
                        }
                    default:
                        print("no data")
                        
                        
                    }
                }
                
            }
            
            
            
            
        }, usingThreshold: UInt64.init(), to: getApi, method: .post, headers: auth) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    if let result = response.result.value as? NSDictionary {
                        //let data = result.value(forKey: "data") as? NSDictionary
                        completion(result as! [String : Any])
                    }else {
                        print(result)
                        // completion(result as! [String : Any])
                        
                    }
                }
            case .failure(_):
                //                completion(result as? [String : Any] ?? [:])
                break
            }
        }
    }
    
    
    
    func searchForUser(search_Key:String , completion: @escaping (_ response : [String : Any] ) -> Void)
    {
        
        let strURL = "\(serverURL)/tc/getformuserslist"
        
        let auth = [ "authorization":
                        "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let param = [
            "search" : search_Key,
            "lang_key" : "en",
            "user_type_id": "1"
        ]
        
        Alamofire.request( strURL , method: .get, parameters: param,
                           encoding:  URLEncoding.queryString, headers: auth).responseJSON
        { response in
            
            if(response.result.isSuccess)
            {
                
                if   let resp = response.result.value as? NSDictionary {
                    let status = resp.value(forKey: "status") as? Bool
                    let error = resp.value(forKey: "error") as? String
                    
                    if status == false {
                        if error == "Token incorrect!" || error == "Signature verification failed"{
                            self.makeUserLogout()
                            
                        }else{
                            completion(resp as! [String : Any])
                        }
                        
                    }else{
                        completion(resp as! [String : Any])
                    }
                    
                }
            }
        }
    }
    
    
    
    
    
    
    func getPermissionMentionsData(pageNumber:String,searchBranchId:String,groupId:String,userId:String,callback:@escaping(_ data:PermissionMentions)->Void){
        
        let strURL = "\(serverURL)/human_resources/get_permission_mentions/\(pageNumber)/10"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        let parameters = ["search[branch_id]":searchBranchId,"search[group_key]":groupId,"search[user_id]":userId]
        
        Alamofire.request(strURL, method: .post , parameters:parameters,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : PermissionMentions = Mapper<PermissionMentions>().map(JSONString:str){
                    
                    callback(parsedMapperString)
                }
            }
        }
        
    }
    
    
    func getSearchBranchMenu(callback:@escaping(_ data:SearchBranch)->Void){
        
        let strURL = "\(serverURL)/human_resources/get_branches"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        print("Token",NewSuccessModel.getLoginSuccessToken() ?? "nil")
        Alamofire.request(strURL, method: .get , parameters:nil,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : SearchBranch = Mapper<SearchBranch>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getGroupsMenu(callback:@escaping(_ data:SearchBranch)->Void){
        
        let strURL = "\(serverURL)/human_resources/get_groups"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .get , parameters:nil,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : SearchBranch = Mapper<SearchBranch>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getUsersMenu(callback:@escaping(_ data:SearchBranch)->Void){
        
        let strURL = "\(serverURL)/human_resources/get_users/0"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .post , parameters:["user_type_id":1],headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : SearchBranch = Mapper<SearchBranch>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getSettingsData(pageNumber:String,searchType:String,searchKey:String,callback:@escaping(_ data:SettingsData)->Void){
        
        let strURL = "\(serverURL)/human_resources/getsettings/\(pageNumber)/10"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .post , parameters:["searchType":searchType,"searchKey":searchKey],headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : SettingsData = Mapper<SettingsData>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getEditingData(setting_id:String,callback:@escaping(_ data:EditingData)->Void){
        let strURL = "\(serverURL)/human_resources/edit_settings"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .post , parameters:["setting_id":setting_id],headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : EditingData = Mapper<EditingData>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func updateSettingsData(body:[String:Any],callback:@escaping(_ data:UpdateSettingResponse)->Void){
        let strURL = "\(serverURL)/human_resources/update_settings"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .post , parameters:body,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func addSettingsData(body:[String:Any],callback:@escaping(_ data:UpdateSettingResponse)->Void){
        let strURL = "\(serverURL)/human_resources/save_settings"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .post , parameters:body,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func addPermissionMentionsData(branch_id:String,group_id:String,users_id:String,callback:@escaping(_ data:UpdateSettingResponse)->Void){
        let strURL = "\(serverURL)/human_resources/savehrpermissions"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        let body = ["branch_id": branch_id,
                    "group_id": group_id,
                    "users_id": users_id]
        Alamofire.request(strURL, method: .post , parameters:body,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func deletePermissionMentionsData(id:String,callback:@escaping(_ data:UpdateSettingResponse)->Void){
        let strURL = "\(serverURL)/human_resources/delete_permits"
        let headers = [ "Authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")",
                        "Content-Type": "application/x-www-form-urlencoded" ]
        
        let body = ["key_ids[]": id]
        Alamofire.request(strURL, method: .delete , parameters:body,encoding: URLEncoding.httpBody , headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func deleteSettingsData(id:String,callback:@escaping(_ data:UpdateSettingResponse)->Void){
        let strURL = "\(serverURL)/human_resources/delete_settings"
        let headers = [ "Authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")",
                        "Content-Type": "application/x-www-form-urlencoded" ]
        
        let body = ["key_ids[]": id]
        Alamofire.request(strURL, method: .delete , parameters:body,encoding: URLEncoding.httpBody , headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getAllEmployees(pageNumber:String,body:[String:Any],callback:@escaping(_ data:AllEmployeeResponse)->Void){
        let strURL = "\(serverURL)/human_resources/employees_report/\(pageNumber)/10"
        let headers = [ "Authorization":"\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"]
        print("ksfhlashfls-BODY",body)
        Alamofire.request(strURL, method: .post , parameters:body ,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                print("ksfhlashfls-STR",str)
                if let parsedMapperString : AllEmployeeResponse = Mapper<AllEmployeeResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func deleteEmployee(id:String,callback:@escaping(_ data:UpdateSettingResponse)->Void){
        
        let strURL = "\(serverURL)/81f5cc8c046c6d1c66fa3424783873db/MAIN"
        let headers = [ "Authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ,
                        "Accept-Encoding": "gzip","Content-Type:":"text/plain"]
        
        let body = ["key_ids[]": id]
        Alamofire.request(strURL, method: .delete , parameters:body,encoding: URLEncoding.httpBody , headers:headers).validate().responseJSON { (response) in
            
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                print("XXXXXX-Str",str)
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getFilterData(callback:@escaping(_ data:FilterGetResponse)->Void){
        let strURL = "\(serverURL)/human_resources/get_advanced_search_meta_data"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .get , parameters:nil,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : FilterGetResponse = Mapper<FilterGetResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getFilterData2(callback:@escaping(_ data:FilterGetResponse2)->Void){
        let strURL = "\(serverURL)/human_resources/branches/human_resources_view"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .get , parameters:nil,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : FilterGetResponse2 = Mapper<FilterGetResponse2>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getFilterData3(callback:@escaping(_ data:FilterGetResponse3)->Void){
        let strURL = "\(serverURL)/human_resources/get_project_subjects"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .get , parameters:nil,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : FilterGetResponse3 = Mapper<FilterGetResponse3>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getDropDownData(callback:@escaping(_ data:FilterGetResponse2)->Void){
        
        let strURL = "\(serverURL)/human_resources/branches/human_resources_edit"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .get , parameters:nil,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : FilterGetResponse2 = Mapper<FilterGetResponse2>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getGroupNameEnglish(callback:@escaping(_ data:GroupNameResponse)->Void){
        let strURL = "\(serverURL)/human_resources/grouplists"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .get , parameters:nil,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : GroupNameResponse = Mapper<GroupNameResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getBankData(callback:@escaping(_ data:BanksResponse)->Void){
        let strURL = "\(serverURL)/human_resources/getbanks"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .get , parameters:nil,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : BanksResponse = Mapper<BanksResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    
    
    func getEmployeeData(empID:String,callback:@escaping(_ data:EmployeeResponse)->Void){
        let strUrl = "\(serverURL)/human_resources/get_employee_details/\(empID)/1"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strUrl, method: .get , parameters: nil,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : EmployeeResponse = Mapper<EmployeeResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func updateEmployeeDetails(empImage:UIImage?,empID:String,body:EditBody,callback:@escaping(_ data:Edit)->Void){
        let strURL = "\(serverURL)/human_resources/update_employee_details/\(empID)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        let parameters:[String:Any] = body.toDict()
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            if let empImage = empImage{
                
                guard let imgData = empImage.jpegData(compressionQuality: 0.1) else { return }
                multipartFormData.append(imgData, withName: "profile_image", fileName: "\(Date.init().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            
            for (key, value) in parameters {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
            }
            
        },
                         to: URL(string: strURL)!, method: .post , headers: headers) { (result:SessionManager.MultipartFormDataEncodingResult) in
            switch result{
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.responseJSON { (response:DataResponse<Any>) in
                    if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                        if let parsedMapperString : Edit = Mapper<Edit>().map(JSONString:str){
                            callback(parsedMapperString)
                        }
                    }
                }
            case .failure(let error):
                print("Error:",error.localizedDescription)
                break
                
            }
        }
    }
    
    func getEmployeeViewData(empId:String,branchId:String,callback:@escaping(_ data:EmpViewResponse)->Void){
        let strURL = "\(serverURL)/human_resources/get_myview_data/\(empId)/\(branchId)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .get , parameters:nil,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : EmpViewResponse = Mapper<EmpViewResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getImage(url:String,callback:@escaping(_ data:GetImageResponse)->Void){
        let strURL = "\(serverURL)/\(url)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        Alamofire.request(strURL, method: .get , parameters:nil,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : GetImageResponse = Mapper<GetImageResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getJopDetails(pageNumber:Int,branchId:String,id:String,searchKey:String,callback:@escaping(_ data:JopDetailsResponse)->Void){
        let strURL = "\(serverURL)/positions/\(pageNumber)/10"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let param = ["branch_id":branchId,"id":id,"searchKey":searchKey]
        Alamofire.request(strURL, method: .post , parameters:param,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : JopDetailsResponse = Mapper<JopDetailsResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func deleteJopDetails(key_id:String,branchId:String,empId:String,callback:@escaping(_ data:UpdateSettingResponse)->Void){
        let strURL = "\(serverURL)/01f5086b879a62a05da4094dac203558/POSITION/\(empId)/\(branchId)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let param = ["key_ids[]":key_id]
        Alamofire.request(strURL, method: .delete , parameters:param,encoding: URLEncoding.httpBody,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getJopList(callback:@escaping(_ data:JobListResponse)->Void){
        let strURL = "\(serverURL)/human_resources/joblists"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .get , parameters:nil ,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : JobListResponse = Mapper<JobListResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getNeededLicenes(setting_Id:String,callback:@escaping(_ data:JobListResponse)->Void){
        
        let strURL = "\(serverURL)/signup/get_needed_licences/\(setting_Id)/null"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .get , parameters:nil ,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : JobListResponse = Mapper<JobListResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func addPositionOrEducation(url:String,body:[String:Any],callback:@escaping(_ data:UpdateSettingResponse)->Void){
        
        let strURL = "\(serverURL)/\(url)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .post , parameters:body ,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    
    func getDataForUpdateJopDetails(branchId:String,id:String,positionID:String,callback:@escaping(_ data:JopDetailsResponse)->Void){
        let strURL = "\(serverURL)/positions/1/1"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let param = ["branch_id":branchId,"id":id,"position_id":positionID]
        Alamofire.request(strURL, method: .post , parameters:param,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : JopDetailsResponse = Mapper<JopDetailsResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getAllContactDetails(pageNumber:String,searchKey:String,branch_id:String,id:String,employee_id_number:String,callback:@escaping(_ data:ContactGetResponse)->Void){
        let strURL = "\(serverURL)/human_resources/get_employee_contacts/\(pageNumber)/10"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let param = ["searchKey":searchKey,"branch_id":branch_id,"id":id,"employee_id_number":employee_id_number]
        Alamofire.request(strURL, method: .post , parameters:param,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : ContactGetResponse = Mapper<ContactGetResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func deleteEmpContact(key_id:String,branchId:String,empId:String,callback:@escaping(_ data:UpdateSettingResponse)->Void){
        let strURL = "\(serverURL)/01f5086b879a62a05da4094dac203558/CONTACT/\(empId)/\(branchId)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let param = ["key_ids[]":key_id]
        Alamofire.request(strURL, method: .delete , parameters:param,encoding: URLEncoding.httpBody,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func addContact(url:String,contact_id:String,contact_person_name:String,contact_mobile_number:String,contact_email_address:String,contact_address_text:String,branch_id:String,empId:String,employee_id_number:String,callback:@escaping(_ data:UpdateSettingResponse)->Void){
        let strURL = "\(serverURL)/human_resources/\(url)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let param = [
            "contact_id": contact_id,
            "contact_person_name": contact_person_name,
            "contact_mobile_number": contact_mobile_number,
            "contact_email_address": contact_email_address,
            "contact_address_text": contact_address_text,
            "branch_id": branch_id,
            "id": empId,
            "employee_id_number": employee_id_number
        ]
        
        print("ASDASD-",param)
        
        Alamofire.request(strURL, method: .post , parameters:param,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getAllEducationDetails(pageNumber:String,searchKey:String,branch_id:String,id:String,employee_id_number:String,callback:@escaping(_ data:EducationGetResponse)->Void){
        let strURL = "\(serverURL)/get_my_educations/\(pageNumber)/10"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let param = ["searchKey":searchKey,"branch_id":branch_id,"id":id,"employee_id_number":employee_id_number]
        Alamofire.request(strURL, method: .post , parameters:param,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : EducationGetResponse = Mapper<EducationGetResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func deleteEmpEducation(key_id:String,branchId:String,empId:String,callback:@escaping(_ data:UpdateSettingResponse)->Void){
        let strURL = "\(serverURL)/01f5086b879a62a05da4094dac203558/EDUCATION/\(empId)/\(branchId)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let param = ["key_ids[]":key_id]
        Alamofire.request(strURL, method: .delete , parameters:param,encoding: URLEncoding.httpBody,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getVisibiltyData(callback:@escaping(_ data:SearchBranch)->Void){
        
        let strURL = "\(serverURL)/lflevel"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .get , parameters:nil,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : SearchBranch = Mapper<SearchBranch>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func updateAttachmentData(body:[String:Any],callback:@escaping(_ data:UpdateSettingResponse)->Void){
        
        let strURL = "\(serverURL)/hr_update_filename"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .put , parameters:body,encoding: URLEncoding.httpBody,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func uploadAttachmentData(fileUrl:URL?,body:[String:Any],callback:@escaping(_ data:UpdateSettingResponse)->Void){
        
        let strURL = "\(serverURL)/hr_upload_attachments"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        let parameters:[String:Any] = body
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            if let fileUrl = fileUrl {
                do{
                    let data = try Data(contentsOf: fileUrl)
                    multipartFormData.append(data, withName: "attachment_link", fileName: "\(Date.init().timeIntervalSince1970).\(fileUrl.pathExtension)", mimeType: fileUrl.mimeType())
                }catch{
                    
                }
            }
            
            for (key, value) in parameters {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
            }
            
        },
                         to: URL(string: strURL)!, method: .post , headers: headers) { (result:SessionManager.MultipartFormDataEncodingResult) in
            switch result{
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.responseJSON { (response:DataResponse<Any>) in
                    if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                        if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                            callback(parsedMapperString)
                        }
                    }
                }
            case .failure(let error):
                print("Error:",error.localizedDescription)
                break
                
            }
        }
    }
    
    func getAttachmentPreview(filePath:String,callback:@escaping(_ data:GetImageResponse)->Void){
        let strURL = "\(serverURL)/\(filePath)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .get , parameters:nil,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : GetImageResponse = Mapper<GetImageResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getInsuranceData(pageNumber:String,empId:String,empIdNumber:String,branchId:String,searchKey:String,searchStatus:String,callback:@escaping(_ data:InsuranceGetResponse)->Void){
        
        let strURL = "\(serverURL)/hr_insurance_dependents/\(pageNumber)/10"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let param:[String:Any] = ["id": empId,
                                  "employee_id_number": empIdNumber,
                                  "branch_id": branchId,
                                  "searchKey": searchKey,
                                  "searchStatus": searchStatus]
        
        Alamofire.request(strURL, method: .post , parameters:param,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : InsuranceGetResponse = Mapper<InsuranceGetResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func deleteInsuranceDetails(key_id:String,branchId:String,empId:String,callback:@escaping(_ data:UpdateSettingResponse)->Void){
        let strURL = "\(serverURL)/01f5086b879a62a05da4094dac203558/INSURANCE/\(empId)/\(branchId)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let param = ["key_ids[]":key_id]
        Alamofire.request(strURL, method: .delete , parameters:param,encoding: URLEncoding.httpBody,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func updateInsuranceDetails(body:[String:Any],callback:@escaping(_ data:UpdateSettingResponse)->Void){
        let strURL = "\(serverURL)/hr_update_insurance"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .put , parameters:body,encoding: URLEncoding.httpBody,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func addInsuranceDetails(body:[String:Any],callback:@escaping(_ data:UpdateSettingResponse)->Void){
        let strURL = "\(serverURL)/hr_create_insurance"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .post , parameters:body,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getAllNotes(pageNumber:String,empId:String,branchId:String,searchKey:String,searchStatus:String,callback:@escaping(_ data:NotesGetResponse)->Void){
        let strURL = "\(serverURL)/hr_notes/\(pageNumber)/10"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        let param:Parameters = ["id": empId,
                                "branch_id": branchId,
                                "search_key": searchKey,
                                "search_status": searchStatus]
        Alamofire.request(strURL, method: .post , parameters:param,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : NotesGetResponse = Mapper<NotesGetResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func deleteNote(key_id:String,branchId:String,empId:String,callback:@escaping(_ data:UpdateSettingResponse)->Void){
        let strURL = "\(serverURL)/01f5086b879a62a05da4094dac203558/NOTE/\(empId)/\(branchId)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let param = ["key_ids[]":key_id]
        Alamofire.request(strURL, method: .delete , parameters:param,encoding: URLEncoding.httpBody,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func addNote(note_id:String?,description:String,reminderStatusSelection:String,reminderDate:String,statusSelection:String,linkListSelection:String,empId:String,callback:@escaping(_ data:UpdateSettingResponse)->Void){
        
        let strURL = "\(serverURL)/\(note_id == nil ? "hr_create_notes" : "hr_update_notes")"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        var param = ["note_description": description,
                     "note_remainder_status": reminderStatusSelection,
                     "note_remainder_date": reminderDate,
                     "show_status": statusSelection,
                     "link_with_view_list": linkListSelection,
                     "id": empId]
        
        if let note_id = note_id {
            param["note_id"] = note_id
        }
        
        Alamofire.request(strURL, method: note_id == nil ? .post : .put , parameters:param,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    
    func getAllAttachments(pageNumber:String,empId:String,branchId:String,searchKey:String,attachmentType:String,callback:@escaping(_ data:AttachmentsGetREsponse)->Void){
        let strURL = "\(serverURL)/attachments_for_employee/\(pageNumber)/10"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        let param:Parameters = ["branch_id": branchId,
                                "employee_number": empId,
                                "search_key": searchKey,
                                "attachmentType":attachmentType ]
        
        Alamofire.request(strURL, method: .post , parameters:param,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : AttachmentsGetREsponse = Mapper<AttachmentsGetREsponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func deleteAttachment(key_id:String,branchId:String,empId:String,callback:@escaping(_ data:UpdateSettingResponse)->Void){
        let strURL = "\(serverURL)/01f5086b879a62a05da4094dac203558/ATTACHMENT/\(empId)/\(branchId)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let param = ["key_ids[]":key_id]
        Alamofire.request(strURL, method: .delete , parameters:param,encoding: URLEncoding.httpBody,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getAttachmentTypes(callback:@escaping(_ data:AttachmentTypeResponse)->Void){
        let strURL = "\(serverURL)/module_attach_types/?module_name=human_resources"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .get , parameters:nil,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : AttachmentTypeResponse = Mapper<AttachmentTypeResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func searchForUser(searchText:String,lang:String,id:String,callback:@escaping(_ data:SearchUserResponse)->Void){
        let strURL = "\(serverURL)/tc/getformuserslist?search=\(searchText)&lang_key=\(lang)&user_type_id=\(id)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .get , parameters:nil,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : SearchUserResponse = Mapper<SearchUserResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func submitCommunicationDetails(isIncoming:Bool,files:[String:URL],body:[String:Any],callback:@escaping(_ data:CommunicationSubmitResponse)->Void){
        let strURL = "\(serverURL)/form/\(isIncoming ? "FORM_C2" : "FORM_C1")/cr/0"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        Alamofire.upload(multipartFormData: { multipartFormData in
            for file in files{
                
                do{
                    let data = try Data(contentsOf: file.value)
                    multipartFormData.append(data, withName: file.key, fileName: "\(Date.init().timeIntervalSince1970).\(file.value.pathExtension)", mimeType: file.value.mimeType())
                }catch{
                    
                }
            }
            for (key, value) in body {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
            }
            
        }, to: URL(string: strURL)!, method: .post , headers: headers) { (result:SessionManager.MultipartFormDataEncodingResult) in
            switch result{
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.responseJSON { (response:DataResponse<Any>) in
                    if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                        if let parsedMapperString : CommunicationSubmitResponse = Mapper<CommunicationSubmitResponse>().map(JSONString:str){
                            callback(parsedMapperString)
                        }
                    }
                }
            case .failure(let error):
                print("Error:",error.localizedDescription)
                break
            }
        }
    }
    
    func getModulesFilter(callback:@escaping(_ data:GetModulsResponse)->Void){
        let strURL = "\(serverURL)/module"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .post , parameters:nil,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : GetModulsResponse = Mapper<GetModulsResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getModules(pageNumber:String,searchKey:String,module_name:String,empId:String,callback:@escaping(_ data:AllModulesResponse)->Void){
        let strURL = "\(serverURL)/employeemodules/\(pageNumber)/10?search_key=\(searchKey)&module_name=\(module_name)&id=\(empId)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .get , parameters:nil,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : AllModulesResponse = Mapper<AllModulesResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
            
        }
    }
    
    func getModuleUers(body:[String:Any],callback:@escaping(_ data:ModuleUersResponse)->Void){
        
        let strURL = "\(serverURL)/moduleusers"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .post , parameters:body,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : ModuleUersResponse = Mapper<ModuleUersResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getMyTransactionData(url:String,callback:@escaping(_ data:TransactionResponse)->Void){
        
        let strURL = "\(serverURL)/\(url)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .get , parameters: nil,headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                print("AAAAQW-Str",str)
                if let parsedMapperString : TransactionResponse = Mapper<TransactionResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func sendQRCode(code:String,callback:@escaping(_ data:EmployeeResponse)->Void){
        let strURL = "\(serverURL)/auto_login"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .post , parameters: ["qrcode":code],headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : EmployeeResponse = Mapper<EmployeeResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getVactionTypes(empNum:String,callback:@escaping (_ response:VactionTypesResponse)->Void){
        let strURL = "\(serverURL)/form/FORM_HRV1/get_vacation_type/"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .post , parameters: ["employee_number:":empNum],headers:headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : VactionTypesResponse = Mapper<VactionTypesResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func showSelectionVactionResult(empNum:String,vacation_type_id:String,beforeDate:String,afterDate:String,callback:@escaping(_ data:SelectionVactionResult)->Void){
        let strURL = "\(serverURL)/form/FORM_HRV1/check_vacation_for_employee"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let param = ["employee_number":empNum,"vacation_type_id":vacation_type_id,"before_vacation_working_date_english":beforeDate,"after_vacation_working_date_english":afterDate]
        
        print("ASDASDQf",param)
        
        Alamofire.request(strURL, method: .post , parameters:param ,headers:headers).validate().responseJSON { (response) in
            
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : SelectionVactionResult = Mapper<SelectionVactionResult>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func submitVaction(fileUrl:[URL],body:[String:Any],callback:@escaping(_ data:SubmitVactionResponse)->Void){
        
        let strURL = "\(serverURL)/form/FORM_HRV1/cr/0"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        let parameters:[String:Any] = body
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            for index in 0..<fileUrl.count {
                do{
                    print("ASDQDSS","attachments[\(index)][file]")
                    
                    let data = try Data(contentsOf: fileUrl[index])
                    multipartFormData.append(data, withName: "attachments[\(index)][file]", fileName: "\(Date.init().timeIntervalSince1970).\(fileUrl[index].pathExtension)", mimeType: fileUrl[index].mimeType())
                }catch{
                    
                }
            }
            
            for (key, value) in parameters {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
            }
            
        },
                         to: URL(string: strURL)!, method: .post , headers: headers) { (result:SessionManager.MultipartFormDataEncodingResult) in
            switch result{
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.responseJSON { (response:DataResponse<Any>) in
                    if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                        if let parsedMapperString : SubmitVactionResponse = Mapper<SubmitVactionResponse>().map(JSONString:str){
                            callback(parsedMapperString)
                        }
                    }
                }
            case .failure(let error):
                print("Error:",error.localizedDescription)
                break
                
            }
        }
    }
    
    func getEmpInfoForVaction(empNum:String,callback:@escaping(_ data:EmpInfoResposne)->Void){
        let strURL = "\(serverURL)/form/FORM_HRV1/get_employee_info"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let param = ["employee_number":empNum]
        
        Alamofire.request(strURL, method: .post , parameters:param ,headers:headers).validate().responseJSON { (response) in
            
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : EmpInfoResposne = Mapper<EmpInfoResposne>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getVactionData(vactionId:String,callback:@escaping(_ data:VactionFromDataResponse)->Void){
        let strURL = "\(serverURL)/form/FORM_HRV1/vr/\(vactionId)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        
        Alamofire.request(strURL, method: .get , parameters:nil ,headers:headers).validate().responseJSON { (response) in
            
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                print("asdasdasdsadas - Response -",str)
                if let parsedMapperString : VactionFromDataResponse = Mapper<VactionFromDataResponse>().map(JSONString:str){
                    if parsedMapperString.error == "Token incorrect!" || parsedMapperString.error == "Signature verification failed"{
                        self.makeUserLogout()
                    }else{
                        callback(parsedMapperString)
                    }
                }
            }
        }
    }
    
    
    func editUserStep(formType:String,user_id:String,transaction_request_id:String,callback:@escaping(_ data:Edit)->Void){
        let strURL = "\(serverURL)/form/\(formType)/asp"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let param = [
            "user_id": user_id,
            "transaction_request_id": transaction_request_id
        ]
        
        Alamofire.request(strURL, method: .post , parameters:param ,headers:headers).validate().responseJSON { (response) in
            
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : Edit = Mapper<Edit>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func submitApproval(formType:String,transaction_request_id:String,approving_status:String,note:String,transactions_persons_action_code:String,callback:@escaping(_ data:Edit)->Void){
        let strURL = "\(serverURL)/form/\(formType)/sr"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        
        let param = [
            "transaction_request_id": transaction_request_id,
            "approving_status": approving_status,
            "note": note,
            "transactions_persons_action_code": transactions_persons_action_code
        ]
        
        Alamofire.request(strURL, method: .post , parameters:param ,headers:headers).validate().responseJSON { (response) in
            
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : Edit = Mapper<Edit>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getTicketRow(ticketId:String,callback:@escaping(_ data:TicketRowResponse)->Void){
        let strURL = "\(serverURL)/tasks/get_ticket_row"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let param = ["ticket_id": ticketId]
        
        Alamofire.request(strURL, method: .post , parameters:param ,headers:headers).validate().responseJSON { (response) in
            
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : TicketRowResponse = Mapper<TicketRowResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func fetchSendCode(username:String,password:String,callback:@escaping(_ data:Edit)->Void){
        var strURL = "\(serverURL)/user/get_code_options?username=\(username)&password=\(password)"
        strURL = strURL.replacingOccurrences(of: " ", with: "%20")
        Alamofire.request(strURL, method: .get,encoding: URLEncoding.httpBody,headers: ["X-API-KEY":api_key]).validate().responseJSON { (response) in
            
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : Edit = Mapper<Edit>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func sendCode(username:String,password:String,senderType:String,callback:@escaping(_ data:Edit)->Void){
        let strURL = "\(serverURL)/user/send_otp_code?username=\(username)&sender_type=\(senderType)&password=\(password)"
        
        
        Alamofire.request(strURL, method: .get ,headers: ["X-API-KEY":api_key]).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : Edit = Mapper<Edit>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func changeTicketStatus(status:String,ticketId:String,callback:@escaping (_ data:Edit)->Void){
        let strURL = "\(serverURL)/tasks/change_status_ticket"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        let param = [
            "ticket_id": ticketId,
            "status": status
        ]
        
        Alamofire.request(strURL, method: .post ,parameters: param ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : Edit = Mapper<Edit>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
        
    }
    
    func getAllComments(type:String,ticketId:String,callback:@escaping (_ data:CommentsResponse)->Void){
        let strURL = "\(serverURL)/tasks/get_comments/asc"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        let param = [
            "ticket_id": ticketId,
            "type": type
        ]
        Alamofire.request(strURL, method: .post ,parameters: param ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : CommentsResponse = Mapper<CommentsResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func addComment(comment:String,ticketId:String,callback:@escaping (_ data:AddTicketCommentResponse)->Void){
        let strURL = "\(serverURL)/tasks/add_comment"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        let param = [
            "ticket_id": ticketId,
            "notes": comment
        ]
        Alamofire.request(strURL, method: .post ,parameters: param ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : AddTicketCommentResponse = Mapper<AddTicketCommentResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    
    func editComment(note:String,comment_id:String,callback:@escaping (_ data:DeleteCommentResponse)->Void){
        
        let strURL = "\(serverURL)/tasks/update_comment_reply"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        print("comment_id",comment_id)
        print("notes",note)
        let param = [
            "comment_id": comment_id,
            "notes": note
        ]
        
        print("URL:", strURL)
        print("headers",headers)
        print("Body",param)
        
        Alamofire.request(strURL, method: .post ,parameters: param ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                print("ASDASD",str)
                if let parsedMapperString : DeleteCommentResponse = Mapper<DeleteCommentResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func addCommentReply(ticketId:String,reply:String,comment_id:String,callback:@escaping (_ data:AddTicketCommentResponse)->Void){
        
        let strURL = "\(serverURL)/tasks/add_new_reply"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let param = [
            "ticket_id": ticketId,
            "comment_id": comment_id,
            "notes": reply
        ]
        
        
        Alamofire.request(strURL, method: .post ,parameters: param ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : AddTicketCommentResponse = Mapper<AddTicketCommentResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func deleteCommentReply(comment_id:String,callback:@escaping (_ data:DeleteCommentResponse)->Void){
        let strURL = "\(serverURL)/tasks/delete_comment_reply"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let param = [
            "comment_id": comment_id
        ]
        
        
        Alamofire.request(strURL, method: .post ,parameters: param ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : DeleteCommentResponse = Mapper<DeleteCommentResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func addTaskReplyToComment(taskId:String,reply:String,comment_id:String,callback:@escaping (_ data:AddTicketCommentResponse)->Void){
        
        let strURL = "\(serverURL)/tasks/add_reply_task"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let param = [
            "task_id": taskId,
            "comment_id": comment_id,
            "notes": reply
        ]
        
        Alamofire.request(strURL, method: .post ,parameters: param ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : AddTicketCommentResponse = Mapper<AddTicketCommentResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func uploadAttachInTicket(url:String,parameters:[String:Any],fileUrl:URL,callback:@escaping (_ data:UpdateSettingResponse)->Void){
        
        let strURL = "\(serverURL)/\(url)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            do{
                let data = try Data(contentsOf: fileUrl)
                multipartFormData.append(data, withName: "attachments[0][file]", fileName: "\(Date.init().timeIntervalSince1970).\(fileUrl.pathExtension)", mimeType: fileUrl.mimeType())
            }catch{
                
            }
            
            for (key, value) in parameters {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
            }
            
        }, to: URL(string: strURL)!, method: .post , headers: headers) { (result:SessionManager.MultipartFormDataEncodingResult) in
            switch result{
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.responseJSON { (response:DataResponse<Any>) in
                    if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                        if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                            callback(parsedMapperString)
                        }
                    }
                }
            case .failure(let error):
                print("Error:",error.localizedDescription)
                break
            }
        }
        
    }
    
    func getDocuments(
        document_branch:String,
        document_number:String,
        searchText:String,
        pageNumber:String,
        callback:@escaping (_ data:DocumentsResponse)->Void){
            
            let strURL = "\(serverURL)/documents/get_data_documents/\(pageNumber)/10"
            let headers = [ "authorization":
                                "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
            let param:Parameters = ["document_name":searchText,
                                    "document_branch": document_branch,
                                    "document_number": document_number
            ]
            
            Alamofire.request(strURL, method: .post ,parameters: param,headers: headers).validate().responseJSON { (response) in
                if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                    if let parsedMapperString : DocumentsResponse = Mapper<DocumentsResponse>().map(JSONString:str){
                        callback(parsedMapperString)
                    }
                }
            }
        }
    
    func updateDocumentStatus(documentId:String,status:String, callback:@escaping (_ data:DocumentsResponse)-> Void){
        let strURL = "\(serverURL)/documents/update_document_status"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        let param = [
            "document_id":documentId,
            "status":status,
        ]
        
        Alamofire.request(strURL, method: .post ,parameters: param,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : DocumentsResponse = Mapper<DocumentsResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func deleteDocument(documentId:String, callback:@escaping (_ data:DocumentsResponse)-> Void){
        let strURL = "\(serverURL)/documents/delete_decument/\(documentId)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .post ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : DocumentsResponse = Mapper<DocumentsResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getDocAttchs(pageNumber:Int, document_id:String,callback:@escaping (_ data:DocAttachsResponse)->Void){
        let strURL = "\(serverURL)/documents/get_files_data_documents/\(pageNumber)/10"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        let param = ["document_id": document_id]
        Alamofire.request(strURL, method: .post,parameters: param ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : DocAttachsResponse = Mapper<DocAttachsResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getContractDetails(transactionId:String,callback:@escaping (_ data:NewContractDataResponse)->Void){
        
        let strURL = "\(serverURL)/form/FORM_CT1/vr/\(transactionId)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        Alamofire.request(strURL, method: .get ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : NewContractDataResponse = Mapper<NewContractDataResponse>().map(JSONString:str){
                    if parsedMapperString.error == "Token incorrect!" || parsedMapperString.error == "Signature verification failed"{
                        self.makeUserLogout()
                    }else{
                        callback(parsedMapperString)
                    }
                }
            }
        }
    }
    
    func getLoanFormData(transactionId:String,callback:@escaping (_ data:LoanFormResponse)->Void){
        
        let strURL = "\(serverURL)/form/FORM_HRLN1/vr/\(transactionId)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        Alamofire.request(strURL, method: .get ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : LoanFormResponse = Mapper<LoanFormResponse>().map(JSONString:str){
                    if parsedMapperString.error == "Token incorrect!" || parsedMapperString.error == "Signature verification failed"{
                        self.makeUserLogout()
                    }else{
                        callback(parsedMapperString)
                    }
                }
            }
        }
    }
    
    
    
    func getOverTimeFormData(transactionId:String,callback:@escaping (_ data:OverTimeFormResponse)->Void){
        let strURL = "\(serverURL)/form/FORM_OVR1/vr/\(transactionId)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        Alamofire.request(strURL, method: .get ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : OverTimeFormResponse = Mapper<OverTimeFormResponse>().map(JSONString:str){
                    if parsedMapperString.error == "Token incorrect!" || parsedMapperString.error == "Signature verification failed"{
                        self.makeUserLogout()
                    }else{
                        callback(parsedMapperString)
                    }
                }
            }
        }
    }
    
    
    func getBonusFormData(transactionId:String,callback:@escaping (_ data:BonusFormResponse)->Void){
        let strURL = "\(serverURL)/form/FORM_BNS1/vr/\(transactionId)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        Alamofire.request(strURL, method: .get ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : BonusFormResponse = Mapper<BonusFormResponse>().map(JSONString:str){
                    if parsedMapperString.error == "Token incorrect!" || parsedMapperString.error == "Signature verification failed"{
                        self.makeUserLogout()
                    }else{
                        callback(parsedMapperString)
                    }
                }
            }
        }
    }
    
    
    func getViolationFormData(transactionId:String,callback:@escaping (_ data:ViolationResponse)->Void){
        let strURL = "\(serverURL)/form/FORM_VOL1/vr/\(transactionId)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        Alamofire.request(strURL, method: .get ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : ViolationResponse = Mapper<ViolationResponse>().map(JSONString:str){
                    if parsedMapperString.error == "Token incorrect!" || parsedMapperString.error == "Signature verification failed"{
                        self.makeUserLogout()
                    }else{
                        callback(parsedMapperString)
                    }
                }
            }
        }
    }
    
    
    func getDeductionFormData(transactionId:String,callback:@escaping (_ data:DeductionResponse)->Void){
        let strURL = "\(serverURL)/form/FORM_DET1/vr/\(transactionId)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        Alamofire.request(strURL, method: .get ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : DeductionResponse = Mapper<DeductionResponse>().map(JSONString:str){
                    if parsedMapperString.error == "Token incorrect!" || parsedMapperString.error == "Signature verification failed"{
                        self.makeUserLogout()
                    }else{
                        callback(parsedMapperString)
                    }
                }
            }
        }
    }
    func getJobOfferFormData(transactionId:String,callback:@escaping (_ data:JobOfferResponse)->Void){
        let strURL = "\(serverURL)/form/FORM_JF/vr/\(transactionId)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        Alamofire.request(strURL, method: .get ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : JobOfferResponse = Mapper<JobOfferResponse>().map(JSONString:str){
                    if parsedMapperString.error == "Token incorrect!" || parsedMapperString.error == "Signature verification failed"{
                        self.makeUserLogout()
                    }else{
                        callback(parsedMapperString)
                    }
                }
            }
        }
    }
    
    func getSendCodeWays(callback:@escaping (_ data:SendCodeWaysResponse) -> Void){
        
        let strURL = "\(serverURL)/tc/sender/select"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .get ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : SendCodeWaysResponse = Mapper<SendCodeWaysResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func sendCodeForApproval(body:[String:Any],callback:@escaping (_ data:SettingsData) -> Void){
        
        let strURL = "\(serverURL)/tc/sender/send_code"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.request(strURL, method: .post,parameters: body ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : SettingsData = Mapper<SettingsData>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func deleteItemCheckList(param:[String:Any],callback: @escaping (_ data:SettingsData)->Void){
        
        let strURL = "\(serverURL)/tasks/delete_task_point"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post,parameters: param , headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                print("THE RESPONSE",str)
                if let parsedMapperString : SettingsData = Mapper<SettingsData>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func updateChecklistItem(param:[String:Any],callback: @escaping (_ data:SettingsData)->Void){
        
        let strURL = "\(serverURL)/tasks/update_task_points_all"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post,parameters: param , headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                print("THE RESPONSE",str)
                if let parsedMapperString : SettingsData = Mapper<SettingsData>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getCheckListItemFiles(sub_point_id:String,callback: @escaping (_ data:CheckListItemFile)->Void){
        let strURL = "\(serverURL)/tasks/get_files_in_sub_points"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post,parameters: ["sub_point_id":sub_point_id] , headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : CheckListItemFile = Mapper<CheckListItemFile>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getTimeLineForCheckListItem(sub_point_id:String,callback: @escaping (_ data:CheckListItemHistory)->Void){
        let strURL = "\(serverURL)/tasks/get_logs_in_sub_points"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post,parameters: ["sub_point_id":sub_point_id] , headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : CheckListItemHistory = Mapper<CheckListItemHistory>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getUsersForCheckListItem(sub_point_id:String,callback: @escaping (_ data:CheckListItemUsers)->Void){
        let strURL = "\(serverURL)/tasks/get_emp_in_sub_points"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post,parameters: ["sub_point_id":sub_point_id] , headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : CheckListItemUsers = Mapper<CheckListItemUsers>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    
    func updateCheckListTitle(pointId:String,title:String,callback:@escaping (_ data:AddTicketCommentResponse)->Void){
        let strURL = "\(serverURL)/tasks/update_task_point_main"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        let param = [
            "point_id": pointId,
            "title": title
        ]
        
        Alamofire.request(strURL, method: .post,parameters: param, headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : AddTicketCommentResponse = Mapper<AddTicketCommentResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func addCheckListItem(url:String,filesUrl:[URL?],parameters:[String:Any],callback:@escaping (_ data:AddTicketCommentResponse)->Void){
        let strURL = "\(serverURL)/\(url)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")" ]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            do{
                for i in 0..<filesUrl.count{
                    guard let fileUrl = filesUrl[i] else {
                        continue
                    }
                    
                    let data = try Data(contentsOf: fileUrl)
                    multipartFormData.append(data, withName: "attachments[\(i)][file]", fileName: "\(Date.init().timeIntervalSince1970).\(fileUrl.pathExtension)", mimeType: fileUrl.mimeType())
                }
            }catch{
                
            }
            
            for (key, value) in parameters {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
            }
            
        }, to: URL(string: strURL)!, method: .post , headers: headers) { (result:SessionManager.MultipartFormDataEncodingResult) in
            switch result{
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.responseJSON { (response:DataResponse<Any>) in
                    if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                        
                        if let parsedMapperString : AddTicketCommentResponse = Mapper<AddTicketCommentResponse>().map(JSONString:str){
                            callback(parsedMapperString)
                        }
                    }
                }
            case .failure(let error):
                print("Error:",error.localizedDescription)
                break
            }
        }
    }
    
    
    func startEndCheckListItem(point_id:String,callback:@escaping (_ data:AddTicketCommentResponse)->Void){
        let strURL = "\(serverURL)/tasks/start_end_timer_check"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post,parameters: ["point_id":point_id] , headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : AddTicketCommentResponse = Mapper<AddTicketCommentResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getHRContracts(pageNumber:String,searchKey:String,id:String,callback:@escaping (_ data:ContractsResponse)->Void){
        let strURL = "\(serverURL)/hrcontracts/\(pageNumber)/10?search_key=&id=\(id)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get, headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : ContractsResponse = Mapper<ContractsResponse>().map(JSONString:str){
                    
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getDashboardData(callback: @escaping (_ data:DashboardResponse)->Void){
        let strURL = "\(serverURL)/dashboard/employee_dashboard/"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get, headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : DashboardResponse = Mapper<DashboardResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getTemplets(projects_work_area_id:String,callback: @escaping (_ data:GetTemplateResponse)->Void){
        let strURL = "\(serverURL)/dashboard/get_templates?lang_key=\(L102Language.currentAppleLanguage())&projects_work_area_id=\(projects_work_area_id)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get, headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : GetTemplateResponse = Mapper<GetTemplateResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getGroupType(projects_work_area_id:String,templateId:String,callback: @escaping (_ data:GetGroupTypesResponse)->Void){
        let strURL = "\(serverURL)/dashboard/get_types?lang_key=\(L102Language.currentAppleLanguage())&projects_work_area_id=\(projects_work_area_id)&template_id=\(templateId)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get, headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : GetGroupTypesResponse = Mapper<GetGroupTypesResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getGroup1(projects_work_area_id:String,templateId:String,typeCodeSystem:String,callback: @escaping (_ data:GetGroupTypesResponse)->Void){
        let strURL = "\(serverURL)/dashboard/get_divisions?lang_key=\(L102Language.currentAppleLanguage())&projects_work_area_id=\(projects_work_area_id)&template_id=\(templateId)&type_code_system=\(typeCodeSystem)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get, headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : GetGroupTypesResponse = Mapper<GetGroupTypesResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
        
    }
    
    
    func getGroup2(projects_work_area_id:String,templateId:String,typeCodeSystem:String,group1CodeSystem:String,callback: @escaping (_ data:GetGroupTypesResponse)->Void){
        let strURL = "\(serverURL)/dashboard/get_group2?lang_key=\(L102Language.currentAppleLanguage())&projects_work_area_id=\(projects_work_area_id)&template_id=\(templateId)&type_code_system=\(typeCodeSystem)&group1_code_system=\(group1CodeSystem)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get, headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : GetGroupTypesResponse = Mapper<GetGroupTypesResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getTemplatesResult(projects_work_area_id:String,search_key:String,templateId:String,typeCodeSystem:String,group1CodeSystem:String,group2CodeSystem:String,callback: @escaping (_ data:GetGroupTypesResponse)->Void){
        let strURL = "\(serverURL)/dashboard/get_platforms?search_key=\(search_key)&lang_key=\(L102Language.currentAppleLanguage())&projects_work_area_id=\(projects_work_area_id)&group1_code_system=\(group1CodeSystem)&type_code_system=\(typeCodeSystem)&group2_code_system=\(group2CodeSystem)&template_id=\(templateId)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get, headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : GetGroupTypesResponse = Mapper<GetGroupTypesResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getActivityOnDate(date:Date,callback: @escaping (_ data:DateActivityResponse)->Void){
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "en")
        dateFormatter.dateFormat = "YYYY"
        let year = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "MM"
        let month = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "dd"
        let day = dateFormatter.string(from: date)
        
        
        let strURL = "\(serverURL)/at/getnewreport/1/1000?from_year=\(year)&from_month=\(month)&from_day=\(day)&to_year=\(year)&to_month=\(month)&to_day=\(day)&employee_number[]=\(Auth_User.user_id)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get, headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : DateActivityResponse = Mapper<DateActivityResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getProjectWorkingAreas(callback: @escaping (_ data:ProjectWorkingAreaResponse)->Void){
        
        let strURL = "\(serverURL)/dashboard/get_workarea?lang_key=en&wsearch_key=&projects_work_area_id="
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get, headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : ProjectWorkingAreaResponse = Mapper<ProjectWorkingAreaResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getProjectRequestsData(projects_work_area_id:String,callback: @escaping (_ data:ProjectRequestsData) -> Void ){
        
        let strURL = "\(serverURL)/pr/dashboard_counts/1/1"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        let body = ["projects_work_area_id": projects_work_area_id]
        
        Alamofire.request(strURL, method: .post ,parameters: body ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : ProjectRequestsData = Mapper<ProjectRequestsData>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getProgressPlanedRatioData(projects_work_area_id:String,callback: @escaping (_ data:ProgressPlanedRatioData) -> Void ){
        let strURL = "\(serverURL)/pr/plan_results/1/1"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        let body = ["projects_work_area_id": projects_work_area_id]
        
        Alamofire.request(strURL, method: .post ,parameters: body ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : ProgressPlanedRatioData = Mapper<ProgressPlanedRatioData>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getProjectRequestData(body:[String:Any],pageNumber:String,callback: @escaping (_ data:ProjectRequestData) -> Void ){
        let strURL = "\(serverURL)/pr/get_qtp_for_user/\(pageNumber)/10"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post ,parameters: body ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : ProjectRequestData = Mapper<ProjectRequestData>().map(JSONString:str){
                    
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getDivision(projects_work_area_id:String,templateId:String,required_type:String,group1:String,type:String,callback: @escaping (_ data:GetGroupTypesResponse)->Void){
        
        let strURL = "\(serverURL)/pforms/get_group1_type_group2?projects_work_area_id=\(projects_work_area_id)&template_id=\(templateId)&required_type=\(required_type)&group1=\(group1)&type=\(type)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get, headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : GetGroupTypesResponse = Mapper<GetGroupTypesResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
        
    }
    
    
    func getZones(phase_parent_id:String,projects_work_area_id:String,callback: @escaping (_ data:GetZonesResponse)->Void){
        
        let strURL = "\(serverURL)/joYF29rbEi/\(projects_work_area_id)/\(projects_work_area_id)?phase_parent_id=\(phase_parent_id)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get, headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : GetZonesResponse = Mapper<GetZonesResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getLevelKeys(callback: @escaping (_ data:GetGroupTypesResponse)->Void){
        
        let strURL = "\(serverURL)/lpworklevel?lang_key=\(L102Language.currentAppleLanguage())"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        Alamofire.request(strURL, method: .get ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : GetGroupTypesResponse = Mapper<GetGroupTypesResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getTopCountRequests(projects_work_area_id:String,limit:String,callback: @escaping (_ data:TopCountRequestsResponse)->Void){
        let strURL = "\(serverURL)/pr/get_top_count_requests"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        let body = [
            "projects_work_area_id": projects_work_area_id,
            "limit": limit
        ]
        
        Alamofire.request(strURL, method: .post ,parameters: body,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : TopCountRequestsResponse = Mapper<TopCountRequestsResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getUsedUnusedReport(body:[String:Any],limit:String,callback: @escaping (_ data:UsedUnusedReportResponse)->Void){
        let strURL = "\(serverURL)/pr/get_used_unused_requests/1/\(limit)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post ,parameters: body,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UsedUnusedReportResponse = Mapper<UsedUnusedReportResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getLateContractCount(projects_work_area_id:String,callback: @escaping (_ data:LateContractResponse)->Void){
        let strURL = "\(serverURL)/pr/get_count_wir_late_contractor"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post ,parameters: ["projects_work_area_id":projects_work_area_id],headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : LateContractResponse = Mapper<LateContractResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getCalenderData(param:[String:Any],callback: @escaping (_ data:CalenderActivityResponse)->Void){
        let strURL = "\(serverURL)/at/getnewreport/1/1000"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get ,parameters: param,encoding: URLEncoding.queryString,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : CalenderActivityResponse = Mapper<CalenderActivityResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getViolations(param:[String:Any],callback: @escaping (_ data:ViolationsResponse)->Void){
        let strURL = "\(serverURL)/at/getViolations/1/10"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get ,parameters: param,encoding: URLEncoding.queryString,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : ViolationsResponse = Mapper<ViolationsResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func createViolation(body:[String:Any],callback: @escaping (_ data:ViolationsResponse)->Void){
        let strURL = "\(serverURL)/form/FORM_VOL1/amv/"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post ,parameters: body ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : ViolationsResponse = Mapper<ViolationsResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func cancelViolation(body:[String:Any],callback: @escaping (_ data:ViolationsResponse)->Void){
        let strURL = "\(serverURL)/form/FORM_VOL1/cancelViolation/"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post ,parameters: body ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : ViolationsResponse = Mapper<ViolationsResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func openDetailsViolation(body:[String:Any],callback: @escaping (_ data:ViolationsResponse)->Void){
        let strURL = "\(serverURL)/at/attendance_detaile"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post ,parameters: body ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : ViolationsResponse = Mapper<ViolationsResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func ratioWeekViolation(body:[String:Any],callback: @escaping (_ data:RatioWeekResponse)->Void){
        let strURL = "\(serverURL)/at/ratio_week"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post ,parameters: body ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : RatioWeekResponse = Mapper<RatioWeekResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func ratioMonthViolation(body:[String:Any],callback: @escaping (_ data:RatioWeekResponse)->Void){
        let strURL = "\(serverURL)/at/ratio_month"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post ,parameters: body ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : RatioWeekResponse = Mapper<RatioWeekResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getMailsInbox(pageNumber:String,callback: @escaping (_ data:  MailInboxResponse)->Void){
        let strURL = "\(serverURL)/users/email/mailbox/\(pageNumber)/10"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post , headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                print(str)
                if let parsedMapperString : MailInboxResponse = Mapper<MailInboxResponse>().map(JSONString:str){
                    if parsedMapperString.error == "Token incorrect!" || parsedMapperString.error == "Signature verification failed"{
                        self.makeUserLogout()
                    }else{
                        callback(parsedMapperString)
                    }
                }
            }
        }
    }
    
    
    func getAttendanceGroups(pageNumber:String,callback: @escaping (_ data:GetAttendanceGroupsResponse)->Void){
        let strURL = "\(serverURL)/at/get_groups/\(pageNumber)/10"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get , headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : GetAttendanceGroupsResponse = Mapper<GetAttendanceGroupsResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getUpdateAttendanceGroupsData(groupId:String,callback: @escaping (_ data:GetAttendanceGroupsResponse)->Void){
        let strURL = "\(serverURL)/at/get_groups/1/10?search_key=&group_id=\(groupId)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get , headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : GetAttendanceGroupsResponse = Mapper<GetAttendanceGroupsResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func updateAttendanceGroupsData(url:String,body:[String:Any],callback: @escaping (_ data:UpdateSettingResponse)->Void){
        let strURL = "\(serverURL)\(url)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post ,parameters: body ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func deleteAttendanceGroupsData(groupId:String,callback: @escaping (_ data:UpdateSettingResponse)->Void){
        let strURL = "\(serverURL)/at/delete_groups"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post ,parameters: ["key_ids[]":groupId] ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func updateStatusAttendance(status:String,
                                userId:String,
                                date:String,
                                callback: @escaping (_ data:UpdateSettingResponse)->Void
    ){
        let strURL = "\(serverURL)/at/update_employee_status"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        let body:[String:Any] = [
            "state":status,
            "user_id":userId,
            "date":date
        ]
        
        Alamofire.request(strURL, method: .post ,parameters: body ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getShiftsAttendance(pageNumber:String,
                             callback: @escaping (_ data:GetShiftsResponse)->Void
    ){
        let strURL = "\(serverURL)/at/get_shifts/\(pageNumber)/10"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        
        Alamofire.request(strURL, method: .get ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : GetShiftsResponse = Mapper<GetShiftsResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getShiftsGroups(callback: @escaping (_ data:SearchBranch)->Void){
        let strURL = "\(serverURL)/at/groups?lang_key=\(L102Language.currentAppleLanguage())"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : SearchBranch = Mapper<SearchBranch>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
        
    }
    
    func createShiftGroups(url:String,body:[String:Any],callback: @escaping (_ data:UpdateSettingResponse)->Void){
        
        let strURL = "\(serverURL)\(url)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post, parameters: body ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func deleteShiftGroups(deleteId:String,callback: @escaping (_ data:UpdateSettingResponse)->Void){
        
        let strURL = "\(serverURL)/at/delete_shifts"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post, parameters: ["key_ids[]":deleteId] ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func changePassword(body:[String:Any],callback: @escaping (_ data:UpdateSettingResponse)->Void){
        
        let strURL = "\(serverURL)/cpassword"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        
        Alamofire.request(strURL, method: .post, parameters: body ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getJoiningDetails(pageNumber:String,empNum:String,callback: @escaping (_ data:JoiningDetailsResponse)->Void){
        
        let strURL = "\(serverURL)/human_resources/get_employee_joining_history/\(pageNumber)/10"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        
        Alamofire.request(strURL, method: .post, parameters: ["employee_number":empNum] ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : JoiningDetailsResponse = Mapper<JoiningDetailsResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getJobDetails(pageNumber:String,branch_id:String,empNum:String,searchKey:String,callback: @escaping (_ data:JobDetailsResponse)->Void){
        
        let strURL = "\(serverURL)/positions/\(pageNumber)/10"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        let body = ["branch_id":branch_id , "id": empNum, "searchKey": searchKey]
        
        Alamofire.request(strURL, method: .post, parameters: body,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : JobDetailsResponse = Mapper<JobDetailsResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
        
    }
    
    
    func getPayRoleData(pageNumber:String,callback: @escaping (_ data:PayRoleResponse)->Void){
        
        let strURL = "\(serverURL)/form/FORM_SAL/salary_history/\(pageNumber)/10"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        
        Alamofire.request(strURL, method: .post ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : PayRoleResponse = Mapper<PayRoleResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
        
    }
    
    func getPayRoleReviewersData(callback: @escaping (_ data:PayRoleReviewersResponse)->Void){
        
        let strURL = "\(serverURL)/form/FORM_SAL/get_all_reviewers"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        
        Alamofire.request(strURL, method: .get ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : PayRoleReviewersResponse = Mapper<PayRoleReviewersResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
        
    }
    
    
    func addPayRoleReviewers(body:Parameters,callback: @escaping (_ data:UpdateSettingResponse)->Void){
        
        let strURL = "\(serverURL)/form/FORM_SAL/store_employees_as_reviewers"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        
        Alamofire.request(strURL, method: .post,parameters: body ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
        
    }
    
    
    func deletePayRoleReviewers(userId:String,callback: @escaping (_ data:UpdateSettingResponse)->Void){
        
        let strURL = "\(serverURL)/form/FORM_SAL/delete_reviewer/\(userId)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        
        Alamofire.request(strURL, method: .delete,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
        
    }
    
    
    func getFinanialDetailsData(pageNumber:String,body:Parameters,callback: @escaping (_ data:FinanialDetailsResponse)->Void){
        
        let strURL = "\(serverURL)/human_resources/get_employee_finical_history/\(pageNumber)/10"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        
        Alamofire.request(strURL, method: .post,parameters: body,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : FinanialDetailsResponse = Mapper<FinanialDetailsResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
        
    }
    
    /// Get Current Version of the app from the app store
    func getCurrentVersion(callback: @escaping (_ data:AppStoreAppResponse)->Void){
        guard
            //            let info = Bundle.main.infoDictionary,
            //              let identifier = info["CFBundleIdentifier"] as? String,
            let url = URL(string: "https://itunes.apple.com/lookup?id=1621889347&type=\(UUID().uuidString)") else {
            return
        }
        
        Alamofire.request(url, method: .get).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : AppStoreAppResponse = Mapper<AppStoreAppResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
        
    }
    
    func getJobAppData(pageNumber:String,body:Parameters,callback: @escaping (_ data:JobAppResponse)->Void){
        
        let strURL = "\(serverURL)/human_resources/get_job_applications/\(pageNumber)/10"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        
        Alamofire.request(strURL, method: .post,parameters: body,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : JobAppResponse = Mapper<JobAppResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func deleteJobAppRecord(userId:String,callback: @escaping (_ data:UpdateSettingResponse)->Void){
        
        let strURL = "\(serverURL)/81f5cc8c046c6d1c66fa3424783873db/MAIN"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        let param = ["key_ids[]":userId]
        
        Alamofire.request(strURL, method: .delete,parameters: param,encoding: URLEncoding.httpBody,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getProjectDetailsData(projectId:String,callback: @escaping (_ data:ProjectDetilasResponse)->Void){
        let strURL = "\(serverURL)/TEd1bgyHSC0GPcq/\(projectId)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : ProjectDetilasResponse = Mapper<ProjectDetilasResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getQuotationsSupervisionData(projectId:String,pageNumber:String,searchKey:String,callback: @escaping (_ data:QuotationResponse)->Void){
        let strURL = "\(serverURL)/squotest/\(projectId)/\(pageNumber)/10?search_key=\(searchKey)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : QuotationResponse = Mapper<QuotationResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getProjectsSupervisionData(projectId:String,pageNumber:String,searchKey:String,callback: @escaping (_ data:ProjectServicesResponse)->Void){
        let strURL = "\(serverURL)/xZLCctvSvZ9DGb8/\(projectId)/\(pageNumber)/10?search_key=\(searchKey)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : ProjectServicesResponse = Mapper<ProjectServicesResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getProjectsDesignData(projectId:String,pageNumber:String,callback: @escaping (_ data: ProjectsDesignResponse)->Void){
        let strURL = "\(serverURL)/project_design/get_data_projects_design/\(pageNumber)/10"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        let param = [
            "projects_profile_id": projectId
        ]
        
        Alamofire.request(strURL, method: .post,parameters: param,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : ProjectsDesignResponse = Mapper<ProjectsDesignResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getCommunicationList(pageNumber:String,searchText:String,moduleKey:String,transactionKey:String,branchKey:String,typeKey:String,callback: @escaping (_ data: CommunicationListResponse )->Void){
        
        let strURL = "\(serverURL)/comm/list/\(pageNumber)/10?searchKey=\(searchText)&module_key=\(moduleKey)&transaction_key=\(transactionKey)&branch_id=\(branchKey)&communication_types_id=\(typeKey)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : CommunicationListResponse = Mapper<CommunicationListResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getCommunctionSearchKeys(urlKey:String,callback: @escaping (_ data: SearchBranch )->Void){
        let strURL = "\(serverURL)/comm/\(urlKey)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : SearchBranch = Mapper<SearchBranch>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getC1FormData(transactionId:String,callback: @escaping (_ data:C1FormResponse)->Void){
        
        let strURL = "\(serverURL)/form/FORM_C1/vr/\(transactionId)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : C1FormResponse = Mapper<C1FormResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getC2FormData(transactionId:String,callback: @escaping (_ data:C2FormResponse)->Void){
        
        let strURL = "\(serverURL)/form/FORM_C2/vr/\(transactionId)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        
        Alamofire.request(strURL, method: .get ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : C2FormResponse = Mapper<C2FormResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func deleteCForm(formType:String,transactionId:String,callback: @escaping (_ data:UpdateSettingResponse)->Void){
        
        let strURL = "\(serverURL)/form/\(formType)/dr"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        let param = [
            "transaction_request_id": transactionId
        ]
        
        Alamofire.request(strURL, method: .post,parameters: param ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func doVerification(param:[String:Any],callback:@escaping (_ data:UpdateSettingResponse) -> Void){
        let strURL = "\(serverURL)/tc/sender/complete_action"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post,parameters: param ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func approveCForm(formType:String,transactionId:String,user_pass:String,callback:@escaping (_ data:UpdateSettingResponse) -> Void){
        let strURL = "\(serverURL)/form/\(formType)/cm"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        let param = [
            "transaction_request_id": transactionId,
            "user_pass":user_pass
        ]
        Alamofire.request(strURL, method: .post,parameters: param ,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getAccountSettingsOptions(callback:@escaping (_ data:AccountSettingsOptions) -> Void){
        let strURL = "\(serverURL)/ab/accounts_view"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : AccountSettingsOptions = Mapper<AccountSettingsOptions>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getAccountFinancialOptions(branch_id:String,callback:@escaping (_ data:AccountFinancialOptions) -> Void){
        let strURL = "\(serverURL)/financial/\(branch_id)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : AccountFinancialOptions = Mapper<AccountFinancialOptions>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getAccountGroups(callback:@escaping (_ data:SearchBranch) -> Void){
        let strURL = "\(serverURL)/acgroups"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : SearchBranch = Mapper<SearchBranch>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getAccountUsers(branch_id:String,callback:@escaping (_ data:SearchBranch) -> Void){
        let strURL = "\(serverURL)/acusers/\(branch_id)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : SearchBranch = Mapper<SearchBranch>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getPermissionMentions(
        pageNumber:String,
        branch_id:String,
        group_key:String,
        user_id:String,
        callback:@escaping (_ data:PermissionMentions) -> Void
    ){
        
        let strURL = "\(serverURL)/acpermission_mentions/\(pageNumber)/10"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        let param:[String:Any] = [
            "search[branch_id]":branch_id,
            "search[group_key]":group_key,
            "search[user_id]":user_id
        ]
        Alamofire.request(strURL, method: .post,parameters: param,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : PermissionMentions = Mapper<PermissionMentions>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getAccountSettings(
        pageNumber:String,
        branch_id:String,
        search_key:String,
        search_type:String,
        callback:@escaping (_ data:AccountSettingsData) -> Void
    ){
        
        let strURL = "\(serverURL)/ls/\(branch_id)/\(pageNumber)/10"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        let param:[String:Any] = [
            "search_key":search_key,
            "search_type":search_type
        ]
        
        Alamofire.request(strURL, method: .post,parameters: param,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : AccountSettingsData = Mapper<AccountSettingsData>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getAccountSearchType(callback:@escaping (_ data:SearchBranch) -> Void){
        let strURL = "\(serverURL)/at"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : SearchBranch = Mapper<SearchBranch>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func sendMail(subject:String,to:String,from:String,body:String,callback:@escaping (_ data:SearchBranch) -> Void){
        let strURL = "\(serverURL)/tasks/send_mail"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        let param = [
            "subject":subject,
            "to": to,
            "from":from,
            "body":body
        ]
        Alamofire.request(strURL, method: .post,parameters: param,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : SearchBranch = Mapper<SearchBranch>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getAccountTaxsData(branch_id:String,callback:@escaping (_ data:AccountTaxs) -> Void){
        let strURL = "\(serverURL)/gts/\(branch_id)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                print("ERERER",str)
                if let parsedMapperString : AccountTaxs = Mapper<AccountTaxs>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func updateAccountTaxSettings(branch_id:String,
                                  item_tax:String,
                                  global_tax:String,
                                  item_discount:String,
                                  global_discount:String,
                                  callback:@escaping (_ data:UpdateSettingResponse) -> Void){
        let strURL = "\(serverURL)/ts"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        let param = [
            "branch_id":branch_id,
            "item_tax":item_tax,
            "global_tax":global_tax,
            "item_discount":item_discount,
            "global_discount":global_discount
        ]
        
        Alamofire.request(strURL, method: .post,parameters: param,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                print("ERERER",str)
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getInvoiceSettingsData(branch_id:String,
                                search_key:String,
                                invoice_type:String,
                                finance_id:String,
                                callback:@escaping (_ data:InvoiceSettings) -> Void){
        let strURL = "\(serverURL)/invlists/\(branch_id)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        let param = [
            "search_key":search_key,
            "invoice_type":invoice_type,
            "finance_id":finance_id
        ]
        
        Alamofire.request(strURL, method: .post,parameters: param,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : InvoiceSettings = Mapper<InvoiceSettings>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getFinancialYearData(branch_id:String,
                              callback:@escaping (_ data:FinancialYearData) -> Void){
        let strURL = "\(serverURL)/financial/\(branch_id)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                print(str)
                
                if let parsedMapperString : FinancialYearData = Mapper<FinancialYearData>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getBlockAccountsData(branch_id:String,
                              finance_id:String,
                              pageNumber:String,
                              callback:@escaping (_ data:BlockAccountsResponse) -> Void){
        let strURL = "\(serverURL)/acc/getblocksystems/\(pageNumber)/10?branch_id=\(branch_id)&finance_id=\(finance_id)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : BlockAccountsResponse = Mapper<BlockAccountsResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getCostCentersData(branch_id:String,
                            callback:@escaping (_ data:CostCentersResponse) -> Void){
        let strURL = "\(serverURL)/cclist/\(branch_id)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : CostCentersResponse = Mapper<CostCentersResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func addCostCenters(body:[String:Any],
                        callback:@escaping (_ data:UpdateSettingResponse) -> Void){
        let strURL = "\(serverURL)/cccreate"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post,parameters: body,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func deleteCostCenters(branch_id:String,record_id:String,callback:@escaping (_ data:UpdateSettingResponse) -> Void){
        let strURL = "\(serverURL)/ccdelete/\(branch_id)/\(record_id)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .delete,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func updateCostCenters(param:[String:Any],record_id:String,callback:@escaping (_ data:UpdateSettingResponse) -> Void){
        let strURL = "\(serverURL)/ccupdate/\(record_id)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .put,parameters: param,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getAccountMasters(branch_id:String,finance_id:String,callback:@escaping (_ data:AccountMastersResponse) -> Void){
        let strURL = "\(serverURL)/amlist/1?finance_id=\(finance_id)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : AccountMastersResponse = Mapper<AccountMastersResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getCurrencies(branch_id:String,callback:@escaping (_ data:SearchBranch) -> Void){
        let strURL = "\(serverURL)/currencies"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post,parameters: ["branch_id":branch_id],headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : SearchBranch = Mapper<SearchBranch>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getAccountTypes(branch_id:String,callback:@escaping (_ data:AccountTypesResponse) -> Void){
        let strURL = "\(serverURL)/actypes"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post,parameters: ["branch_id":branch_id],headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : AccountTypesResponse = Mapper<AccountTypesResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getBalanceSheetGroups(branch_id:String,account_type:String,callback:@escaping (_ data:SearchBranch) -> Void){
        let strURL = "\(serverURL)/bsheets"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        let param:Parameters = ["branch_id":branch_id,"account_type":account_type]
        
        Alamofire.request(strURL, method: .post,parameters: param,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : SearchBranch = Mapper<SearchBranch>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func addAccountMaster(url:String,body:[String:Any],callback:@escaping (_ data:UpdateSettingResponse) -> Void){
        let strURL = "\(serverURL)\(url)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post,parameters: body,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func searchForCostCenter(branch_id:String,search_text:String,callback:@escaping (_ data:SearchBranch) -> Void){
        let strURL = "\(serverURL)/cctransactions"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        let body = ["branch_id": branch_id,
                    "search_text": search_text
        ]
        
        Alamofire.request(strURL, method: .post,parameters: body,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : SearchBranch = Mapper<SearchBranch>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getAccountManagerEditData(branch_id:String,accountMasterId:String,callback:@escaping (_ data:AccountManagerData) -> Void){
        let strURL = "\(serverURL)/amview/\(branch_id)/\(accountMasterId)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : AccountManagerData = Mapper<AccountManagerData>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func deleteAccountMaster(branch_id:String,accountMasterId:String,callback:@escaping (_ data:UpdateSettingResponse) -> Void){
        let strURL = "\(serverURL)/amdelete/\(branch_id)/\(accountMasterId)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .delete,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getOpeningBalanceData(branch_id:String,finance_id:String,search_key:String,callback:@escaping (_ data:OpeningBalanceData) -> Void){
        let strURL = "\(serverURL)/accounts/get_accounts_for_opening/\(branch_id)/\(finance_id)?search_key=\(search_key)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : OpeningBalanceData = Mapper<OpeningBalanceData>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getReceipts(url:String,finance_id:String,search_key:String,callback:@escaping (_ data:ReceiptsResponse) -> Void){
        
        let strURL = "\(serverURL)\(url)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        let body = [
            "search_key": search_key,
            "finance_id": finance_id
        ]
        
        Alamofire.request(strURL, method: .post,parameters: body,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : ReceiptsResponse = Mapper<ReceiptsResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func searchForCardAccount(branch_id:String,finance_id:String,search_text:String,callback:@escaping (_ data:SearchBranch) -> Void){
        
        let strURL = "\(serverURL)/sam/accounts_add"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        let body = [
            "search_text": search_text,
            "finance_id": finance_id,
            "branch_id": branch_id
        ]
        
        Alamofire.request(strURL, method: .post,parameters: body,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : SearchBranch = Mapper<SearchBranch>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getAccounts(branch_id:String,status:String,callback:@escaping (_ data:SearchBranch) -> Void){
        
        let strURL = "\(serverURL)/cctransactions"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        let body = [
            "status": status,
            "branch_id": branch_id
        ]
        
        Alamofire.request(strURL, method: .post,parameters: body,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : SearchBranch = Mapper<SearchBranch>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func createReceipt(body:[String:Any],callback:@escaping (_ data:UpdateSettingResponse) -> Void){
        
        let strURL = "\(serverURL)/reccreate"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post,parameters: body,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    
    
    func createReceipt(requestUrl:String,fileUrl:URL?,body:[String:Any],callback:@escaping (_ data:UpdateSettingResponse) -> Void){
        let strURL = "\(serverURL)\(requestUrl)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            if let fileUrl = fileUrl{
                do {
                    let file = try Data(contentsOf: fileUrl)
                    multipartFormData.append( file as Data, withName: "payment_receipt_attachment", fileName: "\(Date.init().timeIntervalSince1970).\(fileUrl.pathExtension)", mimeType: "text/\(fileUrl.pathExtension)")
                    
                } catch {
                    debugPrint("Couldn't get Data from URL: \(error)")
                }
            }
            
            for (key, value) in body {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
            }
            
        },
                         to: URL(string: strURL)!, method: .post , headers: headers) { (result:SessionManager.MultipartFormDataEncodingResult) in
            switch result{
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.responseJSON { (response:DataResponse<Any>) in
                    if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                        if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                            callback(parsedMapperString)
                        }
                    }
                }
            case .failure(let error):
                print("Error:",error.localizedDescription)
                break
                
            }
        }
    }
    
    func viewReceipt(url:String,callback:@escaping (_ data:ViewReceiptData) -> Void){
        
        let strURL = "\(serverURL)\(url)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : ViewReceiptData = Mapper<ViewReceiptData>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func editReceipt(url:String,callback:@escaping (_ data:ViewReceiptData) -> Void){
        
        let strURL = "\(serverURL)\(url)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : ViewReceiptData = Mapper<ViewReceiptData>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func exportFile(url:String,callback:@escaping (_ data:GetImageResponse) -> Void){
        
        let strURL = "\(serverURL)\(url)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : GetImageResponse = Mapper<GetImageResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func createJournalVoucher(journal_voucher_id:String,isEdit:Bool,body:[String:Any],callback:@escaping (_ data:UpdateSettingResponse) -> Void){
        
        let strURL = "\(serverURL)/\(isEdit ? "updatejournal/\(journal_voucher_id)": "createjournal")"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")",
                        "Accept": "application/json"
        ]
        
        Alamofire.request(strURL, method: isEdit ? .put : .post,parameters: body,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : UpdateSettingResponse = Mapper<UpdateSettingResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getAllJournalVoucher(branchId:String,finance_id:String,searchKey:String,pageNumber:String,callback:@escaping (_ data:AllJournalVoucher) -> Void){
        
        let strURL = "\(serverURL)/listjournal/\(branchId)/\(pageNumber)/10"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        let body:[String:Any] = [
            "search_key":searchKey,
            "finance_id":finance_id
        ]
        
        Alamofire.request(strURL, method: .post,parameters: body,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : AllJournalVoucher = Mapper<AllJournalVoucher>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func viewJournalVoucherData(journalVoucherId:String,branchId:String,finance_id:String,callback:@escaping (_ data:ViewJournalVoucher) -> Void){
        
        let strURL = "\(serverURL)/viewjournal/\(branchId)/\(journalVoucherId)?finance_id=\(finance_id)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : ViewJournalVoucher = Mapper<ViewJournalVoucher>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getReceiptCostCenters(transactionId:String,receiptId:String,transactionHistoryId:String,callback:@escaping (_ data:ReceiptCostCenterResponse) -> Void){
        
        let strURL = "\(serverURL)/acc/get_cost_center_transactions/\(transactionId)/\(receiptId)/\(transactionHistoryId)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : ReceiptCostCenterResponse = Mapper<ReceiptCostCenterResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getEditJournalVoucherData(journal_voucher_id:String,branch_id:String,callback:@escaping (_ data:AllJournalVoucher) -> Void){
        let strURL = "\(serverURL)/editjournal/\(branch_id)/\(journal_voucher_id)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : AllJournalVoucher = Mapper<AllJournalVoucher>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getSellingInvoices(isPurchase:Bool,pageNumber:String,search_key:String,finance_id:String,branch_id:String,callback:@escaping (_ data:SellingInvoicesResponse) -> Void){
        let strURL = "\(serverURL)/\(isPurchase ? "listpinvoice" : "listsinvoice")/\(branch_id)/\(pageNumber)/10"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        let body = [
            "search_key":search_key,
            "finance_id":finance_id
        ]
        
        Alamofire.request(strURL, method: .post,parameters: body,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : SellingInvoicesResponse = Mapper<SellingInvoicesResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getAccountHistory(body:[String:Any],pageNumber:String,callback:@escaping (_ data:AccountHistoryResponse) -> Void){
        let strURL = "\(serverURL)/get_accounts_history_log/\(pageNumber)/10"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post,parameters: body,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : AccountHistoryResponse = Mapper<AccountHistoryResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getTransactionViewerData(branch_id:String,numberFilter:String,search_key:String,finance_id:String,callback:@escaping (_ data:TransactionViewerResponse) -> Void){
        let strURL = "\(serverURL)/tviewer/\(branch_id)/\(numberFilter)?search_key=\(search_key)&finance_id=\(finance_id)"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .get,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : TransactionViewerResponse = Mapper<TransactionViewerResponse>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func searchForAccount(body:[String:Any],callback:@escaping (_ data:SearchBranch) -> Void){
        
        let strURL = "\(serverURL)/sam/accounts_view"
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        
        Alamofire.request(strURL, method: .post,parameters: body,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : SearchBranch = Mapper<SearchBranch>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getStatementAccountsData(url:String,body:[String:Any],callback:@escaping (_ data:StatementAccountsData<StatementAccountsRecord>) -> Void){
        
        let strURL = "\(serverURL)/\(url)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post,parameters: body,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : StatementAccountsData<StatementAccountsRecord> = Mapper<StatementAccountsData<StatementAccountsRecord>>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getStatementAccountsData(url:String,body:[String:Any],callback:@escaping (_ data:StatementAccountsData<GeneralLedgerRecord>) -> Void){
        
        let strURL = "\(serverURL)/\(url)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post,parameters: body,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : StatementAccountsData<GeneralLedgerRecord> = Mapper<StatementAccountsData<GeneralLedgerRecord>>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    
    func getAccountsTrialData(url:String,body:[String:Any],callback:@escaping (_ data:StatementAccountsData<GeneralLedgerRecord>) -> Void){
        let strURL = "\(serverURL)/\(url)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post,parameters: body,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : StatementAccountsData<GeneralLedgerRecord> = Mapper<StatementAccountsData<GeneralLedgerRecord>>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }

    func getBalanceSheetsData(url:String,body:[String:Any],callback:@escaping (_ data:BalanceSheetsData?) -> Void){
        let strURL = "\(serverURL)/\(url)"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post,parameters: body,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                if let parsedMapperString : BalanceSheetsData = Mapper<BalanceSheetsData>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
    
    func getTransactionList(body:[String:Any],callback:@escaping (_ data:TransactionListData?) -> Void){
        let strURL = "\(serverURL)/transactionlistings"
        
        let headers = [ "authorization":
                            "\(NewSuccessModel.getLoginSuccessToken() ?? "nil")"
        ]
        
        Alamofire.request(strURL, method: .post,parameters: body,headers: headers).validate().responseJSON { (response) in
            if let data  = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : TransactionListData = Mapper<TransactionListData>().map(JSONString:str){
                    callback(parsedMapperString)
                }
            }
        }
    }
}

