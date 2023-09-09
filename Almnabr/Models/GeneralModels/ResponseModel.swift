//
//  ResponseModel.swift
//  Almnabr
//
//  Created by MacBook on 22/09/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import ObjectMapper

class ResponseModel: Mappable {
    var code: String?
    var status: Bool?
    var message: String?
    var msg: String?
    var error: String?
    var user_data: UserDataModel?
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        status <- map["status"]
        message <- map["message"]
        msg <- map["msg"]
        error <- map["error"]
        user_data <- map["user_data"]
        

    }
}


class UserDataModel: Mappable {
    var user_id: String?
    var user_username: String?
    var user_email: String?
    var user_phone: String?
    var user_type_id: String?
    var user_old_pass: String?
    var user_status: String?
    var is_admin: String?
    var theme_color: String?
    var user_active_status: String?
    var user_reset_link: String?
    var user_reset_link_datetime: String?
    var user_token_id: String?
    var user_token_plat_forms: String?
    var lang_key: String?
    var user_token_timestamp_created: String?
    var user_token_timestamp_last_updated: String?
    var user_type_name_ar: String?
    var user_type_name_en: String?
    var token: String?
    

    
    
    
    
    
    
   
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        user_id <- map["user_id"]
        user_username <- map["user_username"]
        user_email <- map["user_email"]
        user_phone <- map["user_phone"]
        user_type_id <- map["user_type_id"]
        user_old_pass <- map["user_old_pass"]
        user_status <- map["user_status"]
        is_admin <- map["is_admin"]
        theme_color <- map["theme_color"]
        user_active_status <- map["user_active_status"]
        user_reset_link <- map["user_reset_link"]
        user_reset_link_datetime <- map["user_reset_link_datetime"]
        user_token_id <- map["user_token_id"]
        user_token_plat_forms <- map["user_token_plat_forms"]
        lang_key <- map["lang_key"]
        user_token_timestamp_created <- map["user_token_timestamp_created"]
        user_token_timestamp_last_updated <- map["user_token_timestamp_last_updated"]
        user_type_name_ar <- map["user_type_name_ar"]
        user_type_name_en <- map["user_type_name_en"]
        token <- map["token"]
        
        
    }
}
