/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct ProjectServicesRecord : Mappable {
	var projects_supervision_id : String?
	var projects_work_area_id : String?
	var projects_supervision_code : String?
	var transaction_request_id : String?
	var projects_supervision_status : String?
	var projects_supervision_writer : String?
	var projects_supervision_created_datetime : String?
	var branch_id : String?
	var customer_id : String?
	var projects_profile_id : String?
	var projects_services_id : String?
	var projects_ps_id : String?
	var projects_quotation_id : String?
	var projects_work_area_code : String?
	var projects_work_area_status : String?
	var total_construction_cost : String?
	var supervision_settings_rfialert_expire : String?
	var supervision_settings_drawing_submittal_alert_expire : String?
	var supervision_settings_material_submittal_alert_expire : String?
	var implimentation_phases_required : String?
	var total_no_of_zones : String?
	var total_no_of_blocks : String?
	var total_no_of_clusters : String?
	var total_no_of_units : String?
	var implementation_phases_status : String?
	var tbv_count : String?
	var file_records_id : String?
	var projects_quotation_status : String?
	var quotation_approval_file_records_id : String?
	var quotation_subject : String?
	var quotation_title_english : String?
	var quotation_title_arabic : String?
	var quotation_type : String?
	var quotation_created_date : String?
	var quotation_approved_date : String?
	var quotation_grand_total : String?
	var quotation_tax_amount : String?
	var quotation_net_amount : String?
	var quotation_request_user : String?
	var quotation_rejected_reason : String?
	var projects_quotation_pdf_file : String?
	var quotation_approval_receipt : String?
	var writer : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		projects_supervision_id <- map["projects_supervision_id"]
		projects_work_area_id <- map["projects_work_area_id"]
		projects_supervision_code <- map["projects_supervision_code"]
		transaction_request_id <- map["transaction_request_id"]
		projects_supervision_status <- map["projects_supervision_status"]
		projects_supervision_writer <- map["projects_supervision_writer"]
		projects_supervision_created_datetime <- map["projects_supervision_created_datetime"]
		branch_id <- map["branch_id"]
		customer_id <- map["customer_id"]
		projects_profile_id <- map["projects_profile_id"]
		projects_services_id <- map["projects_services_id"]
		projects_ps_id <- map["projects_ps_id"]
		projects_quotation_id <- map["projects_quotation_id"]
		projects_work_area_code <- map["projects_work_area_code"]
		projects_work_area_status <- map["projects_work_area_status"]
		total_construction_cost <- map["total_construction_cost"]
		supervision_settings_rfialert_expire <- map["supervision_settings_rfialert_expire"]
		supervision_settings_drawing_submittal_alert_expire <- map["supervision_settings_drawing_submittal_alert_expire"]
		supervision_settings_material_submittal_alert_expire <- map["supervision_settings_material_submittal_alert_expire"]
		implimentation_phases_required <- map["implimentation_phases_required"]
		total_no_of_zones <- map["total_no_of_zones"]
		total_no_of_blocks <- map["total_no_of_blocks"]
		total_no_of_clusters <- map["total_no_of_clusters"]
		total_no_of_units <- map["total_no_of_units"]
		implementation_phases_status <- map["implementation_phases_status"]
		tbv_count <- map["tbv_count"]
		file_records_id <- map["file_records_id"]
		projects_quotation_status <- map["projects_quotation_status"]
		quotation_approval_file_records_id <- map["quotation_approval_file_records_id"]
		quotation_subject <- map["quotation_subject"]
		quotation_title_english <- map["quotation_title_english"]
		quotation_title_arabic <- map["quotation_title_arabic"]
		quotation_type <- map["quotation_type"]
		quotation_created_date <- map["quotation_created_date"]
		quotation_approved_date <- map["quotation_approved_date"]
		quotation_grand_total <- map["quotation_grand_total"]
		quotation_tax_amount <- map["quotation_tax_amount"]
		quotation_net_amount <- map["quotation_net_amount"]
		quotation_request_user <- map["quotation_request_user"]
		quotation_rejected_reason <- map["quotation_rejected_reason"]
		projects_quotation_pdf_file <- map["projects_quotation_pdf_file"]
		quotation_approval_receipt <- map["quotation_approval_receipt"]
		writer <- map["writer"]
	}

}
