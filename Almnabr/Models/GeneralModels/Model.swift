//
//  Model.swift
//  Almnabr
//
//  Created by MacBook on 29/09/2021.
//  Copyright © 2021 Samar Akkila. All rights reserved.
//

import Foundation

enum ItemType {
    case Settings
    case TakeDate
    case MyRequste
    case Home
    case LogOut
    case AboutUs
    case seells
    case SignIn
    case profile
    case notification
    case News
    case ContactUs
    case Cmplition
    case rate
    case contract
    case drinking_water
}


//
//struct DetailsItem {
//    var img : UIImage
//    var title : String
//    var type : ItemType
//    init(title: String, type : ItemType, img:UIImage) {
//        self.title = title
//        self.type = type
//        self.img = img
//    }
//}

struct GeneralObj {
    var number:Int?
    var units:String?
    var Worklevels:String?
    var label:String?
}

struct ByPhaseObj {
    var number:Int?
    var zones:String?
    var Blocks:String?
    var Clusters:String?
    var units:String?
    var Worklevels:String?
    var lblWorklevels:String?
}

struct AttachmentsObj {
    var number:Int?
    var title:String?
    var url:URL?
}

class MenuObj {
    
    var menu_id            :String = ""
    var menu_parent        :String = ""
    var menu_name          :String = ""
    var icon               :String = ""
    var type               :String = ""
    var IsOpened           :Bool = false
    var menu               : [SubMenuObj] = []
    
    init(_ Obj : [String:Any]) {
        
        
        self.menu_id           = Obj["menu_id"] as? String ?? ""
        self.menu_parent       = Obj["menu_parent"] as? String ?? ""
        self.menu_name         = Obj["menu_name"] as? String ?? ""
        self.icon              = Obj["icon"] as? String ?? ""
        self.type              = Obj["type"] as? String ?? ""
        self.IsOpened          = Obj["IsOpened"] as? Bool ?? false
        let data_Array         = Obj["children"] as? [[String:Any]] ?? []
        self.menu              = data_Array.map{SubMenuObj.init($0)}
    }}

class SubMenuObj {
    
    var menu_id            :String = ""
    var menu_parent          :String = ""
    var menu_name         :String = ""
    var icon          :String = ""
    var type          :String = ""
    var menu          :String = ""
    
    init(_ Obj : [String:Any]) {
        
        
        self.menu_id        = Obj["menu_id"] as? String ?? ""
        self.menu_parent       = Obj["menu_parent"] as? String ?? ""
        self.menu_name        = Obj["menu_name"] as? String ?? ""
        self.icon       = Obj["icon"] as? String ?? ""
        self.type        = Obj["type"] as? String ?? ""
        self.menu       = Obj["menu"] as? String ?? ""
        
        
    }}


class UserObj {
    
    var is_admin           :String = ""
    var user_id            :String = ""
    var user_username      :String = ""
    var user_email         :String = ""
    var user_phone         :String = ""
    var user_status        :String = ""
    var user_type_id       :String = ""
    var user_type_name_ar          :String = ""
    var user_type_name_en          :String = ""
    
    init(_ Obj : [String:Any]) {
        
        self.is_admin            = Obj["is_admin"] as? String ?? ""
        self.user_id             = Obj["user_id"] as? String ?? ""
        self.user_username       = Obj["user_username"] as? String ?? ""
        self.user_email          = Obj["user_email"] as? String ?? ""
        self.user_phone          = Obj["user_phone"] as? String ?? ""
        self.user_status         = Obj["user_status"] as? String ?? ""
        self.user_type_id        = Obj["user_type_id"] as? String ?? ""
        self.user_type_name_ar   = Obj["user_type_name_ar"] as? String ?? ""
        self.user_type_name_en   = Obj["user_type_name_en"] as? String ?? ""
        
        
    }}



class themeObj {
    
    var acolor            :String = ""
    var bcolor            :String = ""
    var ccolor            :String = ""
    var dcolor            :String = ""
    
    init(_ Obj : [String:Any]) {
        
        
        self.acolor        = Obj["acolor"] as? String ?? ""
        self.bcolor       = Obj["bcolor"] as? String ?? ""
        self.ccolor        = Obj["ccolor"] as? String ?? ""
        self.dcolor       = Obj["dcolor"] as? String ?? ""
        
        
    }}


class ModuleObj {
    
    var user_type_id     :String = ""
    var value            :String = ""
    var label            :String = ""
    var code             :String = ""
    var fulltext         :String = ""
    var sid              :String = ""
    var id               :String = ""
    var is_select        :Bool = false
    
    init(_ Obj : [String:Any]) {
        
        
        self.value        = Obj["value"] as? String ?? ""
        self.label        = Obj["label"] as? String ?? ""
        self.code         = Obj["code"] as? String ?? ""
        self.fulltext     = Obj["fulltext"] as? String ?? ""
        self.sid          = Obj["sid"] as? String ?? ""
        self.id           = Obj["id"] as? String ?? ""
        self.user_type_id = Obj["user_type_id"] as? String ?? ""
        
        
    }}


class module_attach_typesObj {
    
    var attach_type_id   :String = ""
    var key_code         :String = ""
    var title            :String = ""
    
    init(_ Obj : [String:Any]) {
        
        
        self.attach_type_id    = Obj["attach_type_id"] as? String ?? ""
        self.key_code          = Obj["key_code"] as? String ?? ""
        self.title             = Obj["title"] as? String ?? ""
        
        
    }}


class ObjPlatformGroup {
    
    var value            :String = ""
    var label            :String = ""
    var code             :String = ""
    var fulltext         :String = ""
    var sid              :String = ""
    var platform_group2_title_english         :String = ""
    var platform_group2_title_arabic          :String = ""
    var platform_group1_code_system :String = ""
    init(_ Obj : [String:Any]) {
        
        
        self.value        = Obj["value"] as? String ?? ""
        self.label        = Obj["label"] as? String ?? ""
        self.code         = Obj["code"] as? String ?? ""
        self.fulltext     = Obj["fulltext"] as? String ?? ""
        self.sid          = Obj["sid"] as? String ?? ""
        self.platform_group2_title_english     = Obj["platform_group2_title_english"] as? String ?? ""
        self.platform_group2_title_arabic      = Obj["platform_group2_title_arabic"] as? String ?? ""
        self.platform_group1_code_system      = Obj["platform_group1_code_system"] as? String ?? ""
        
        
    }}

class PageObj {
    
    var total_records       :Int = -1
    var Str_total_records   :String = "0"
    var per_page            :Int = -1
    var offset              :Int = -1
    var total_pages         :Int = -1
    var page_no             :Int = -1
    
    init(_ Obj : [String:Any]) {
        
        
        self.total_records        = Obj["total_records"] as? Int ?? -1
        self.Str_total_records    = Obj["total_records"] as? String ?? "0"
        self.per_page             = Obj["per_page"] as? Int ?? -1
        self.offset               = Obj["offset"] as? Int ?? -1
        self.total_pages          = Obj["total_pages"] as? Int ?? -1
        self.page_no              = Obj["page_no"] as? Int ?? -1
        
        
    }}

class Tcore {
    
    var transaction_request_id        :String = ""
    var branch_id                     :String = ""
    var transaction_key               :String = ""
    var module_key                    :String = ""
    var transaction_from              :String = ""
    var transaction_to                :String = ""
    var lang_key                      :String = ""
    var transactions_types_id         :String = ""
    var transaction_request_description        :String = ""
    var transaction_request_type_of_approval   :String = ""
    var transaction_request_last_step          :String = ""
    var transactions_type_name                 :String = ""
    var module_name                            :String = ""
    var transactions_name                      :String = ""
    var transaction_from_name                  :String = ""
    var transaction_to_name                    :String = ""
    var transactions_date_id                   :String = ""
    var transactions_date_user_type_id         :String = ""
    var transactions_date_last_update          :String = ""
    var transactions_date_t                    :String = ""
    var transactions_date_days_of_delay        :String = ""
    var transactions_date_status               :String = ""
    var transaction_request_status             :String = ""
    var transactions_submitter_user_id         :String = ""
    var transactions_submitter_user_name       :String = ""
    var transaction_request_user_name_writer   :String = ""
    var barcode                                :String = ""
    var url                                    :String = ""
    var create_datetime  :String = ""
    var language_name  :String = ""
    var projects_work_area_id :String = ""
    var template_platform_code_system :String = ""
    var template_id :String = ""
    var view_link :String = ""
    
    
    init(_ Obj : [String:Any]) {
        
        
        self.transaction_request_id  = Obj["transaction_request_id"] as? String ?? ""
        self.branch_id  = Obj["branch_id"] as? String ?? ""
        self.transaction_key   = Obj["transaction_key"] as? String ?? ""
        self.module_key   = Obj["module_key"] as? String ?? ""
        self.transaction_from    = Obj["transaction_from"] as? String ?? ""
        self.transaction_to    = Obj["transaction_to"] as? String ?? ""
        self.lang_key      = Obj["lang_key"] as? String ?? ""
        self.transactions_types_id    = Obj["transactions_types_id"] as? String ?? ""
        self.transaction_request_description      = Obj["transaction_request_description"] as? String ?? ""
        self.transaction_request_type_of_approval    = Obj["transaction_request_type_of_approval"] as? String ?? ""
        self.transaction_request_last_step     = Obj["transaction_request_last_step"] as? String ?? ""
        self.transactions_type_name     = Obj["transactions_type_name"] as? String ?? ""
        self.module_name     = Obj["module_name"] as? String ?? ""
        self.transactions_name      = Obj["transactions_name"] as? String ?? ""
        self.transaction_from_name      = Obj["transaction_from_name"] as? String ?? ""
        self.transaction_to_name       = Obj["transaction_to_name"] as? String ?? ""
        self.transactions_date_id      = Obj["transactions_date_id"] as? String ?? ""
        self.transactions_date_user_type_id     = Obj["transactions_date_user_type_id"] as? String ?? ""
        self.transactions_date_last_update       = Obj["transactions_date_last_update"] as? String ?? ""
        self.transactions_date_t      = Obj["transactions_date_t"] as? String ?? ""
        self.transactions_date_days_of_delay    = Obj["transactions_date_days_of_delay"] as? String ?? ""
        self.transactions_date_status      = Obj["transactions_date_status"] as? String ?? ""
        self.transaction_request_status      = Obj["transaction_request_status"] as? String ?? ""
        self.transactions_submitter_user_id   = Obj["transactions_submitter_user_id"] as? String ?? ""
        self.transactions_submitter_user_name      = Obj["transactions_submitter_user_name"] as? String ?? ""
        self.transaction_request_user_name_writer    = Obj["transaction_request_user_name_writer"] as? String ?? ""
        self.barcode     = Obj["barcode"] as? String ?? ""
        self.url    = Obj["url"] as? String ?? ""
        self.create_datetime    = Obj["create_datetime"] as? String ?? ""
        self.language_name    = Obj["language_name"] as? String ?? ""
        self.projects_work_area_id = Obj["projects_work_area_id"] as? String ?? ""
        self.template_platform_code_system = Obj["template_platform_code_system"] as? String ?? ""
        self.template_id = Obj["template_id"] as? String ?? ""
        self.view_link = Obj["view_link"] as? String ?? ""
        
    }}

class CronJobObj {
    
    var transactions_cronjob_id       :String = ""
    var transaction_request_id        :String = ""
    var transaction_key               :String = ""
    var transactions_cronjob_try_to_submitting         :String = ""
    var transactions_cronjob_last_update               :String = ""
    var transactions_cronjob_err                       :String = ""
    
    init(_ Obj : [String:Any]) {
        
        
        self.transactions_cronjob_id        = Obj["transactions_cronjob_id"] as? String ?? ""
        self.transaction_request_id             = Obj["transaction_request_id"] as? String ?? ""
        self.transaction_key               = Obj["transaction_key"] as? String ?? ""
        self.transactions_cronjob_try_to_submitting          = Obj["transactions_cronjob_try_to_submitting"] as? String ?? ""
        self.transactions_cronjob_last_update              = Obj["transactions_cronjob_last_update"] as? String ?? ""
        self.transactions_cronjob_err              = Obj["transactions_cronjob_err"] as? String ?? ""
        
        
    }}


class projectObj {
    
    var projects_profile_id        :String = ""
    var customer_id                :String = ""
    var branch_id                  :String = ""
    var customer_type_id           :String = ""
    var projects_profile_location  :String = ""
    var transaction_request_id     :String = ""
    var projects_profile_status    :String = ""
    var projects_profile_writer    :String = ""
    var projects_profile_name_en   :String = ""
    var projects_profile_name_ar   :String = ""
    var latitude                   :String = ""
    var longitude                  :String = ""
    var projects_profile_created_datetime                            :String = ""
    var projects_profile_updated_datetime  :String = ""
    var customer_title_ar                  :String = ""
    var customer_title_en                  :String = ""
    var project_title                      :String = ""
    var branch_name                        :String = ""
    var customer_name                      :String = ""
    var customer_type                      :String = ""
    var writer                             :String = ""
    
    init(_ Obj : [String:Any]) {
        
        
        self.projects_profile_id  = Obj["projects_profile_id"] as? String ?? ""
        self.customer_id  = Obj["customer_id"] as? String ?? ""
        self.branch_id   = Obj["branch_id"] as? String ?? ""
        self.customer_type_id   = Obj["customer_type_id"] as? String ?? ""
        self.projects_profile_location    = Obj["projects_profile_location"] as? String ?? ""
        self.transaction_request_id    = Obj["transaction_request_id"] as? String ?? ""
        self.projects_profile_status      = Obj["projects_profile_status"] as? String ?? ""
        self.projects_profile_writer    = Obj["projects_profile_writer"] as? String ?? ""
        self.projects_profile_name_en      = Obj["projects_profile_name_en"] as? String ?? ""
        self.projects_profile_name_ar    = Obj["projects_profile_name_ar"] as? String ?? ""
        self.latitude     = Obj["latitude"] as? String ?? ""
        self.longitude     = Obj["longitude"] as? String ?? ""
        self.projects_profile_created_datetime     = Obj["projects_profile_created_datetime"] as? String ?? ""
        self.projects_profile_updated_datetime      = Obj["projects_profile_updated_datetime"] as? String ?? ""
        self.customer_title_ar      = Obj["customer_title_ar"] as? String ?? ""
        self.customer_title_en       = Obj["customer_title_en"] as? String ?? ""
        self.project_title      = Obj["project_title"] as? String ?? ""
        self.branch_name     = Obj["branch_name"] as? String ?? ""
        self.customer_name       = Obj["customer_name"] as? String ?? ""
        self.customer_type      = Obj["customer_type"] as? String ?? ""
        self.writer    = Obj["writer"] as? String ?? ""
      
    }}


class projectQuotObj {
    
    
    var projects_profile_id :String = ""
    var projects_work_area_id :String = ""
    var projects_supervision_id        :String = ""
    var projects_quotation_id                :String = ""
    var quotation_subject                  :String = ""
    var quotation_grand_total           :String = ""
    var quotation_tax_amount  :String = ""
    var quotation_net_amount     :String = ""
    var quotation_approved_date    :String = ""
    var quotation_created_date    :String = ""
    var writer                             :String = ""
    var label                             :String = ""
    var teamtitle  :String = ""
    var Positions :String = ""
    var project_user_group_created_datetime :String  = ""
    var position :String = ""
    var project_user_group_mention_key :String = ""
    
    init(_ Obj : [String:Any]) {
        
       
        self.projects_work_area_id  = Obj["projects_work_area_id"] as? String ?? ""
        self.projects_profile_id  = Obj["projects_profile_id"] as? String ?? ""
        self.projects_supervision_id  = Obj["projects_supervision_id"] as? String ?? ""
        self.projects_quotation_id  = Obj["projects_quotation_id"] as? String ?? ""
        self.quotation_subject   = Obj["quotation_subject"] as? String ?? ""
        self.quotation_grand_total   = Obj["quotation_grand_total"] as? String ?? ""
        self.quotation_tax_amount    = Obj["quotation_tax_amount"] as? String ?? ""
        self.quotation_net_amount    = Obj["quotation_net_amount"] as? String ?? ""
        self.quotation_approved_date      = Obj["quotation_approved_date"] as? String ?? ""
        self.quotation_created_date    = Obj["quotation_created_date"] as? String ?? ""
        self.writer    = Obj["writer"] as? String ?? ""
        self.label    = Obj["label"] as? String ?? ""
       self.teamtitle   = Obj["teamtitle"] as? String ?? ""
        self.Positions  = Obj["Positions"] as? String ?? ""
        self.position  = Obj["position"] as? String ?? ""
        self.project_user_group_mention_key  = Obj["project_user_group_mention_key"] as? String ?? ""
        self.project_user_group_created_datetime  = Obj["project_user_group_created_datetime"] as? String ?? ""
        
        
    }}

class ContactObj {
   
    var contacts_id :String = ""
    var projects_profile_id :String = ""
    var transaction_request_id        :String = ""
    var contacts_type                :String = ""
    var contacts_name                  :String = ""
    var contacts_email           :String = ""
    var contacts_mobile  :String = ""
    var contacts_whatsapp     :String = ""
    var contacts_fax    :String = ""
    var contacts_writer    :String = ""
    var contacts_created_datetime     :String = ""
    var contacts_updated_datetime  :String = ""
    var contact_type_name :String = ""
    var writer                             :String = ""
  
    init(_ Obj : [String:Any]) {
        
        self.contacts_id  = Obj["contacts_id"] as? String ?? ""
        
        self.projects_profile_id  = Obj["projects_profile_id"] as? String ?? ""
        self.transaction_request_id  = Obj["transaction_request_id"] as? String ?? ""
        self.contacts_type  = Obj["contacts_type"] as? String ?? ""
        self.contacts_name   = Obj["contacts_name"] as? String ?? ""
        self.contacts_email   = Obj["contacts_email"] as? String ?? ""
        self.contacts_mobile    = Obj["contacts_mobile"] as? String ?? ""
        self.contacts_whatsapp    = Obj["contacts_whatsapp"] as? String ?? ""
        self.contacts_fax      = Obj["contacts_fax"] as? String ?? ""
        self.contacts_writer    = Obj["contacts_writer"] as? String ?? ""
        self.writer    = Obj["writer"] as? String ?? ""
        self.contacts_created_datetime    = Obj["contacts_created_datetime"] as? String ?? ""
       self.contacts_updated_datetime   = Obj["contacts_updated_datetime"] as? String ?? ""
        self.contact_type_name  = Obj["contact_type_name"] as? String ?? ""
        
        
    }}



class DocumentObj {
    
    
    var projects_profile_id     :String = ""
    var projects_work_area_id   :String = ""
    var projects_supervision_id :String = ""
    var transaction_request_id  :String = ""
    var file_records_id         :String = ""
    var project_settings_id     :String = ""
    var documents_parent_id     :String = ""
    var documents_file_status   :String = ""
    var document_writer         :String = ""
    var documents_description   :String = ""
    var module_key              :String = ""
    var level_keys              :String = ""
    var file_path               :String = ""
    var file_size               :String = ""
    var file_extension          :String  = ""
    var file_name_en            :String = ""
    var file_name_ar            :String = ""
    var user_id_writer          :String = ""
    var created_datetime        :String  = ""
    var documents_file_url      :String  = ""
    var document_type           :String  = ""
    var document_sub_type       :String  = ""
    var writer                  :String = ""
    var path                    :String = ""
    var insert_date             :String = ""
    
    
    init(_ Obj : [String:Any]) {
        
       
        self.projects_work_area_id  = Obj["projects_work_area_id"] as? String ?? ""
        self.projects_profile_id  = Obj["projects_profile_id"] as? String ?? ""
        self.projects_supervision_id  = Obj["projects_supervision_id"] as? String ?? ""
        self.transaction_request_id  = Obj["transaction_request_id"] as? String ?? ""
        self.file_records_id   = Obj["file_records_id"] as? String ?? ""
        self.project_settings_id   = Obj["project_settings_id"] as? String ?? ""
        self.documents_parent_id    = Obj["documents_parent_id"] as? String ?? ""
        self.documents_file_status    = Obj["documents_file_status"] as? String ?? ""
        self.document_writer      = Obj["document_writer"] as? String ?? ""
        self.documents_description = Obj["documents_description"] as? String ?? ""
        self.module_key    = Obj["module_key"] as? String ?? ""
        self.writer    = Obj["writer"] as? String ?? ""
        self.level_keys    = Obj["level_keys"] as? String ?? ""
       self.file_path   = Obj["file_path"] as? String ?? ""
        self.file_size  = Obj["file_size"] as? String ?? ""
        self.file_extension  = Obj["file_extension"] as? String ?? ""
        self.file_name_en  = Obj["file_name_en"] as? String ?? ""
        
        self.file_name_ar   = Obj["file_name_ar"] as? String ?? ""
         self.user_id_writer  = Obj["user_id_writer"] as? String ?? ""
         self.created_datetime  = Obj["created_datetime"] as? String ?? ""
         self.documents_file_url  = Obj["documents_file_url"] as? String ?? ""
        self.document_type  = Obj["document_type"] as? String ?? ""
        self.document_sub_type  = Obj["document_sub_type"] as? String ?? ""
        self.path  = Obj["path"] as? String ?? ""
        self.insert_date  = Obj["insert_date"] as? String ?? ""
        
        
    }}



class templateObj {
    
    var platform_code_system :String = ""
    var template_platform_group_type_code_system : String = ""
    var platform_group_type_code_system :String = ""
    var template_platform_group2_code_system :String = ""
    var template_platform_code_system  :String = ""
    var projects_work_area_id :String = ""
    var platformname :String = ""
    var templatename        :String = ""
    var group1name                :String = ""
    var group2name                  :String = ""
    var typename           :String = ""
    var template_id            :String = ""
    var phase_zone_block_cluster_g_nos           :String = ""
    var contractor_manager_default_users :String = ""
    var contractor_manager_step_require :String = ""
    var contractor_team_users :String = ""
    
   
    init(_ Obj : [String:Any]) {
        
        self.platform_group_type_code_system = Obj["platform_group_type_code_system"] as? String ?? ""
        self.template_platform_group_type_code_system  = Obj["template_platform_group_type_code_system"] as? String ?? ""
        self.template_id  = Obj["template_id"] as? String ?? ""
        self.template_platform_group2_code_system  = Obj["template_platform_group2_code_system"] as? String ?? ""
        self.platformname  = Obj["platformname"] as? String ?? ""
        self.templatename  = Obj["templatename"] as? String ?? ""
        self.group1name  = Obj["group1name"] as? String ?? ""
        self.group2name   = Obj["group2name"] as? String ?? ""
        self.typename   = Obj["typename"] as? String ?? ""
        self.template_platform_code_system   = Obj["template_platform_code_system"] as? String ?? ""
        self.projects_work_area_id   = Obj["projects_work_area_id"] as? String ?? ""
        self.phase_zone_block_cluster_g_nos  = Obj["phase_zone_block_cluster_g_nos"] as? String ??  ""
        self.platform_code_system = Obj["platform_code_system"] as? String ?? ""
        self.contractor_manager_default_users = Obj["contractor_manager_default_users"] as? String ?? ""
        self.contractor_manager_step_require = Obj["contractor_manager_step_require"] as? String ?? ""
        self.contractor_team_users = Obj["contractor_team_users"] as? String ?? ""
        
    }}




class FormTransactionObj {
    
  
    var file_path :String = ""
    var levelname  :String = ""
    var result_code :String = "---"
    var tbv_barcodeData :String = ""
    var transaction_request_id        :String = ""
    var transactions_date_datetime                :String = ""
    var unit_id                  :String = ""
    var color :String = ""
    init(_ Obj : [String:Any]) {
        
       
        self.color  = Obj["color"] as? String ?? ""
        self.file_path  = Obj["file_path"] as? String ?? ""
        self.levelname  = Obj["levelname"] as? String ?? ""
        self.result_code  = Obj["result_code"] as? String ?? "---"
        self.tbv_barcodeData  = Obj["tbv_barcodeData"] as? String ?? ""
        self.unit_id   = Obj["unit_id"] as? String ?? ""
        self.transaction_request_id   = Obj["transaction_request_id"] as? String ?? ""
        self.transactions_date_datetime   = Obj["transactions_date_datetime"] as? String ?? ""
      
    }}



class RelatedFormObj {
    
    var barcode :String = ""
    var color :String = ""
    var file_extension :String = ""
    var file_path :String = ""
    
    var level :String = ""
    var platform_label :String = "---"
    var required_platform :String = ""
    var result_code :String = "---"
    var template_id :String = ""
    var unit :String = "---"
    var work_area_id :String = ""
    var work_level_label :String = "---"
    
  
    init(_ Obj : [String:Any]) {
        
       
        self.barcode  = Obj["barcode"] as? String ?? ""
        self.color  = Obj["color"] as? String ?? ""
        self.file_extension  = Obj["file_extension"] as? String ?? ""
        self.level  = Obj["level"] as? String ?? ""
        self.platform_label   = Obj["platform_label"] as? String ?? ""
        self.required_platform   = Obj["required_platform"] as? String ?? "---"
        self.result_code   = Obj["result_code"] as? String ?? "---"
        self.file_path   = Obj["file_path"] as? String ?? ""
        self.template_id  = Obj["template_id"] as? String ?? ""
        self.unit   = Obj["unit"] as? String ?? "---"
        self.work_area_id   = Obj["work_area_id"] as? String ?? ""
        self.work_level_label   = Obj["work_level_label"] as? String ?? "---"
      
    }}




class RuleObj {
    
    var all_platforms_required :String = ""
    var all_platforms_required_result_fail :String = ""
    var all_platforms_required_result_pass :String = ""
    
  
    init(_ Obj : [String:Any]) {
        
       
        self.all_platforms_required  = Obj["all_platforms_required"] as? String ?? ""
        self.all_platforms_required_result_fail  = Obj["all_platforms_required_result_fail"] as? String ?? ""
        self.all_platforms_required_result_pass  = Obj["all_platforms_required_result_pass"] as? String ?? ""
        
      
    }}

class NotificationObj {
    
    var noty_messages_body :String = ""
    var noty_messages_date_time :String = ""
    var noty_messages_id :String = ""
    var noty_messages_image :String = ""
    var noty_messages_timestamp :String = ""
    var noty_messages_title :String = ""
    var extra_data :[String:Any] = [:]
  
    init(_ Obj : [String:Any]) {
        
       
        self.noty_messages_body  = Obj["noty_messages_body"] as? String ?? ""
        self.noty_messages_date_time  = Obj["noty_messages_date_time"] as? String ?? ""
        self.noty_messages_id  = Obj["noty_messages_id"] as? String ?? ""
        self.noty_messages_image  = Obj["noty_messages_image"] as? String ?? ""
        self.noty_messages_timestamp  = Obj["noty_messages_timestamp"] as? String ?? ""
        self.noty_messages_title  = Obj["noty_messages_title"] as? String ?? ""
        self.extra_data  = Obj["extra_data"] as? [String:Any] ?? [:]
      
    }}




class FileObj {
    
    var file_extension :String = ""
    var file_path :String = ""
    var file_records_id :String = ""
    var file_size :String = ""
    var label :String = ""
    var writer :String = ""
  
    init(_ Obj : [String:Any]) {
        
       
        self.file_extension  = Obj["file_extension"] as? String ?? ""
        self.file_path  = Obj["file_path"] as? String ?? ""
        self.file_records_id  = Obj["file_records_id"] as? String ?? ""
        self.file_size  = Obj["file_size"] as? String ?? ""
        self.label  = Obj["label"] as? String ?? ""
        self.writer  = Obj["writer"] as? String ?? ""
        
      
    }}


class ContractorObj {
    
    var label :String = ""
    var user_id :String = ""
    var user_job :String = ""
    var user_title :String = ""
    var user_type_id :String = ""
    var value :String = ""
  
    init(_ Obj : [String:Any]) {
        
       
        self.label  = Obj["label"] as? String ?? ""
        self.user_id  = Obj["user_id"] as? String ?? ""
        self.user_job  = Obj["user_job"] as? String ?? ""
        self.user_title  = Obj["user_title"] as? String ?? ""
        self.user_type_id  = Obj["user_type_id"] as? String ?? ""
        self.value  = Obj["value"] as? String ?? ""
        
      
    }}


class StepStatusObj {
    
    var Authorized_Positions_Approval :Bool = false
    var Configurations :Bool = false
    var Contractor_Manager_Approval :Bool = false
    var Contractor_Team_Approval :Bool = false
    var Evaluation_Result :Bool = false
    var Final_Result :Bool = false
    var Manager_Approval :Bool = false
    var Owners_Representative :Bool = false
    var Recipient_Verification :Bool = false
    var Special_Approval :Bool = false
    var Techinical_Assistant :Bool = false

    init(_ Obj : [String:Any]) {
        
        self.Authorized_Positions_Approval  = Obj["Authorized_Positions_Approval"] as? Bool ?? false
        self.Configurations  = Obj["Configurations"] as? Bool ?? false
        self.Contractor_Manager_Approval  = Obj["Contractor_Manager_Approval"] as? Bool ?? false
        self.Contractor_Team_Approval  = Obj["Contractor_Team_Approval"] as? Bool ?? false
        self.Evaluation_Result  = Obj["Evaluation_Result"] as? Bool ?? false
        self.Final_Result  = Obj["Final_Result"] as? Bool ?? false
        self.Manager_Approval  = Obj["Manager_Approval"] as? Bool ?? false
        self.Owners_Representative  = Obj["Owners_Representative"] as? Bool ?? false
        self.Recipient_Verification  = Obj["Recipient_Verification"] as? Bool ?? false
        self.Special_Approval  = Obj["Special_Approval"] as? Bool ?? false
        self.Techinical_Assistant  = Obj["Techinical_Assistant"] as? Bool ?? false
      
    }
    
    var to_array : [Bool] {
        return [self.Authorized_Positions_Approval,
                self.Configurations,
                self.Contractor_Manager_Approval,
                self.Contractor_Team_Approval,
                self.Evaluation_Result,
                self.Final_Result,
                self.Manager_Approval,
                self.Owners_Representative,
                self.Recipient_Verification,
                self.Special_Approval,
                self.Techinical_Assistant
        ]
    }
    
}



class WorkAreaInfoObj {
    
    var projects_work_area_id  : String = ""
    var branch_id              : String = ""
    var supervision_settings_drawing_submittal_alert_expire  : String = ""
    var projects_supervision_id : String = ""
    var projects_profile_id     : String = ""
    var drawing_file            : String = ""
    var projects_profile_name   : String = ""
    var customer_name           : String = ""
    var contractor_name         : String = ""
    var projects_services_name  : String = ""
    var branch_name             : String = ""

    init(_ Obj : [String:Any]) {
        
        
        
        self.projects_work_area_id  = Obj["projects_work_area_id"] as? String ?? ""
        self.branch_id       = Obj["branch_id"] as? String ?? ""
        self.supervision_settings_drawing_submittal_alert_expire  = Obj["supervision_settings_drawing_submittal_alert_expire"] as? String ?? ""
        self.projects_supervision_id      = Obj["projects_supervision_id"] as? String ?? ""
        self.projects_profile_id       = Obj["projects_profile_id"] as? String ?? ""
        self.drawing_file      = Obj["drawing_file"] as? String ?? ""
        self.projects_profile_name  = Obj["projects_profile_name"] as? String ?? ""
        self.customer_name   = Obj["customer_name"] as? String ?? ""
        self.contractor_name   = Obj["contractor_name"] as? String ?? ""
        self.projects_services_name  = Obj["projects_services_name"] as? String ?? ""
        self.branch_name   = Obj["branch_name"] as? String ?? ""

        
        
        
        
    }
    
}



class form_wir_dataObj {
    

    var auto_id : String = ""
    var transaction_key : String = ""
    var transaction_request_id : String = ""
    var projects_work_area_id : String = ""
    var template_id : String = ""
    var platform_code_system : String = ""
    var evaluation_result : String = ""
    var owner_decision_form : String = ""
    var contractor_team_users : String = ""
    var contractor_manager_step_require : String = ""
    var contractor_manager_default_users : String = ""
    var template_type : String = ""
    var typename : String = ""
    var group1name : String = ""
    var group2name : String = ""
    var platformname : String = ""
    var templatename : String = ""
    var specification : String = "---"
    var platform_group_type_code_system : String = ""
    var template_platform_group_type_code_system : String = ""
    
    

    init(_ Obj : [String:Any]) {
        
      
        self.auto_id   =  Obj["auto_id"] as? String ?? ""
        self.transaction_key   =  Obj["transaction_key"] as? String ?? ""
        self.transaction_request_id   =  Obj["transaction_request_id"] as? String ?? ""
        self.projects_work_area_id   =  Obj["projects_work_area_id"] as? String ?? ""
        self.template_id   =  Obj["template_id"] as? String ?? ""
        self.platform_code_system   =  Obj["platform_code_system"] as? String ?? ""
        self.evaluation_result   =  Obj["evaluation_result"] as? String ?? ""
        self.owner_decision_form   =  Obj["owner_decision_form"] as? String ?? ""
        self.contractor_team_users   =  Obj["contractor_team_users"] as? String ?? ""
        self.contractor_manager_step_require   =  Obj["contractor_manager_step_require"] as? String ?? ""
        self.contractor_manager_default_users   =  Obj["contractor_manager_default_users"] as? String ?? ""
        self.template_type   =  Obj["template_type"] as? String ?? ""
        self.typename   =  Obj["typename"] as? String ?? ""
        self.group1name   =  Obj["group1name"] as? String ?? ""
        self.group2name   =  Obj["group2name"] as? String ?? ""
        self.platformname   =  Obj["platformname"] as? String ?? ""
        self.templatename   =  Obj["templatename"] as? String ?? ""
        self.specification   =  Obj["specification"] as? String ?? "---"
        self.platform_group_type_code_system   =  Obj["platform_group_type_code_system"] as? String ?? ""
        self.template_platform_group_type_code_system   =  Obj["template_platform_group_type_code_system"] as? String ?? ""
        
    }
    
    
}



class transactions_notesObj {

    var transactions_notes_id : String = ""
    var transaction_request_id : String = ""
    var transactions_notes_user_id : String = ""
    var transactions_notes_text : String = ""
    var transactions_notes_datetime : String = ""
    var transactions_notes_user_name : String = ""
    
    
    
    
    init(_ Obj : [String:Any]) {
        
        
        self.transactions_notes_id = Obj["transactions_notes_id"] as? String ?? ""
        self.transaction_request_id = Obj["transaction_request_id"] as? String ?? ""
        self.transactions_notes_user_id = Obj["transactions_notes_user_id"] as? String ?? ""
        self.transactions_notes_text = Obj["transactions_notes_text"] as? String ?? ""
        self.transactions_notes_datetime = Obj["transactions_notes_datetime"] as? String ?? ""
        self.transactions_notes_user_name = Obj["transactions_notes_user_name"] as? String ?? ""
        
        
    }
    
    
}




class transactions_personsObj {

    var signature :String = ""
    var mark :String = ""
    var transactions_persons_id :String = ""
    var transaction_request_id :String = ""
    var user_id :String = ""
    var user_type_id :String = ""
    var transaction_persons_type :String = ""
    var transactions_persons_key1 :String = ""
    var transactions_persons_val1 :String = ""
    var transactions_persons_key2 :String = ""
    var transactions_persons_val2 :String = ""
    var transactions_persons_key3 :String = ""
    var transactions_persons_val3 :String = ""
    var transactions_persons_key4 :String = ""
    var transactions_persons_val4 :String = ""
    var transactions_persons_view :String = ""
    var transactions_persons_view_datetime :String = ""
    var transactions_persons_view_datetime_lastupdate :String = ""
    var transactions_persons_send_code_method :String = ""
    var transactions_persons_send_code_datetime :String = ""
    var transactions_persons_action_datetime :String = ""
    var transactions_persons_action_status :String = ""
    var transactions_persons_last_step :String = ""
    var first_name :String = ""
    var last_name :String = ""
    
    
    
    
    
    init(_ Obj : [String:Any]) {
        
        self.signature = Obj["signature"] as? String ?? ""
        self.mark = Obj["mark"] as? String ?? ""
        self.transactions_persons_id = Obj["transactions_persons_id"] as? String ?? ""
        self.transaction_request_id = Obj["transaction_request_id"] as? String ?? ""
        self.user_id = Obj["user_id"] as? String ?? ""
        self.user_type_id = Obj["user_type_id"] as? String ?? ""
        self.transaction_persons_type = Obj["transaction_persons_type"] as? String ?? ""
        self.transactions_persons_key1 = Obj["transactions_persons_key1"] as? String ?? ""
        self.transactions_persons_val1 = Obj["transactions_persons_val1"] as? String ?? ""
        self.transactions_persons_key2 = Obj["transactions_persons_key2"] as? String ?? ""
        self.transactions_persons_val2 = Obj["transactions_persons_val2"] as? String ?? ""
        self.transactions_persons_key3 = Obj["transactions_persons_key3"] as? String ?? ""
        self.transactions_persons_val3 = Obj["transactions_persons_val3"] as? String ?? ""
        self.transactions_persons_key4 = Obj["transactions_persons_key4"] as? String ?? ""
        self.transactions_persons_val4 = Obj["transactions_persons_val4"] as? String ?? ""
        self.transactions_persons_view = Obj["transactions_persons_view"] as? String ?? ""
        self.transactions_persons_view_datetime = Obj["transactions_persons_view_datetime"] as? String ?? ""
        self.transactions_persons_view_datetime_lastupdate = Obj["transactions_persons_view_datetime_lastupdate"] as? String ?? ""
        self.transactions_persons_send_code_method = Obj["transactions_persons_send_code_method"] as? String ?? ""
        self.transactions_persons_send_code_datetime = Obj["transactions_persons_send_code_datetime"] as? String ?? ""
        self.transactions_persons_action_datetime = Obj["transactions_persons_action_datetime"] as? String ?? ""
        self.transactions_persons_action_status = Obj["transactions_persons_action_status"] as? String ?? ""
        self.transactions_persons_last_step = Obj["transactions_persons_last_step"] as? String ?? ""
        self.first_name = Obj["first_name"] as? String ?? ""
        self.last_name = Obj["last_name"] as? String ?? ""
        
    }
    
    
}







class transactions_recordsObj {

    
    var transactions_records_id : String = ""
    var transaction_request_id : String = ""
    var transactions_records_user_id : String = ""
    var transactions_records_note : String = ""
    var transactions_records_datetime : String = ""
    var transactions_records_user_name : String = ""

    
    init(_ Obj : [String:Any]) {
      
        
        self.transactions_records_id = Obj["transactions_records_id"] as? String ?? ""
        self.transaction_request_id = Obj["transaction_request_id"] as? String ?? ""
        self.transactions_records_user_id = Obj["transactions_records_user_id"] as? String ?? ""
        self.transactions_records_note = Obj["transactions_records_note"] as? String ?? ""
        self.transactions_records_datetime = Obj["transactions_records_datetime"] as? String ?? ""
        self.transactions_records_user_name = Obj["transactions_records_user_name"] as? String ?? ""
        
       
        
    }
    
    
}


class Configurations_AttachmentsObj {

    var project_supervision_form_files_id :String = ""
    var transaction_key :String = ""
    var transaction_request_id :String = ""
    var project_supervision_form_file_path :String = ""
    var project_supervision_form_file_size :String = ""
    var project_supervision_form_file_extension :String = ""
    var project_supervision_form_file_attach_title :String = ""
    var project_supervision_form_file_attach_type :String = ""
    var project_supervision_form_file_foreign_key :String = ""
    var project_supervision_form_file_required :String = ""
    var project_supervision_phase_file :String = ""
    var created_datetime :String = ""
    var writer :String = ""
    var project_supervision_form_file_attach_type_label :String = ""
    var form_dwsr_file_attach_method :String = ""
    var writer_name :String = ""
    
    
    
    
    init(_ Obj : [String:Any]) {
      

        self.project_supervision_form_files_id = Obj["project_supervision_form_files_id"] as? String ?? ""
        self.transaction_key = Obj["transaction_key"] as? String ?? ""
        self.transaction_request_id = Obj["transaction_request_id"] as? String ?? ""
        self.project_supervision_form_file_path = Obj["project_supervision_form_file_path"] as? String ?? ""
        self.project_supervision_form_file_size = Obj["project_supervision_form_file_size"] as? String ?? ""
        self.project_supervision_form_file_extension = Obj["project_supervision_form_file_extension"] as? String ?? ""
        self.project_supervision_form_file_attach_title = Obj["project_supervision_form_file_attach_title"] as? String ?? ""
        self.project_supervision_form_file_attach_type = Obj["project_supervision_form_file_attach_type"] as? String ?? ""
        self.project_supervision_form_file_foreign_key = Obj["project_supervision_form_file_foreign_key"] as? String ?? ""
        self.project_supervision_form_file_required = Obj["project_supervision_form_file_required"] as? String ?? ""
        self.project_supervision_phase_file = Obj["project_supervision_phase_file"] as? String ?? ""
        self.created_datetime = Obj["created_datetime"] as? String ?? ""
        self.writer = Obj["writer"] as? String ?? ""
        self.project_supervision_form_file_attach_type_label = Obj["project_supervision_form_file_attach_type_label"] as? String ?? ""
        self.form_dwsr_file_attach_method = Obj["form_dwsr_file_attach_method"] as? String ?? ""
        self.writer_name = Obj["writer_name"] as? String ?? ""
        
        
        
        
        
    }
    
    
}





class project_supervision_form_unit_levelObj {
    
    var auto_id :String = ""
    var platform_code_system :String = ""
    var projects_work_area_id :String = ""
    var short_code :String = ""
    var template_id :String = ""
    var transaction_key :String = ""
    var transaction_request_id :String = ""
    var unit_id :String = ""
    var work_level_key :String = ""
    var work_level_label :String = ""
    
    
    init(_ Obj : [String:Any]) {
        
        self.auto_id = Obj["auto_id"] as? String ?? ""
        self.platform_code_system = Obj["platform_code_system"] as? String ?? ""
        self.projects_work_area_id = Obj["projects_work_area_id"] as? String ?? ""
        self.short_code = Obj["short_code"] as? String ?? ""
        self.template_id = Obj["template_id"] as? String ?? ""
        self.transaction_key = Obj["transaction_key"] as? String ?? ""
        self.transaction_request_id = Obj["transaction_request_id"] as? String ?? ""
        self.unit_id = Obj["unit_id"] as? String ?? ""
        self.work_level_key = Obj["work_level_key"] as? String ?? ""
        self.work_level_label = Obj["work_level_label"] as? String ?? ""
        
        
        
        
    }
    
}




class NotesObj {
     
    var created_datetime:String = ""
    var extra1_custom_key:String = ""
    var extra1_custom_val:String = ""
    var extra1_id:String = ""
    var extra1_result:String = ""
    var extra1_status:String = ""
    var extra1_title:String = ""
    var extra1_type:String = ""
    var projects_work_area_id:String = ""
    var transaction_request_id:String = ""
    var projects_consultant_recommendations_id:String = ""
    
    init(_ Obj : [String:Any]) {
        
      
        self.created_datetime = Obj["created_datetime"] as?String ?? ""
        self.extra1_custom_key = Obj["extra1_custom_key"] as?String ?? ""
        self.extra1_custom_val = Obj["extra1_custom_val"] as?String ?? ""
        self.extra1_id = Obj["extra1_id"] as?String ?? ""
        self.extra1_result = Obj["extra1_result"] as?String ?? ""
        self.extra1_status = Obj["extra1_status"] as?String ?? ""
        self.extra1_title = Obj["extra1_title"] as?String ?? ""
        self.extra1_type = Obj["extra1_type"] as?String ?? ""
        self.projects_work_area_id = Obj["projects_work_area_id"] as?String ?? ""
        self.transaction_request_id = Obj["transaction_request_id"] as?String ?? ""
        self.projects_consultant_recommendations_id = Obj["projects_consultant_recommendations_id"] as?String ?? ""
        
    }
    
}





class Technical_Assistants_EvaluationObj {
 
    
    var extra1_id :String = ""
    var transaction_request_id :String = ""
    var projects_work_area_id :String = ""
    var extra1_custom_key :String = ""
    var extra1_custom_val :String = ""
    var extra1_title :String = ""
    var extra1_type :String = ""
    var extra1_status :String = ""
    var extra1_result :String = ""
    var created_datetime :String = ""
    var NewAdded :Bool = false
    var no_code_result :String = ""
    var yes_code_result :String = ""
   // var IsNew:Bool = false
    
    init(_ Obj : [String:Any]) {
      
        self.extra1_id = Obj["extra1_id"] as? String ?? ""
        self.transaction_request_id = Obj["transaction_request_id"] as? String ?? ""
        self.projects_work_area_id = Obj["projects_work_area_id"] as? String ?? ""
        self.extra1_custom_key = Obj["extra1_custom_key"] as? String ?? ""
        self.extra1_custom_val = Obj["extra1_custom_val"] as? String ?? ""
        self.extra1_title = Obj["extra1_title"] as? String ?? ""
        self.extra1_type = Obj["extra1_type"] as? String ?? ""
        self.extra1_status = Obj["extra1_status"] as? String ?? ""
        self.extra1_result = Obj["extra1_result"] as? String ?? ""
        self.created_datetime = Obj["created_datetime"] as? String ?? ""
        self.no_code_result = Obj["no_code_result"] as? String ?? ""
        self.yes_code_result = Obj["yes_code_result"] as? String ?? ""
        self.NewAdded = Obj["NewAdded"] as? Bool ?? false
        //self.IsNew = Obj["NewAdded"] as? Bool ?? false
    }
    
    
}



class ProjectRequestObj {

    
    var barcode :String = ""
    var color :String = ""
    var file_extension :String = ""
    var file_path :String = ""
    var group1_id :String = ""
    var group1_name :String = ""
    var group2_id :String = ""
    var group2_name :String = ""
    var group_type_id :String = ""
    var group_type_name :String = ""
    var level_key :String = ""
    var level_name :String = ""
    var phase_short_code :String = ""
    var phase_zone_block_cluster_no :String = ""
    var phase_zone_block_no :String = ""
    var phase_zone_no :String = ""
    var platform_code_system :String = ""
    var platform_name :String = ""
    var projects_profile_id :String = ""
    var projects_supervision_id :String = ""
    var projects_work_area_id :String = ""
    var result_code :String = ""
    var template_id :String = ""
    var template_name :String = ""
    var transaction_key :String = ""
    var transaction_request_id :String = ""
    var transaction_request_last_step :String = ""
    var transactions_date_h :String = ""
    var transactions_date_m :String = ""
    var unit_id :String = ""
    
    
  
    init(_ Obj : [String:Any]) {
        
       
        self.barcode = Obj["barcode"] as? String ?? ""
        self.color = Obj["color"] as? String ?? ""
        self.file_extension = Obj["file_extension"] as? String ?? ""
        self.file_path = Obj["file_path"] as? String ?? ""
        self.group1_id = Obj["group1_id"] as? String ?? ""
        self.group1_name = Obj["group1_name"] as? String ?? ""
        self.group2_id = Obj["group2_id"] as? String ?? ""
        self.group2_name = Obj["group2_name"] as? String ?? ""
        self.group_type_id = Obj["group_type_id"] as? String ?? ""
        self.group_type_name = Obj["group_type_name"] as? String ?? ""
        self.level_key = Obj["level_key"] as? String ?? ""
        self.level_name = Obj["level_name"] as? String ?? ""
        self.phase_short_code = Obj["phase_short_code"] as? String ?? ""
        self.phase_zone_block_cluster_no = Obj["phase_zone_block_cluster_no"] as? String ?? ""
        self.phase_zone_block_no = Obj["phase_zone_block_no"] as? String ?? ""
        self.phase_zone_no = Obj["phase_zone_no"] as? String ?? ""
        self.platform_code_system = Obj["platform_code_system"] as? String ?? ""
        self.platform_name = Obj["platform_name"] as? String ?? ""
        self.projects_profile_id = Obj["projects_profile_id"] as? String ?? ""
        self.projects_supervision_id = Obj["projects_supervision_id"] as? String ?? ""
        self.projects_work_area_id = Obj["projects_work_area_id"] as? String ?? ""
        self.result_code = Obj["result_code"] as? String ?? ""
        self.template_id = Obj["template_id"] as? String ?? ""
        self.template_name = Obj["template_name"] as? String ?? ""
        self.transaction_key = Obj["transaction_key"] as? String ?? ""
        self.transaction_request_id = Obj["transaction_request_id"] as? String ?? ""
        self.transaction_request_last_step = Obj["transaction_request_last_step"] as? String ?? ""
        self.transactions_date_h = Obj["transactions_date_h"] as? String ?? ""
        self.transactions_date_m = Obj["transactions_date_m"] as? String ?? ""
        self.unit_id = Obj["unit_id"] as? String ?? ""

    }
}


class FilterObj {

    var filter_column1_key :String = ""
    var filter_column1_val :String = ""
    var filter_column2_key :String = ""
    var filter_column2_val :String = ""
    var filter_id :String = ""
    var filter_key :String = ""
    var filter_name :String = ""
    var fliter_selected :String = ""
    var filter_by :[String:Any] = [:]
    var sort_by :[String:Any] = [:]
    
    
  
    init(_ Obj : [String:Any]) {
        
        self.filter_column1_key = Obj["filter_column1_key"] as? String ?? ""
        self.filter_column1_val = Obj["filter_column1_val"] as? String ?? ""
        self.filter_column2_key = Obj["filter_column2_key"] as? String ?? ""
        self.filter_column2_val = Obj["filter_column2_val"] as? String ?? ""
        self.filter_id = Obj["filter_id"] as? String ?? ""
        self.filter_key = Obj["filter_key"] as? String ?? ""
        self.filter_name = Obj["filter_name"] as? String ?? ""
        self.fliter_selected = Obj["fliter_selected"] as? String ?? ""
        self.filter_by = Obj["filter_by"] as? [String:Any] ?? [:]
        self.sort_by = Obj["sort_by"] as? [String:Any] ?? [:]
        
     
    }
}



class filter_byObj {
    
    
    var group1 :[labelObj] = []
    var group2 :[labelObj] = []
    var template :[labelObj] = []
    var group_type :[labelObj] = []
    var block :[labelObj] = []
    var cluster :[labelObj] = []
    var zone :[labelObj] = []
    
    var barcode :String = ""
    var unit_id :String = ""
    var version :String = ""
    var level_key :String = ""
    var result_code :String = ""
    var phase_short_code :String = ""
    var platform_code_system :String = ""
    var transaction_end_date :String = ""
    var transaction_request_id :String = ""
    var transaction_start_date :String = ""
    
    
  
    init(_ Obj : [String:Any]) {
        
        
        let group1_Array = Obj["group1"] as? [[String:Any]] ?? []
        self.group1      = group1_Array.map{labelObj.init($0)}
        
        let group2_Array = Obj["group2"] as? [[String:Any]] ?? []
        self.group2      = group2_Array.map{labelObj.init($0)}
        
        let template_Array  = Obj["template"] as? [[String:Any]] ?? []
        self.template       = template_Array.map{labelObj.init($0)}
        
        let group_type_Array = Obj["group_type"] as? [[String:Any]] ?? []
        self.group_type   = group_type_Array.map{labelObj.init($0)}
        
        let block_Array = Obj["block"] as? [[String:Any]] ?? []
        self.block  = block_Array.map{labelObj.init($0)}
        
        let cluster_Array = Obj["cluster"] as? [[String:Any]] ?? []
        self.cluster  = cluster_Array.map{labelObj.init($0)}
        
        let zone_Array = Obj["zone"] as? [[String:Any]] ?? []
        self.zone  = zone_Array.map{labelObj.init($0)}
        
        
        self.barcode = Obj["barcode"] as? String ?? ""
        self.unit_id = Obj["unit_id"] as? String ?? ""
        self.version = Obj["version"] as? String ?? ""
        self.level_key = Obj["level_key"] as? String ?? ""
        self.result_code = Obj["result_code"] as? String ?? ""
        self.phase_short_code = Obj["phase_short_code"] as? String ?? ""
        self.platform_code_system = Obj["platform_code_system"] as? String ?? ""
        self.transaction_end_date = Obj["transaction_end_date"] as? String ?? ""
        self.transaction_request_id = Obj["transaction_request_id"] as? String ?? ""
        self.transaction_start_date = Obj["transaction_start_date"] as? String ?? ""
        
      
     
    }
}


struct labelObj {
    
    var id : String = ""
    var label : String = ""
    
    init(_ Obj : [String:Any]) {
    self.id = Obj["id"] as? String ?? ""
    self.label = Obj["label"] as? String ?? ""
    }
}


class sort_byObj {
    
    
    var zone :String = ""
    var block :String = ""
    var barcode :String = ""
    var cluster :String = ""
    var template_id :String = ""
    var platform_code_system :String = ""
    var transaction_request_id :String = ""
    
    init(_ Obj : [String:Any]) {
        
        self.zone = Obj["zone"] as? String ?? ""
        self.block = Obj["block"] as? String ?? ""
        self.barcode = Obj["barcode"] as? String ?? ""
        self.cluster = Obj["cluster"] as? String ?? ""
        self.template_id = Obj["template_id"] as? String ?? ""
        self.platform_code_system = Obj["platform_code_system"] as? String ?? ""
        self.transaction_request_id = Obj["transaction_request_id"] as? String ?? ""
        
    }
}

class PhaseObj {
    
    var hasChildren :String = ""
    var id :String = ""
    var label :String = ""
    var name :String = ""
    var phase_created_datetime :String = ""
    var phase_id :String = ""
    var phase_parent_id :String = ""
    var phase_short_code :String = ""
    var phase_title_ar :String = ""
    var phase_title_en :String = ""
    var phase_type :String = ""
    var phase_updated_datetime :String = ""
    var phase_writer :String = ""
    var phase_zone_block_cluster_g_no :String = ""
    var phase_zone_block_cluster_no :String = ""
    var phase_zone_block_cluster_unit_no :String = ""
    var phase_zone_block_no :String = ""
    var phase_zone_custom_title :String = ""
    var phase_zone_no :String = ""
    var projects_profile_id :String = ""
    var projects_supervision_id :String = ""
    var transaction_request_id :String = ""
    var unit_opening_balance :String = ""
    var v_start :String = ""
    var value :String = ""
    var writer :String = ""
    
    
   
    init(_ Obj : [String:Any]) {
        
        self.hasChildren  = Obj["hasChildren"] as? String ?? ""
        self.id  = Obj["id"] as? String ?? ""
        self.label  = Obj["label"] as? String ?? ""
        self.name  = Obj["name"] as? String ?? ""
        self.phase_created_datetime  = Obj["phase_created_datetime"] as? String ?? ""
        self.phase_id  = Obj["phase_id"] as? String ?? ""
        self.phase_parent_id  = Obj["phase_parent_id"] as? String ?? ""
        self.phase_short_code  = Obj["phase_short_code"] as? String ?? ""
        self.phase_title_ar  = Obj["phase_title_ar"] as? String ?? ""
        self.phase_title_en  = Obj["phase_title_en"] as? String ?? ""
        self.phase_type  = Obj["phase_type"] as? String ?? ""
        self.phase_updated_datetime  = Obj["phase_updated_datetime"] as? String ?? ""
        self.phase_writer  = Obj["phase_writer"] as? String ?? ""
        self.phase_zone_block_cluster_g_no  = Obj["phase_zone_block_cluster_g_no"] as? String ?? ""
        self.phase_zone_block_cluster_no  = Obj["phase_zone_block_cluster_no"] as? String ?? ""
        self.phase_zone_block_cluster_unit_no  = Obj["phase_zone_block_cluster_unit_no"] as? String ?? ""
        self.phase_zone_block_no  = Obj["phase_zone_block_no"] as? String ?? ""
        self.phase_zone_custom_title  = Obj["phase_zone_custom_title"] as? String ?? ""
        self.phase_zone_no  = Obj["phase_zone_no"] as? String ?? ""
        self.projects_profile_id  = Obj["projects_profile_id"] as? String ?? ""
        self.projects_supervision_id  = Obj["projects_supervision_id"] as? String ?? ""
        self.transaction_request_id  = Obj["transaction_request_id"] as? String ?? ""
        self.unit_opening_balance  = Obj["unit_opening_balance"] as? String ?? ""
        self.v_start  = Obj["v_start"] as? String ?? ""
        self.value  = Obj["value"] as? String ?? ""
        self.writer  = Obj["writer"] as? String ?? ""
        
       
        
    }}


class SupplierObj {
    
    var label                  :String = ""
    var result                 :String = ""
    var transaction_request_id :String = ""
    var value                  :String = ""
    
    init(_ Obj : [String:Any]) {
        self.label                   = Obj["label"] as? String ?? ""
        self.result                  = Obj["result"] as? String ?? ""
        self.transaction_request_id  = Obj["transaction_request_id"] as? String ?? ""
        self.value                   = Obj["value"] as? String ?? ""
    }}




class ProfileObj {
    
    
    var account_number  :String = ""
    var age_in_years  :String = ""
    var bank_short_code  :String = ""
    var bankname  :String = ""
    var birth_date_arabic  :String = ""
    var birth_date_english  :String = ""
    var branch_id  :String = ""
    var branch_name  :String = ""
    var copy_number  :String = ""
    var countryname  :String = ""
    var created_datetime  :String = ""
    var e_reference_no  :String = ""
    var employee_id_number  :String = ""
    var employee_number  :String = ""
    var employee_status  :String = ""
    var employee_title  :String = ""
    var employee_title_name  :String = ""
    var employee_writer  :String = ""
    var firstname_arabic  :String = ""
    var firstname_english  :String = ""
    var gender  :String = ""
    var insurance_date  :String = ""
    var insurance_number  :String = ""
    var insurance_type_class  :String = ""
    var interview_date_ar  :String = ""
    var interview_date_en  :String = ""
    var iqama_expiry_date_arabic  :String = ""
    var iqama_expiry_date_english  :String = ""
    var job_descriptions  :String = ""
    var job_title_id  :String = ""
    var job_title_iqama  :String = ""
    var jobname  :String = ""
    var lastname_arabic  :String = ""
    var lastname_english  :String = ""
    var marital_status  :String = ""
    var mark  :String = ""
    var membership_expiry_date_arabic  :String = ""
    var membership_expiry_date_english  :String = ""
    var membership_number  :String = ""
    var nationality  :String = ""
    var passport_expiry_date_arabic  :String = ""
    var passport_expiry_date_english  :String = ""
    var passport_issue_date_arabic  :String = ""
    var passport_issue_date_english  :String = ""
    var passport_issue_place  :String = ""
    var passport_number  :String = ""
    var primary_address  :String = ""
    var primary_education_level  :String = ""
    var primary_email  :String = ""
    var primary_graduation_year  :String = ""
    var primary_mobile  :String = ""
    var profile_image  :String = ""
    var rating_degree  :String = ""
    var religion  :String = ""
    var secondname_arabic  :String = ""
    var secondname_english  :String = ""
    var settings_name_arabic  :String = ""
    var settings_name_english  :String = ""
    var signature  :String = ""
    var terms_conditions  :String = ""
    var thirdname_arabic  :String = ""
    var thirdname_english  :String = ""
    var typename  :String = ""
    var updated_datetime  :String = ""
    var user_email  :String = ""
    var user_id  :String = ""
    var user_phone  :String = ""
    var user_type_id  :String = ""
    var username  :String = ""
    var work_domain  :String = ""
    var work_location  :String = ""
    var work_type  :String = ""
    
    
    
    init(_ Obj : [String:Any]) {
        
        self.account_number  = Obj["account_number"] as? String ?? ""
        self.age_in_years  = Obj["age_in_years"] as? String ?? ""
        self.bank_short_code  = Obj["bank_short_code"] as? String ?? ""
        self.bankname  = Obj["bankname"] as? String ?? ""
        self.birth_date_arabic  = Obj["birth_date_arabic"] as? String ?? ""
        self.birth_date_english  = Obj["birth_date_english"] as? String ?? ""
        self.branch_id  = Obj["branch_id"] as? String ?? ""
        self.branch_name  = Obj["branch_name"] as? String ?? ""
        self.copy_number  = Obj["copy_number"] as? String ?? ""
        self.countryname  = Obj["countryname"] as? String ?? ""
        self.created_datetime  = Obj["created_datetime"] as? String ?? ""
        self.e_reference_no  = Obj["e_reference_no"] as? String ?? ""
        self.employee_id_number  = Obj["employee_id_number"] as? String ?? ""
        self.employee_number  = Obj["employee_number"] as? String ?? ""
        self.employee_status  = Obj["employee_status"] as? String ?? ""
        self.employee_title  = Obj["employee_title"] as? String ?? ""
        self.employee_title_name  = Obj["employee_title_name"] as? String ?? ""
        self.employee_writer  = Obj["employee_writer"] as? String ?? ""
        self.firstname_arabic  = Obj["firstname_arabic"] as? String ?? ""
        self.firstname_english  = Obj["firstname_english"] as? String ?? ""
        self.gender  = Obj["gender"] as? String ?? ""
        self.insurance_date  = Obj["insurance_date"] as? String ?? ""
        self.insurance_number  = Obj["insurance_number"] as? String ?? ""
        self.insurance_type_class  = Obj["insurance_type_class"] as? String ?? ""
        self.interview_date_ar  = Obj["interview_date_ar"] as? String ?? ""
        self.interview_date_en  = Obj["interview_date_en"] as? String ?? ""
        self.iqama_expiry_date_arabic  = Obj["iqama_expiry_date_arabic"] as? String ?? ""
        self.iqama_expiry_date_english  = Obj["iqama_expiry_date_english"] as? String ?? ""
        self.job_descriptions  = Obj["job_descriptions"] as? String ?? ""
        self.job_title_id  = Obj["job_title_id"] as? String ?? ""
        self.job_title_iqama  = Obj["job_title_iqama"] as? String ?? ""
        self.jobname  = Obj["jobname"] as? String ?? ""
        self.lastname_arabic  = Obj["lastname_arabic"] as? String ?? ""
        self.lastname_english  = Obj["lastname_english"] as? String ?? ""
        self.marital_status  = Obj["marital_status"] as? String ?? ""
        self.mark  = Obj["mark"] as? String ?? ""
        self.membership_expiry_date_arabic  = Obj["membership_expiry_date_arabic"] as? String ?? ""
        self.membership_expiry_date_english  = Obj["membership_expiry_date_english"] as? String ?? ""
        self.membership_number  = Obj["membership_number"] as? String ?? ""
        self.nationality  = Obj["nationality"] as? String ?? ""
        self.passport_expiry_date_arabic  = Obj["passport_expiry_date_arabic"] as? String ?? ""
        self.passport_expiry_date_english  = Obj["passport_expiry_date_english"] as? String ?? ""
        self.passport_issue_date_arabic  = Obj["passport_issue_date_arabic"] as? String ?? ""
        self.passport_issue_date_english  = Obj["passport_issue_date_english"] as? String ?? ""
        self.passport_issue_place  = Obj["passport_issue_place"] as? String ?? ""
        self.passport_number  = Obj["passport_number"] as? String ?? ""
        self.primary_address  = Obj["primary_address"] as? String ?? ""
        self.primary_education_level  = Obj["primary_education_level"] as? String ?? ""
        self.primary_email  = Obj["primary_email"] as? String ?? ""
        self.primary_graduation_year  = Obj["primary_graduation_year"] as? String ?? ""
        self.primary_mobile  = Obj["primary_mobile"] as? String ?? ""
        self.profile_image  = Obj["profile_image"] as? String ?? ""
        self.rating_degree  = Obj["rating_degree"] as? String ?? ""
        self.religion  = Obj["religion"] as? String ?? ""
        self.secondname_arabic  = Obj["secondname_arabic"] as? String ?? ""
        self.secondname_english  = Obj["secondname_english"] as? String ?? ""
        self.settings_name_arabic  = Obj["settings_name_arabic"] as? String ?? ""
        self.settings_name_english  = Obj["settings_name_english"] as? String ?? ""
        self.signature  = Obj["signature"] as? String ?? ""
        self.terms_conditions  = Obj["terms_conditions"] as? String ?? ""
        self.thirdname_arabic  = Obj["thirdname_arabic"] as? String ?? ""
        self.thirdname_english  = Obj["thirdname_english"] as? String ?? ""
        self.typename  = Obj["typename"] as? String ?? ""
        self.updated_datetime  = Obj["updated_datetime"] as? String ?? ""
        self.user_email  = Obj["user_email"] as? String ?? ""
        self.user_id  = Obj["user_id"] as? String ?? ""
        self.user_phone  = Obj["user_phone"] as? String ?? ""
        self.user_type_id  = Obj["user_type_id"] as? String ?? ""
        self.username  = Obj["username"] as? String ?? ""
        self.work_domain  = Obj["work_domain"] as? String ?? ""
        self.work_location  = Obj["work_location"] as? String ?? ""
        self.work_type  = Obj["work_type"] as? String ?? ""
        
        
    }}



class ContractObj {
    
    var basic_salary :String = ""
    var contract_approved_date_arabic :String = ""
    var contract_approved_date_english :String = ""
    var contract_attachment :String = ""
    var contract_end_date_arabic :String = ""
    var contract_end_date_english :String = ""
    var contract_id :String = ""
    var contract_period :String = ""
    var contract_start_date_arabic :String = ""
    var contract_start_date_english :String = ""
    var contract_status :String = ""
    var contract_writer :String = ""
    var employee_number :String = ""
    var file_records_id :String = ""
    var first_party_user :String = ""
    var home_allowance :String = ""
    var joining_date_arabic :String = ""
    var joining_date_english :String = ""
    var net_amount :String = ""
    var probation_expiry_date_arabic :String = ""
    var probation_expiry_date_english :String = ""
    var probation_period :String = ""
    var second_party_user :String = ""
    var subject :String = ""
    var tbv_count :String = ""
    var transaction_key :String = ""
    var transaction_request_id :String = ""
    var upcoming_vacation_date_arabic :String = ""
    var upcoming_vacation_date_english :String = ""
    var upcoming_vacation_end_date_arabic :String = ""
    var upcoming_vacation_end_date_english :String = ""
    var vacation_paid_days :String = ""
    var vacation_paid_days_only :String = ""
    var work_domain :String = ""
    var work_location :String = ""
    var work_type :String = ""
    var working_days_per_week :String = ""
    var working_hours_per_day :String = ""
    var writer :String = ""

    
    
    
    init(_ Obj : [String:Any]) {
        
        self.basic_salary = Obj["basic_salary"] as? String ?? ""
        self.contract_approved_date_arabic = Obj["contract_approved_date_arabic"] as? String ?? ""
        self.contract_approved_date_english = Obj["contract_approved_date_english"] as? String ?? ""
        self.contract_attachment = Obj["contract_attachment"] as? String ?? ""
        self.contract_end_date_arabic = Obj["contract_end_date_arabic"] as? String ?? ""
        self.contract_end_date_english = Obj["contract_end_date_english"] as? String ?? ""
        self.contract_id = Obj["contract_id"] as? String ?? ""
        self.contract_period = Obj["contract_period"] as? String ?? ""
        self.contract_start_date_arabic = Obj["contract_start_date_arabic"] as? String ?? ""
        self.contract_start_date_english = Obj["contract_start_date_english"] as? String ?? ""
        self.contract_status = Obj["contract_status"] as? String ?? ""
        self.contract_writer = Obj["contract_writer"] as? String ?? ""
        self.employee_number = Obj["employee_number"] as? String ?? ""
        self.file_records_id = Obj["file_records_id"] as? String ?? ""
        self.first_party_user = Obj["first_party_user"] as? String ?? ""
        self.home_allowance = Obj["home_allowance"] as? String ?? ""
        self.joining_date_arabic = Obj["joining_date_arabic"] as? String ?? ""
        self.joining_date_english = Obj["joining_date_english"] as? String ?? ""
        self.net_amount = Obj["net_amount"] as? String ?? ""
        self.probation_expiry_date_arabic = Obj["probation_expiry_date_arabic"] as? String ?? ""
        self.probation_expiry_date_english = Obj["probation_expiry_date_english"] as? String ?? ""
        self.probation_period = Obj["probation_period"] as? String ?? ""
        self.second_party_user = Obj["second_party_user"] as? String ?? ""
        self.subject = Obj["subject"] as? String ?? ""
        self.tbv_count = Obj["tbv_count"] as? String ?? ""
        self.transaction_key = Obj["transaction_key"] as? String ?? ""
        self.transaction_request_id = Obj["transaction_request_id"] as? String ?? ""
        self.upcoming_vacation_date_arabic = Obj["upcoming_vacation_date_arabic"] as? String ?? ""
        self.upcoming_vacation_date_english = Obj["upcoming_vacation_date_english"] as? String ?? ""
        self.upcoming_vacation_end_date_arabic = Obj["upcoming_vacation_end_date_arabic"] as? String ?? ""
        self.upcoming_vacation_end_date_english = Obj["upcoming_vacation_end_date_english"] as? String ?? ""
        self.vacation_paid_days = Obj["vacation_paid_days"] as? String ?? ""
        self.vacation_paid_days_only = Obj["vacation_paid_days_only"] as? String ?? ""
        self.work_domain = Obj["work_domain"] as? String ?? ""
        self.work_location = Obj["work_location"] as? String ?? ""
        self.work_type = Obj["work_type"] as? String ?? ""
        self.working_days_per_week = Obj["working_days_per_week"] as? String ?? ""
        self.working_hours_per_day = Obj["working_hours_per_day"] as? String ?? ""
        self.writer = Obj["writer"] as? String ?? ""
        
      
    }}


class JobDetailsObj {
     
    var created_datetime :String = ""
    var employee_number :String = ""
    var job_descriptions :String = ""
    var name :String = ""
    var position_id :String = ""
    var position_writer :String = ""
    var postition_name :String = ""
    var settings_id :String = ""
    var settings_need_licence :String = ""
     
    init(_ Obj : [String:Any]) {
        
        self.created_datetime = Obj["created_datetime"] as? String ?? ""
        self.employee_number = Obj["employee_number"] as? String ?? ""
        self.job_descriptions = Obj["job_descriptions"] as? String ?? ""
        self.name = Obj["name"] as? String ?? ""
        self.position_id = Obj["position_id"] as? String ?? ""
        self.position_writer = Obj["position_writer"] as? String ?? ""
        self.postition_name = Obj["postition_name"] as? String ?? ""
        self.settings_id = Obj["settings_id"] as? String ?? ""
        self.settings_need_licence = Obj["settings_need_licence"] as? String ?? ""
        
      
    }}



class CommunicationsObj {
    
    
    var branch_id :String = ""
    var communication_date_h :String = ""
    var communication_date_m :String = ""
    var communication_from :String = ""
    var communication_from_name :String = ""
    var communication_id :String = ""
    var communication_subject :String = ""
    var communication_to :String = ""
    var communication_to_name :String = ""
    var communication_types_id :String = ""
    var communication_types_name :String = ""
    var communication_user_id_writer :String = ""
    var communication_user_name_writer :String = ""
    var file_extension :String = ""
    var file_path :String = ""
    var file_records_id :String = ""
    var file_size :String = ""
    var module_key :String = ""
    var modules_name :String = ""
    var tbv_auth :String = ""
    var tbv_barcodeData :String = ""
    var tbv_barcodeKey :String = ""
    var tbv_count :String = ""
    var tbv_id :String = ""
    var tbv_version :String = ""
    var transaction_key :String = ""
    var transaction_request_id :String = ""
    var transactions_submitter_user_name :String = ""
    var transactions_types_id :String = ""
    var transactions_types_name :String = ""
    
    
    
    init(_ Obj : [String:Any]) {
        
        self.branch_id = Obj["branch_id"] as? String ?? ""
        self.communication_date_h = Obj["communication_date_h"] as? String ?? ""
        self.communication_date_m = Obj["communication_date_m"] as? String ?? ""
        self.communication_from = Obj["communication_from"] as? String ?? ""
        self.communication_from_name = Obj["communication_from_name"] as? String ?? ""
        self.communication_id = Obj["communication_id"] as? String ?? ""
        self.communication_subject = Obj["communication_subject"] as? String ?? ""
        self.communication_to = Obj["communication_to"] as? String ?? ""
        self.communication_to_name = Obj["communication_to_name"] as? String ?? ""
        self.communication_types_id = Obj["communication_types_id"] as? String ?? ""
        self.communication_types_name = Obj["communication_types_name"] as? String ?? ""
        self.communication_user_id_writer = Obj["communication_user_id_writer"] as? String ?? ""
        self.communication_user_name_writer = Obj["communication_user_name_writer"] as? String ?? ""
        self.file_extension = Obj["file_extension"] as? String ?? ""
        self.file_path = Obj["file_path"] as? String ?? ""
        self.file_records_id = Obj["file_records_id"] as? String ?? ""
        self.file_size = Obj["file_size"] as? String ?? ""
        self.module_key = Obj["module_key"] as? String ?? ""
        self.modules_name = Obj["modules_name"] as? String ?? ""
        self.tbv_auth = Obj["tbv_auth"] as? String ?? ""
        self.tbv_barcodeData = Obj["tbv_barcodeData"] as? String ?? ""
        self.tbv_barcodeKey = Obj["tbv_barcodeKey"] as? String ?? ""
        self.tbv_count = Obj["tbv_count"] as? String ?? ""
        self.tbv_id = Obj["tbv_id"] as? String ?? ""
        self.tbv_version = Obj["tbv_version"] as? String ?? ""
        self.transaction_key = Obj["transaction_key"] as? String ?? ""
        self.transaction_request_id = Obj["transaction_request_id"] as? String ?? ""
        self.transactions_submitter_user_name = Obj["transactions_submitter_user_name"] as? String ?? ""
        self.transactions_types_id = Obj["transactions_types_id"] as? String ?? ""
        self.transactions_types_name = Obj["transactions_types_name"] as? String ?? ""
        
      
    }}


class EducationObj {
    
    var education_certification_file :String = ""
    var education_createddatetime :String = ""
    var education_descriptions :String = ""
    var education_end_date :String = ""
    var education_id :String = ""
    var education_start_date :String = ""
    var education_title :String = ""
    var education_updateddatetime :String = ""
    var education_writer :String = ""
    var employee_number :String = ""
    var name :String = ""
    
    
    init(_ Obj : [String:Any]) {
        
        self.education_certification_file = Obj["education_certification_file"] as? String ?? ""
        self.education_createddatetime = Obj["education_createddatetime"] as? String ?? ""
        self.education_descriptions = Obj["education_descriptions"] as? String ?? ""
        self.education_end_date = Obj["education_end_date"] as? String ?? ""
        self.education_id = Obj["education_id"] as? String ?? ""
        self.education_start_date = Obj["education_start_date"] as? String ?? ""
        self.education_title = Obj["education_title"] as? String ?? ""
        self.education_updateddatetime = Obj["education_updateddatetime"] as? String ?? ""
        self.education_writer = Obj["education_writer"] as? String ?? ""
        self.employee_number = Obj["employee_number"] as? String ?? ""
        self.name = Obj["name"] as? String ?? ""
        
        
    }}



class InsuranceObj {
    
    var employee_number :String = ""
    var insurance_dependent_createddate :String = ""
    var insurance_dependent_date :String = ""
    var insurance_dependent_id :String = ""
    var insurance_dependent_ins_no :String = ""
    var insurance_dependent_name :String = ""
    var insurance_dependent_number :String = ""
    var insurance_dependent_reaplationship :String = ""
    var insurance_dependent_type :String = ""
    var insurance_dependent_updatedate :String = ""
    var insurance_dependent_writer :String = ""
    var name :String = ""
    
    
    init(_ Obj : [String:Any]) {
        
        self.employee_number = Obj["employee_number"] as? String ?? ""
        self.insurance_dependent_createddate = Obj["insurance_dependent_createddate"] as? String ?? ""
        self.insurance_dependent_date = Obj["insurance_dependent_date"] as? String ?? ""
        self.insurance_dependent_id = Obj["insurance_dependent_id"] as? String ?? ""
        self.insurance_dependent_ins_no = Obj["insurance_dependent_ins_no"] as? String ?? ""
        self.insurance_dependent_name = Obj["insurance_dependent_name"] as? String ?? ""
        self.insurance_dependent_number = Obj["insurance_dependent_number"] as? String ?? ""
        self.insurance_dependent_reaplationship = Obj["insurance_dependent_reaplationship"] as? String ?? ""
        self.insurance_dependent_type = Obj["insurance_dependent_type"] as? String ?? ""
        self.insurance_dependent_updatedate = Obj["insurance_dependent_updatedate"] as? String ?? ""
        self.insurance_dependent_writer = Obj["insurance_dependent_writer"] as? String ?? ""
        self.name = Obj["name"] as? String ?? ""
        
    }}



class VactionObj {
    
    var approved_status :String = ""
    var link :String = ""
    var preview_link :String = ""
    var vacation_end_date_english :String = ""
    var vacation_id :String = ""
    var vacation_start_date_english :String = ""
    var vacation_total_days :String = ""
    var vacation_type_name :String = ""
    var writer_name :String = ""
    
    
    init(_ Obj : [String:Any]) {
        
        
        self.approved_status = Obj["approved_status"] as? String ?? ""
        self.link = Obj["link"] as? String ?? ""
        self.preview_link = Obj["preview_link"] as? String ?? ""
        self.vacation_end_date_english = Obj["vacation_end_date_english"] as? String ?? ""
        self.vacation_id = Obj["vacation_id"] as? String ?? ""
        self.vacation_start_date_english = Obj["vacation_start_date_english"] as? String ?? ""
        self.vacation_total_days = Obj["vacation_total_days"] as? String ?? ""
        self.vacation_type_name = Obj["vacation_type_name"] as? String ?? ""
        self.writer_name = Obj["writer_name"] as? String ?? ""
        
        
    }}


class ProfileNoteObj {
    
   
    var link_with_view_list :String = ""
    var name :String = ""
    var note_created_date :String = ""
    var note_description :String = ""
    var note_id :String = ""
    var note_module :String = ""
    var note_remainder_date :String = ""
    var note_remainder_status :String = ""
    var note_updated_date :String = ""
    var note_writer :String = ""
    var show_status :String = ""
    var table_key1 :String = ""
    var table_key2 :String = ""
    var table_value1 :String = ""
    var table_value2 :String = ""
    
    
    init(_ Obj : [String:Any]) {
        
        
        self.link_with_view_list = Obj["link_with_view_list"] as? String ?? ""
        self.name = Obj["name"] as? String ?? ""
        self.note_created_date = Obj["note_created_date"] as? String ?? ""
        self.note_description = Obj["note_description"] as? String ?? ""
        self.note_id = Obj["note_id"] as? String ?? ""
        self.note_module = Obj["note_module"] as? String ?? ""
        self.note_remainder_date = Obj["note_remainder_date"] as? String ?? ""
        self.note_remainder_status = Obj["note_remainder_status"] as? String ?? ""
        self.note_updated_date = Obj["note_updated_date"] as? String ?? ""
        self.note_writer = Obj["note_writer"] as? String ?? ""
        self.show_status = Obj["show_status"] as? String ?? ""
        self.table_key1 = Obj["table_key1"] as? String ?? ""
        self.table_key2 = Obj["table_key2"] as? String ?? ""
        self.table_value1 = Obj["table_value1"] as? String ?? ""
        self.table_value2 = Obj["table_value2"] as? String ?? ""
         
        
    }}


class attachmentObj {
      
    var attachment_link :String = ""
    var created_datetime :String = ""
    var file_extension :String = ""
    var file_name :String = ""
    var file_name_ar :String = ""
    var file_name_en :String = ""
    var file_path :String = ""
    var file_records_id :String = ""
    var file_size :String = ""
    var key_code :String = ""
    var level_keys :String = ""
    var module_key :String = ""
    var type_name :String = ""
    var user_id_writer :String = ""
    var writer :String = ""
    
    init(_ Obj : [String:Any]) {
        
        
        self.attachment_link = Obj["attachment_link"] as? String ?? ""
        self.created_datetime = Obj["created_datetime"] as? String ?? ""
        self.file_extension = Obj["file_extension"] as? String ?? ""
        self.file_name = Obj["file_name"] as? String ?? ""
        self.file_name_ar = Obj["file_name_ar"] as? String ?? ""
        self.file_name_en = Obj["file_name_en"] as? String ?? ""
        self.file_path = Obj["file_path"] as? String ?? ""
        self.file_records_id = Obj["file_records_id"] as? String ?? ""
        self.file_size = Obj["file_size"] as? String ?? ""
        self.key_code = Obj["key_code"] as? String ?? ""
        self.level_keys = Obj["level_keys"] as? String ?? ""
        self.module_key = Obj["module_key"] as? String ?? ""
        self.type_name = Obj["type_name"] as? String ?? ""
        self.user_id_writer = Obj["user_id_writer"] as? String ?? ""
        self.writer = Obj["writer"] as? String ?? ""
         
        
    }}

class ModulesObj {
      
    var branch_id :String = ""
    var create_by_user_id :String = ""
    var create_date :String = ""
    var group_key :String = ""
    var mention_id :String = ""
    var module_key :String = ""
    var modulename :String = ""
    var permission_key :String = ""
    var private_key :String = ""
    var private_value :String = ""
    var user_id :String = ""
    var user_type_id :String = ""
    var writer :String = ""
    
    
    
    
    init(_ Obj : [String:Any]) {
        
        
        self.branch_id = Obj["branch_id"] as? String ?? ""
        self.create_by_user_id = Obj["create_by_user_id"] as? String ?? ""
        self.create_date = Obj["create_date"] as? String ?? ""
        self.group_key = Obj["group_key"] as? String ?? ""
        self.mention_id = Obj["mention_id"] as? String ?? ""
        self.module_key = Obj["module_key"] as? String ?? ""
        self.modulename = Obj["modulename"] as? String ?? ""
        self.permission_key = Obj["permission_key"] as? String ?? ""
        self.private_key = Obj["private_key"] as? String ?? ""
        self.private_value = Obj["private_value"] as? String ?? ""
        self.user_id = Obj["user_id"] as? String ?? ""
        self.user_type_id = Obj["user_type_id"] as? String ?? ""
        self.writer = Obj["writer"] as? String ?? ""
         
        
    }}


class moduleObj {
    
    var module_default:String = ""
    var module_enabled:String = ""
    var module_key:String = ""
    var module_phrase_key:String = ""
    var module_phrase_val:String = ""
    var module_primary_tabke_key:String = ""
    var module_primary_table:String = ""
    var module_primary_table_field:String = ""
    var module_version:String = ""
    
    
    
    init(_ Obj : [String:Any]) {
        
        self.module_default = Obj["module_default"] as? String ?? ""
        self.module_enabled = Obj["module_enabled"] as? String ?? ""
        self.module_key = Obj["module_key"] as? String ?? ""
        self.module_phrase_key = Obj["module_phrase_key"] as? String ?? ""
        self.module_phrase_val = Obj["module_phrase_val"] as? String ?? ""
        self.module_primary_tabke_key = Obj["module_primary_tabke_key"] as? String ?? ""
        self.module_primary_table = Obj["module_primary_table"] as? String ?? ""
        self.module_primary_table_field = Obj["module_primary_table_field"] as? String ?? ""
        self.module_version = Obj["module_version"] as? String ?? ""
        
        
    }}


class ProfileContactObj {
     
    var contact_address_text :String = ""
    var contact_createddatetime :String = ""
    var contact_email_address :String = ""
    var contact_id :String = ""
    var contact_mobile_number :String = ""
    var contact_person_name :String = ""
    var contact_updateddatetime :String = ""
    var contact_writer :String = ""
    var employee_number :String = ""
    var name :String = ""
     
    
    init(_ Obj : [String:Any]) {
         
        self.contact_address_text = Obj["contact_address_text"] as? String ?? ""
        self.contact_createddatetime = Obj["contact_createddatetime"] as? String ?? ""
        self.contact_email_address = Obj["contact_email_address"] as? String ?? ""
        self.contact_id = Obj["contact_id"] as? String ?? ""
        self.contact_mobile_number = Obj["contact_mobile_number"] as? String ?? ""
        self.contact_person_name = Obj["contact_person_name"] as? String ?? ""
        self.contact_updateddatetime = Obj["contact_updateddatetime"] as? String ?? ""
        self.contact_writer = Obj["contact_writer"] as? String ?? ""
        self.employee_number = Obj["employee_number"] as? String ?? ""
        self.name = Obj["name"] as? String ?? ""
         
    }}


class ModuleUsersObj {
    
    var groupname :String = ""
    var module_key :String = ""
    var name :String = ""
    var private_value :String = ""
    var project_group_name :String = ""
    var quotation_subject :String = ""
    var title :String = ""
    
    
    init(_ Obj : [String:Any]) {
        
        self.groupname = Obj["groupname"] as? String ?? ""
        self.module_key = Obj["module_key"] as? String ?? ""
        self.name = Obj["name"] as? String ?? ""
        self.private_value = Obj["private_value"] as? String ?? ""
        self.project_group_name = Obj["project_group_name"] as? String ?? ""
        self.quotation_subject = Obj["quotation_subject"] as? String ?? ""
        self.title = Obj["title"] as? String ?? ""
        
         
        
    }}

class TicketObj {
    
    var can_delete :Bool = false
    var can_edit :Bool = false
    var can_view :Bool = false
    var date_reply :String = "---"
    var end_date_nearly :String = "---"
    var emps :String = "---"
    var emps2 :String = "---"
    var end_date :String = "---"
    var from_ticket_name :String = ""
    var important_name :String = "---"
    var ticket_detalis :String = "---"
    var is_ticket_admin :Bool = false
    var insert_date :String = "---"
    var need_reply :String =  "---"
    var notes :String =  "---"
    var ref_model :String =  "---"
    var sig_name :String =  "---"
    var start_date :String =  "---"
    var ticket_hash :String =  "---"
    var ticket_id :String =  "---"
    var ticket_no :String =  "---"
    var ticket_old_id :String =  "---"
    var ticket_status_name :String =  "---"
    var ticket_titel :String =  "---"
    var ticket_type_name :String =  "---"
    var time_work :String =  "---"
    var user_add_id :String =  "---"
    var ticket_type :String = ""
    var important_id :String = ""
    var sig_id :String = ""
    
    init(_ Obj : [String:Any]) {
        
        self.is_ticket_admin = Obj["is_ticket_admin"] as? Bool ?? false
        self.can_delete = Obj["can_delete"] as? Bool ?? false
        self.can_edit = Obj["can_edit"] as? Bool ?? false
        self.can_view = Obj["can_view"] as? Bool ?? false
        self.end_date_nearly = Obj["end_date_nearly"] as? String ?? "---"
        self.date_reply = Obj["date_reply"] as? String ?? "---"
        self.emps = Obj["emps"] as? String ?? "---"
        self.emps2 = Obj["emps2"] as? String ?? "---"
        self.end_date = Obj["end_date"] as? String ?? "---"
        self.from_ticket_name = Obj["from_ticket_name"] as? String ?? "---"
        self.important_name = Obj["important_name"] as? String ?? "---"
        self.insert_date = Obj["insert_date"] as? String ?? "---"
        self.need_reply = Obj["need_reply"] as? String ?? "---"
        self.notes = Obj["notes"] as? String ?? "---"
        self.ref_model = Obj["ref_model"] as? String ?? "---"
        self.sig_name = Obj["sig_name"] as? String ?? "---"
        self.start_date = Obj["start_date"] as? String ?? "---"
        self.ticket_hash = Obj["ticket_hash"] as? String ?? "---"
        self.ticket_id = Obj["ticket_id"] as? String ?? "---"
        self.ticket_no = Obj["ticket_no"] as? String ?? "---"
        self.ticket_old_id = Obj["ticket_old_id"] as? String ?? "---"
        self.ticket_status_name = Obj["ticket_status_name"] as? String ?? "---"
        self.ticket_titel = Obj["ticket_titel"] as? String ?? "---"
        self.ticket_type_name = Obj["ticket_type_name"] as? String ?? "---"
        self.time_work = Obj["time_work"] as? String ?? "---"
        self.user_add_id = Obj["user_add_id"] as? String ?? "---"
        self.ticket_detalis = Obj["ticket_detalis"] as? String ?? "---"
        self.ticket_type = Obj["ticket_type"] as? String ?? ""
        self.important_id = Obj["important_id"] as? String ?? ""
        self.sig_id = Obj["sig_id"] as? String ?? ""
        
    }}

class importantObj {
     
    var name :String = ""
    var name_en :String = ""
    var id :String = ""
     
    init(_ Obj : [String:Any]) {
        
        self.name = Obj["name"] as? String ?? ""
        self.name_en = Obj["name_en"] as? String ?? ""
        self.id = Obj["id"] as? String ?? ""
        
      
    }}


class modulesObj {
     
    var module_key :String = ""
     
    init(_ Obj : [String:Any]) {
        
        self.module_key = Obj["module_key"] as? String ?? ""
        
    }}



class TaskObj {
     
    var emps :String = ""
    var end_date_nearly_ticket :String = ""
    var end_date_task :String = ""
    var end_date_ticket :String = ""
    var end_nearly_task :String = ""
    var full_task_number :String = ""
    var important_id :String = ""
    var task_status_done :String = ""
    var important_name :String = ""
    var insert_date :String = ""
    var is_can_delete :Bool = false
    var is_can_edit :Bool = false
    var is_can_view :Bool = false
    var relateds :String = ""
    var start_date_task :String = ""
    var start_date_ticket :String = ""
    var status_done_name :String = ""
    var status_name :String = ""
    var task_id :String = ""
    var task_no :String = ""
    var task_status :String = ""
    var task_time :String = ""
    var ticket_id :String = ""
    var ticket_no :String = ""
    var ticket_time :String = ""
    var title :String = ""
    var total_checked_points :String = ""
    var total_points :String = ""
    var type :String = ""
    var user_add_id :String = ""
    var start_date :String = ""
    var end_date :String = ""
    var end_nearly :String = ""
    var task_detailes :String = ""
    var progres :String = ""
    var files :[DocumentObj] = []
    var relateds_numbers:[RelatedNumbersObj] = []
    
    
    init(_ Obj : [String:Any]) {
        
        self.emps = Obj["emps"] as? String ?? ""
        self.end_date_nearly_ticket = Obj["end_date_nearly_ticket"] as? String ?? ""
        self.task_status_done = Obj["task_status_done"] as? String ?? ""
        
        self.end_date_task = Obj["end_date_task"] as? String ?? ""
        self.end_date_ticket = Obj["end_date_ticket"] as? String ?? ""
        self.end_nearly_task = Obj["end_nearly_task"] as? String ?? ""
        self.full_task_number = Obj["full_task_number"] as? String ?? ""
        self.important_id = Obj["important_id"] as? String ?? ""
        self.important_name = Obj["important_name"] as? String ?? ""
        self.insert_date = Obj["insert_date"] as? String ?? ""
        self.is_can_delete = Obj["is_can_delete"] as? Bool ?? false
        self.is_can_edit = Obj["is_can_edit"] as? Bool ?? false
        self.is_can_view = Obj["is_can_view"] as? Bool ?? false
        self.relateds = Obj["relateds"] as? String ?? ""
        self.start_date_task = Obj["start_date_task"] as? String ?? ""
        self.start_date_ticket = Obj["start_date_ticket"] as? String ?? ""
        self.status_done_name = Obj["status_done_name"] as? String ?? ""
        self.status_name = Obj["status_name"] as? String ?? ""
        self.task_id = Obj["task_id"] as? String ?? ""
        self.task_no = Obj["task_no"] as? String ?? ""
        self.task_status = Obj["task_status"] as? String ?? ""
        self.task_time = Obj["task_time"] as? String ?? ""
        self.ticket_id = Obj["ticket_id"] as? String ?? ""
        self.ticket_no = Obj["ticket_no"] as? String ?? ""
        self.ticket_time = Obj["ticket_time"] as? String ?? ""
        self.title = Obj["title"] as? String ?? ""
        self.total_checked_points = Obj["total_checked_points"] as? String ?? ""
        self.total_points = Obj["total_points"] as? String ?? ""
        self.type = Obj["type"] as? String ?? ""
        self.user_add_id = Obj["user_add_id"] as? String ?? ""
        
        self.start_date = Obj["start_date"] as? String ?? ""
        self.end_date = Obj["end_date"] as? String ?? ""
        self.end_nearly = Obj["end_nearly"] as? String ?? ""
        self.task_detailes = Obj["task_detailes"] as? String ?? ""
        self.progres = Obj["progres"] as? String ?? ""
        
        let file_arr   = Obj["files"] as? [[String:Any]] ?? []
        self.files     = file_arr.map{DocumentObj.init($0)}
        
        let related_arr   = Obj["relateds_numbers"] as? [[String:Any]] ?? []
        self.relateds_numbers     = related_arr.map{RelatedNumbersObj.init($0)}
        
    }}



class RelatedNumbersObj {
     
    var sub_tasks_numbers:String = ""
    var task_id:String = ""
    init(_ Obj : [String:Any]) {
        
        self.sub_tasks_numbers = Obj["sub_tasks_numbers"] as? String ?? ""
        self.task_id = Obj["task_id"] as? String ?? ""

    }}
class HistoryObj {
     
    var emp_id:String = ""
    var is_can_delete:String = ""
    var person_id:String = ""
    var profile_image:String = ""
    var profile_image_64:String = ""
    var action_name :String = ""
    var ar_title :String = ""
    var emp_name :String = ""
    var emp_name_mention :String = ""
    var en_title :String = ""
    var firstname_arabic :String = ""
    var firstname_english :String = ""
    var insert_date :String = ""
    var lastname_arabic :String = ""
    var lastname_english :String = ""
    var secondname_arabic :String = ""
    var secondname_english :String = ""
    var type :String = ""
    var user_image_64 :String = ""
    var label :String = ""
    var value :String = ""
    
    
    init(_ Obj : [String:Any]) {
        
        self.action_name = Obj["action_name"] as? String ?? ""
        self.ar_title = Obj["ar_title"] as? String ?? ""
        self.emp_name = Obj["emp_name"] as? String ?? ""
        self.emp_name_mention = Obj["emp_name_mention"] as? String ?? ""
        self.en_title  = Obj["en_title"] as? String ?? ""
        self.firstname_arabic = Obj["firstname_arabic"] as? String ?? ""
        self.firstname_english  = Obj["firstname_english"] as? String ?? ""
        self.insert_date  = Obj["insert_date"] as? String ?? ""
        self.lastname_arabic = Obj["lastname_arabic"] as? String ?? ""
        self.lastname_english  = Obj["lastname_english"] as? String ?? ""
        self.secondname_arabic  = Obj["secondname_arabic"] as? String ?? ""
        self.secondname_english  = Obj["secondname_english"] as? String ?? ""
        self.type =  Obj["type"] as? String ?? ""
        self.user_image_64 = Obj["user_image_64"] as? String ?? ""
        self.user_image_64 = Obj["user_image_64"] as? String ?? ""
        self.emp_id = Obj["emp_id"] as? String ?? ""
        self.is_can_delete = Obj["is_can_delete"] as? String ?? ""
        self.person_id = Obj["person_id"] as? String ?? ""
        self.profile_image = Obj["profile_image"] as? String ?? ""
        self.profile_image_64 = Obj["profile_image_64"] as? String ?? ""
        self.label = Obj["label"] as? String ?? ""
        self.value = Obj["value"] as? String ?? ""
    
        
    }}



class CommentObj {

    var action_name:String = ""
    var emp_id:String = ""
    var emp_name:String = ""
    var emp_name_mention:String = ""
    var files:String = ""
    var files_reply:String = ""
    var history_id:String = ""
    var insert_date:String = ""
    var is_added_comment:Bool = false
    var notes_history:String = ""
    var reply_from_name:String = ""
    var ticket_id:String = ""
    var type:String = ""
    var user_add_id:String = ""
    var user_image:String = ""
    var user_image_64:String = ""
    var isHidden = true
    var reply :[ReplyObj] = []
    var isHiddenReply = true

    
    
    
    
    init(_ Obj : [String:Any]) {
     
        let reply_arr   = Obj["reply"] as? [[String:Any]] ?? []
        self.reply      = reply_arr.map{ReplyObj.init($0)}
        
        self.action_name = Obj["action_name"] as? String ?? ""
        self.isHidden = Obj["isHidden"] as? Bool ?? true
        self.emp_id = Obj["emp_id"] as? String ?? ""
        self.emp_name = Obj["emp_name"] as? String ?? ""
        self.emp_name_mention = Obj["emp_name_mention"] as? String ?? ""
        self.files = Obj["files"] as? String ?? ""
        self.files_reply = Obj["files_reply"] as? String ?? ""
        self.history_id = Obj["history_id"] as? String ?? ""
        self.insert_date = Obj["insert_date"] as? String ?? ""
        self.is_added_comment = Obj["is_added_comment"] as? Bool ?? false
        self.notes_history = Obj["notes_history"] as? String ?? ""
//        self.reply = Obj["reply"] as? String ?? ""
        self.reply_from_name = Obj["reply_from_name"] as? String ?? ""
        self.ticket_id = Obj["ticket_id"] as? String ?? ""
        self.type = Obj["type"] as? String ?? ""
        self.user_add_id = Obj["user_add_id"] as? String ?? ""
        self.user_image = Obj["user_image"] as? String ?? ""
        self.user_image_64 = Obj["user_image_64"] as? String ?? ""
        
       
        
    }}

class ReplyObj {

    var avatar:String = ""
    var avatar_64:String = ""
    var emp_id:String = ""
    var is_added_reply:String = ""
    var comment_content:String = ""
    var comment_date:String = ""
    var files_reply:String = ""
    var history_id:String = ""
    var isAuthor:String = ""
    var path_file:String = ""
    var path:String = ""
    var userName:String = ""
    var notes_history = ""

    
    init(_ Obj : [String:Any]) {
  
        self.avatar = Obj["avatar"] as? String ?? ""
        self.avatar_64 = Obj["avatar_64"] as? String ?? ""
        
        self.emp_id = Obj["emp_id"] as? String ?? ""
        self.is_added_reply = Obj["is_added_reply"] as? String ?? ""
        self.path = Obj["path"] as? String ?? ""
        self.avatar_64 = Obj["avatar_64"] as? String ?? ""
        
        
        
        self.comment_content = Obj["comment_content"] as? String ?? ""
        self.comment_date = Obj["comment_date"] as? String ?? ""
        self.files_reply = Obj["files_reply"] as? String ?? ""
        self.history_id = Obj["history_id"] as? String ?? ""
        self.isAuthor = Obj["isAuthor"] as? String ?? ""
        self.path_file = Obj["path_file"] as? String ?? ""
        self.userName = Obj["userName"] as? String ?? ""
    }
    
    init(_ return_row:Return_row){
        self.avatar = return_row.avatar ?? ""
        self.comment_content = return_row.comment_content ?? ""
        self.comment_date = return_row.comment_date ?? ""
        self.files_reply = return_row.files_reply ?? ""
        self.history_id = return_row.history_id ?? ""
        self.isAuthor = return_row.isAuthor ?? ""
        self.path_file = return_row.path_file ?? ""
        self.userName = return_row.userName ?? ""
        self.notes_history = return_row.notes_history ?? ""
    }
    
}

class PointTaskObj {
  
    
    var check_id:String = ""
    var char_item = ""
    var firstname_arabic:String = ""
    var firstname_english:String = ""
    var insert_date:String = ""
    var lastname_arabic:String = ""
    var lastname_english:String = ""
    var profile_image:String = ""
    var progres:String = ""
    var secondname_arabic:String = ""
    var secondname_english:String = ""
    var sub_checks:[SubCheckObj] = []
    var task_id:String = ""
    var title:String = ""
    var user_add_id:String = ""
    var user_username:String = ""
    var isHidden:Bool = true
    var isUnselectedData = true
    
    
    
   
    
    
    init(_ Obj : [String:Any]) {
     
        self.check_id = Obj["check_id"] as? String ?? ""
        self.firstname_arabic = Obj["firstname_arabic"] as? String ?? ""
        self.firstname_english = Obj["firstname_english"] as? String ?? ""
        self.insert_date = Obj["insert_date"] as? String ?? ""
        self.lastname_arabic = Obj["lastname_arabic"] as? String ?? ""
        self.lastname_english = Obj["lastname_english"] as? String ?? ""
        self.profile_image = Obj["profile_image"] as? String ?? ""
        self.progres = Obj["progres"] as? String ?? ""
        self.secondname_arabic = Obj["secondname_arabic"] as? String ?? ""
        self.secondname_english = Obj["secondname_english"] as? String ?? ""
        self.isHidden = Obj["isHidden"] as? Bool ?? true
        self.task_id = Obj["task_id"] as? String ?? ""
        self.title = Obj["title"] as? String ?? ""
        self.user_add_id = Obj["user_add_id"] as? String ?? ""
        self.user_username = Obj["user_username"] as? String ?? ""
        self.char_item = Obj["char_item"] as? String ?? ""
        
        let sub_checks_arr   = Obj["sub_checks"] as? [[String:Any]] ?? []
        self.sub_checks     = sub_checks_arr.map{SubCheckObj.init($0)}
        
    }}

class SubCheckObj {

    
    var check_id :String = ""
    var comment :String = ""
    var date_comment :String = ""
    var end_date :String = ""
    var files :[DocumentObj] = []
    var firstname_arabic :String = ""
    var firstname_arabic_comment :String = ""
    var firstname_english :String = ""
    var firstname_english_comment :String = ""
    var firstname_english_end :String = ""
    var insert_date :String = ""
    var is_done :String = ""
    var lastname_arabic :String = ""
    var lastname_arabic_comment :String = ""
    var lastname_arabic_end :String = ""
    var lastname_english :String = ""
    var lastname_english_comment :String = ""
    var lastname_english_end :String = ""
    var more_details :String = ""
    var notes :String = ""
    var point_id :String = ""
    var profile_image :String = ""
    var profile_image_comment :String = ""
    var profile_image_end :String = ""
    var secondname_arabic :String = ""
    var secondname_arabic_comment :String = ""
    var secondname_arabic_end :String = ""
    var secondname_english :String = ""
    var secondname_english_comment :String = ""
    var secondname_english_end :String = ""
    var user_username :String = ""
    var user_add_id: String = ""
    var prg_done: String = ""
    var users :[ProfileObj] = []
    
    var char_item: String = ""
    var check_logs: String = ""
    var end_date_timer: String = ""
    var group_id: String = ""
    var group_name: String = ""
    var group_type_id: String = ""
    var group_user_id: String = ""
    var hours_between_dates: String = ""
    var hours_by_manual: String = ""
    var is_can_delete: String = ""
    var is_can_edit: String = ""
    var start_date: String = ""
    var start_date_timer: String = ""
    
    
    init(_ Obj : [String:Any]) {
     
        
        self.char_item = Obj["char_item"] as? String ?? ""
        self.check_logs = Obj["check_logs"] as? String ?? ""
        self.end_date_timer = Obj["end_date_timer"] as? String ?? ""
        self.group_id = Obj["group_id"] as? String ?? ""
        self.group_name = Obj["group_name"] as? String ?? ""
        self.group_type_id = Obj["group_type_id"] as? String ?? ""
        self.group_user_id = Obj["group_user_id"] as? String ?? ""
        self.hours_between_dates = Obj["hours_between_dates"] as? String ?? ""
        self.hours_by_manual = Obj["hours_by_manual"] as? String ?? ""
        self.is_can_delete = Obj["is_can_delete"] as? String ?? ""
        self.is_can_edit = Obj["is_can_edit"] as? String ?? ""
        self.start_date = Obj["start_date"] as? String ?? ""
        self.start_date_timer = Obj["start_date_timer"] as? String ?? ""
       
        
        self.check_id = Obj["check_id"] as? String ?? ""
        self.comment = Obj["comment"] as? String ?? ""
        self.date_comment = Obj["date_comment"] as? String ?? ""
        self.end_date = Obj["end_date"] as? String ?? ""
        self.firstname_arabic = Obj["firstname_arabic"] as? String ?? ""
        self.firstname_arabic_comment = Obj["firstname_arabic_comment"] as? String ?? ""
        self.firstname_english = Obj["firstname_english"] as? String ?? ""
        self.firstname_english_comment = Obj["firstname_english_comment"] as? String ?? ""
        self.firstname_english_end = Obj["firstname_english_end"] as? String ?? ""
        self.insert_date = Obj["insert_date"] as? String ?? ""
        self.is_done = Obj["is_done"] as? String ?? ""
        self.lastname_arabic = Obj["lastname_arabic"] as? String ?? ""
        self.lastname_arabic_comment = Obj["lastname_arabic_comment"] as? String ?? ""
        self.lastname_arabic_end = Obj["lastname_arabic_end"] as? String ?? ""
        self.lastname_english = Obj["lastname_english"] as? String ?? ""
        self.lastname_english_comment = Obj["lastname_english_comment"] as? String ?? ""
        self.lastname_english_end = Obj["lastname_english_end"] as? String ?? ""
        self.more_details = Obj["more_details"] as? String ?? ""
        self.notes = Obj["notes"] as? String ?? ""
        self.point_id = Obj["point_id"] as? String ?? ""
        self.profile_image = Obj["profile_image"] as? String ?? ""
        self.profile_image_comment = Obj["profile_image_comment"] as? String ?? ""
        self.profile_image_end = Obj["profile_image_end"] as? String ?? ""
        self.secondname_arabic = Obj["secondname_arabic"] as? String ?? ""
        self.secondname_arabic_comment = Obj["secondname_arabic_comment"] as? String ?? ""
        self.secondname_arabic_end = Obj["secondname_arabic_end"] as? String ?? ""
        self.secondname_english = Obj["secondname_english"] as? String ?? ""
        self.secondname_english_comment = Obj["secondname_english_comment"] as? String ?? ""
        self.secondname_english_end = Obj["secondname_english_end"] as? String ?? ""
        self.user_username = Obj["user_username"] as? String ?? ""
        self.user_add_id = Obj["user_add_id"] as? String ?? ""
        self.prg_done = Obj["prg_done"] as? String ?? ""
        let file_arr   = Obj["files"] as? [[String:Any]] ?? []
        self.files     = file_arr.map{DocumentObj.init($0)}
        let user_arr   = Obj["users"] as? [[String:Any]] ?? []
        self.users     = user_arr.map{ProfileObj.init($0)}
        
       
    }}



class unitLevelObj {
    
  
    var B :String = ""
    var C :String = ""
    var G :String = ""
    var U :String = ""
    var Z :String = ""
    var auto_id :String = ""
    var platform_code_system :String = ""
    var projects_work_area_id :String = ""
    var short_code :String = ""
    var template_id :String = ""
    var transaction_key :String = ""
    var transaction_request_id :String = ""
    var unit_custom_title :String = ""
    var unit_id :String = ""
    var work_level_key :String = ""
    var work_level_label :String = ""
    
    
    
    init(_ Obj : [String:Any]) {
     
        self.B = Obj["B"] as? String ?? ""
        self.C = Obj["C"] as? String ?? ""
        self.G = Obj["G"] as? String ?? ""
        self.U = Obj["U"] as? String ?? ""
        self.Z = Obj["Z"] as? String ?? ""
        self.auto_id = Obj["auto_id"] as? String ?? ""
        self.platform_code_system = Obj["platform_code_system"] as? String ?? ""
        self.projects_work_area_id = Obj["projects_work_area_id"] as? String ?? ""
        self.short_code = Obj["short_code"] as? String ?? ""
        self.template_id = Obj["template_id"] as? String ?? ""
        self.transaction_key = Obj["transaction_key"] as? String ?? ""
        self.transaction_request_id = Obj["transaction_request_id"] as? String ?? ""
        self.unit_custom_title = Obj["unit_custom_title"] as? String ?? ""
        self.unit_id = Obj["unit_id"] as? String ?? ""
        self.work_level_key = Obj["work_level_key"] as? String ?? ""
        self.work_level_label = Obj["work_level_label"] as? String ?? ""
        
       
    }}



