//
//  NewSuccessModel.swift
//  Almnabr
//
//  Created by MacBook on 23/09/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//


import UIKit
import ObjectMapper
import SwiftKeychainWrapper

@objc class NewSuccessModel: NSObject, Mappable {
    var token: String?
    var message: String?
    var error: String?

    var id: Int?
    
    var working_days: [String]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        token <- map["access_token"]
        id <- map["id"]
        
        working_days <- map["working_days"]
        
        message <- map["message"]

        error <- map["error"]

    }
    /*
    func mapping(map: Map) {
        status <- map["status"]
        token <- map["token"]
        user_info <- map["user_info"]
        projectList <- map["projects"]
        id <- map["id"]
        
        vacationsList <- map["items"]
        working_days <- map["working_days"]
        
        message <- map["message"]

        error <- map["error"]

    }
    */
    static func saveLoginSuccessToken(userToken: String) {
        let saveSuccessfully = KeychainWrapper.standard.set(userToken, forKey: Constants.DEFINELOGINSUCCESSTOKEN)
        if saveSuccessfully == false {
            print("User Data not stored")
        } else {
            print("User Data stored successfully")
        }
    }
    
    @objc static func getLoginSuccessToken() -> String? {
        if let userObject = KeychainWrapper.standard.string(forKey: Constants.DEFINELOGINSUCCESSTOKEN) {
            return userObject
        }
        return nil
    }
    
    static func removeLoginSuccessToken() {
        let removedObject = KeychainWrapper.standard.removeObject(forKey: Constants.DEFINELOGINSUCCESSTOKEN)
        if  removedObject == false {
            print("User Data not removed")
        } else {
            print("User Data removed successfully")
        }
    }
}
