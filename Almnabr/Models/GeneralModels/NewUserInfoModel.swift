//
//  NewUserInfoModel.swift
//  Almnabr
//
//  Created by MacBook on 23/09/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftKeychainWrapper

class NewUserInfoModel: NSObject, NSCoding, Mappable {
    
    var id: Int?
    var name: String?
    var edit_users: String?
    
    var title: String?
    var email: String?
    var created_at: String?
    
    var updated_at: String?
    var rule: Int?
    var is_active: Int?
    
    var is_deleted: Int?
    var emp_no: String?
    var emp_department: String?
    
    
    var all_projects: Int?
    var fcm_token: String?
    var user_image: String?
    
    
    var vac_av_count: Int?
    var vac_increment: Int?
    var vac_used: Int?
    
    var vac_sick_used: Int?

    var on_hold_vacations: Int?
    
    var super_visor_id: Int?
    var is_visor: Int?
    var mobile: String?
    
    
    var activation_token: Int?
    var gplus_token: Int?
    var used_vacations: Int?
    
    
    
    var team_id: Int?
    var gitlab_id: Int?
    var deleted_at: String?
    var region: String?
    var online: String?
    var pending_vacations: Int?
    var approved_vacations: Int?
    var rejected_vacations: Int?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        

        
        id <- map["id"]
        name <- map["name"]
        edit_users <- map["edit_users"]
        
        title <- map["title"]
        email <- map["email"]
        created_at <- map["created_at"]
        
        updated_at <- map["updated_at"]
        rule <- map["rule"]
        is_active <- map["is_active"]
        
        is_deleted <- map["is_deleted"]
        emp_no <- map["emp_no"]
        emp_department <- map["emp_department"]
        
        all_projects <- map["all_projects"]
        fcm_token <- map["fcm_token"]
        user_image <- map["user_image"]
        
        vac_av_count <- map["vac_av_count"]
        vac_increment <- map["vac_increment"]
        vac_used <- map["vac_used"]
        vac_sick_used <- map["vac_sick_used"]

        super_visor_id <- map["super_visor_id"]
        is_visor <- map["is_visor"]
        mobile <- map["mobile"]
        
        activation_token <- map["activation_token"]
        gplus_token <- map["gplus_token"]
        used_vacations <- map["used_vacations"]
        
       
        
        team_id <- map["team_id"]
        gitlab_id <- map["gitlab_id"]
        deleted_at <- map["deleted_at"]
        region <- map["region"]
        online <- map["online"]
        pending_vacations <- map["pending_vacations"]
        approved_vacations <- map["approved_vacations"]
        rejected_vacations <- map["rejected_vacations"]
    }
    
   
    
    override init() {}
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        
        
        
        
        
        
        
        id = aDecoder.decodeObject(forKey: "id") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
        edit_users = aDecoder.decodeObject(forKey: "edit_users") as? String
        
        title = aDecoder.decodeObject(forKey: "title") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        created_at = aDecoder.decodeObject(forKey: "created_at") as? String
        
        updated_at = aDecoder.decodeObject(forKey: "updated_at") as? String
        rule = aDecoder.decodeObject(forKey: "rule") as? Int
        is_active = aDecoder.decodeObject(forKey: "is_active") as? Int
        
        is_deleted = aDecoder.decodeObject(forKey: "is_deleted") as? Int
        emp_no = aDecoder.decodeObject(forKey: "emp_no") as? String
        emp_department = aDecoder.decodeObject(forKey: "emp_department") as? String
        
        
        all_projects = aDecoder.decodeObject(forKey: "all_projects") as? Int
        fcm_token = aDecoder.decodeObject(forKey: "fcm_token") as? String
        user_image = aDecoder.decodeObject(forKey: "user_image") as? String
        
        
        vac_av_count = aDecoder.decodeObject(forKey: "vac_av_count") as? Int
        vac_increment = aDecoder.decodeObject(forKey: "vac_increment") as? Int
        vac_used = aDecoder.decodeObject(forKey: "vac_used") as? Int
        vac_sick_used = aDecoder.decodeObject(forKey: "vac_sick_used") as? Int

        on_hold_vacations = aDecoder.decodeObject(forKey: "on_hold_vacations") as? Int
        
        super_visor_id = aDecoder.decodeObject(forKey: "super_visor_id") as? Int
        is_visor = aDecoder.decodeObject(forKey: "is_visor") as? Int
        mobile = aDecoder.decodeObject(forKey: "mobile") as? String
        
        
        activation_token = aDecoder.decodeObject(forKey: "activation_token") as? Int
        gplus_token = aDecoder.decodeObject(forKey: "gplus_token") as? Int
        used_vacations = aDecoder.decodeObject(forKey: "used_vacations") as? Int
        
        
        team_id = aDecoder.decodeObject(forKey: "team_id") as? Int
        gitlab_id = aDecoder.decodeObject(forKey: "gitlab_id") as? Int

        deleted_at = aDecoder.decodeObject(forKey: "deleted_at") as? String
        region = aDecoder.decodeObject(forKey: "region") as? String
        online = aDecoder.decodeObject(forKey: "online") as? String
        pending_vacations = aDecoder.decodeObject(forKey: "pending_vacations") as? Int

        approved_vacations = aDecoder.decodeObject(forKey: "approved_vacations") as? Int
        rejected_vacations = aDecoder.decodeObject(forKey: "rejected_vacations") as? Int
      
        
        
    }
    
    
    func encode(with aCoder: NSCoder) {
        
        
        
        
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(edit_users, forKey: "edit_users")
        
        aCoder.encode(title, forKey: "title")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(created_at, forKey: "created_at")
        
        aCoder.encode(updated_at, forKey: "updated_at")
        aCoder.encode(rule, forKey: "rule")
        aCoder.encode(is_active, forKey: "is_active")
        
        aCoder.encode(is_deleted, forKey: "is_deleted")
        aCoder.encode(emp_no, forKey: "emp_no")
        aCoder.encode(emp_department, forKey: "emp_department")
        
        aCoder.encode(all_projects, forKey: "all_projects")
        aCoder.encode(fcm_token, forKey: "fcm_token")
        aCoder.encode(user_image, forKey: "user_image")
        
        aCoder.encode(vac_av_count, forKey: "vac_av_count")
        aCoder.encode(vac_increment, forKey: "vac_increment")
        aCoder.encode(vac_used, forKey: "vac_used")
        aCoder.encode(vac_sick_used, forKey: "vac_sick_used")

        aCoder.encode(on_hold_vacations, forKey: "on_hold_vacations")
        
        
        aCoder.encode(super_visor_id, forKey: "super_visor_id")
        aCoder.encode(is_visor, forKey: "is_visor")
        aCoder.encode(mobile, forKey: "mobile")
        
        aCoder.encode(activation_token, forKey: "activation_token")
        aCoder.encode(gplus_token, forKey: "gplus_token")
        aCoder.encode(used_vacations, forKey: "used_vacations")
        
        
        aCoder.encode(team_id, forKey: "team_id")
        aCoder.encode(gitlab_id, forKey: "gitlab_id")
        aCoder.encode(deleted_at, forKey: "deleted_at")
        aCoder.encode(region, forKey: "region")
        aCoder.encode(online, forKey: "online")
        aCoder.encode(pending_vacations, forKey: "pending_vacations")
        aCoder.encode(approved_vacations, forKey: "approved_vacations")

        aCoder.encode(rejected_vacations, forKey: "rejected_vacations")
    }
    
    
    
    static func saveUserObject(userData: NewUserInfoModel) {
        let saveSuccessfully = KeychainWrapper.standard.set(userData, forKey: Constants.DEFINEUSERINFORMATION)
        if saveSuccessfully == false {
            print("User Data not stored")
        } else {
            print("User Data stored successfully")
        }
    }
    
    static func getUserObject() -> NewUserInfoModel? {
        if let userObject = KeychainWrapper.standard.object(forKey: Constants.DEFINEUSERINFORMATION) {
            return (userObject as! NewUserInfoModel)
        }
        return nil
    }
    
    static func removeUserObject() {
        let removedObject = KeychainWrapper.standard.removeObject(forKey: Constants.DEFINEUSERINFORMATION)
        if  removedObject == false {
            print("User Data not removed")
        } else {
            print("User Data removed successfully")
        }
    }
}
