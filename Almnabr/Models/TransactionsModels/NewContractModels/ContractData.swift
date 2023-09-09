/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct ContractData : Mappable {
    
	var contract_id : String?
	var transaction_key : String?
	var transaction_request_id : String?
	var tbv_count : String?
	var employee_number : String?
	var subject : String?
	var work_domain : String?
	var work_location : String?
	var work_type : String?
	var joining_date_english : String?
	var joining_date_arabic : String?
	var probation_period : String?
	var extend_probation_period : String?
	var extra_probation_start_date_english : String?
	var extra_probation_start_date_arabic : String?
	var extra_probation_end_date_english : String?
	var extra_probation_end_date_arabic : String?
	var probation_expiry_date_english : String?
	var probation_expiry_date_arabic : String?
	var contract_start_date_english : String?
	var contract_start_date_arabic : String?
	var contract_period : String?
	var contract_end_date_english : String?
	var contract_end_date_arabic : String?
	var vacation_paid_days : String?
	var vacation_paid_days_only : String?
	var upcoming_vacation_date_english : String?
	var upcoming_vacation_date_arabic : String?
	var upcoming_vacation_end_date_english : String?
	var upcoming_vacation_end_date_arabic : String?
	var working_days_per_week : String?
	var working_hours_per_day : String?
	var basic_salary : String?
	var home_allowance : String?
	var other_allowance : String?
	var net_amount : String?
	var contract_status : String?
	var first_party_user : String?
	var second_party_user : String?
	var contract_source : String?
	var contract_source_id : String?
	var file_records_id : String?
	var contract_approved_date_english : String?
	var contract_approved_date_arabic : String?
	var contract_writer : String?
	var working_hours_type : String?
	var penalty_clause_first_party : String?
	var penalty_clause_second_party : String?
	var penalty_clause_first_party_letters : String?
	var penalty_clause_second_party_letters : String?
	var contract_type : String?
	var working_hours_per_week : String?
	var contract_actual_end_date : String?
	var contract_edit_effect_date : String?
	var notification_period : String?
	var ticket_amount : String?
	var auto_renew : String?
	var remaining_contract_allowed_days : String?
	var total_detection_days : String?
	var probation_warning : String?
	var contract_warning : String?
	var remaining_employee_working_days : String?
	var total_unused_days : String?
	var contract_active_status : String?
	var working_hours : String?
	var contract_attachment : String?
	var writer : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		contract_id <- map["contract_id"]
		transaction_key <- map["transaction_key"]
		transaction_request_id <- map["transaction_request_id"]
		tbv_count <- map["tbv_count"]
		employee_number <- map["employee_number"]
		subject <- map["subject"]
		work_domain <- map["work_domain"]
		work_location <- map["work_location"]
		work_type <- map["work_type"]
		joining_date_english <- map["joining_date_english"]
		joining_date_arabic <- map["joining_date_arabic"]
		probation_period <- map["probation_period"]
		extend_probation_period <- map["extend_probation_period"]
		extra_probation_start_date_english <- map["extra_probation_start_date_english"]
		extra_probation_start_date_arabic <- map["extra_probation_start_date_arabic"]
		extra_probation_end_date_english <- map["extra_probation_end_date_english"]
		extra_probation_end_date_arabic <- map["extra_probation_end_date_arabic"]
		probation_expiry_date_english <- map["probation_expiry_date_english"]
		probation_expiry_date_arabic <- map["probation_expiry_date_arabic"]
		contract_start_date_english <- map["contract_start_date_english"]
		contract_start_date_arabic <- map["contract_start_date_arabic"]
		contract_period <- map["contract_period"]
		contract_end_date_english <- map["contract_end_date_english"]
		contract_end_date_arabic <- map["contract_end_date_arabic"]
		vacation_paid_days <- map["vacation_paid_days"]
		vacation_paid_days_only <- map["vacation_paid_days_only"]
		upcoming_vacation_date_english <- map["upcoming_vacation_date_english"]
		upcoming_vacation_date_arabic <- map["upcoming_vacation_date_arabic"]
		upcoming_vacation_end_date_english <- map["upcoming_vacation_end_date_english"]
		upcoming_vacation_end_date_arabic <- map["upcoming_vacation_end_date_arabic"]
		working_days_per_week <- map["working_days_per_week"]
		working_hours_per_day <- map["working_hours_per_day"]
		basic_salary <- map["basic_salary"]
		home_allowance <- map["home_allowance"]
		other_allowance <- map["other_allowance"]
		net_amount <- map["net_amount"]
		contract_status <- map["contract_status"]
		first_party_user <- map["first_party_user"]
		second_party_user <- map["second_party_user"]
		contract_source <- map["contract_source"]
		contract_source_id <- map["contract_source_id"]
		file_records_id <- map["file_records_id"]
		contract_approved_date_english <- map["contract_approved_date_english"]
		contract_approved_date_arabic <- map["contract_approved_date_arabic"]
		contract_writer <- map["contract_writer"]
		working_hours_type <- map["working_hours_type"]
		penalty_clause_first_party <- map["penalty_clause_first_party"]
		penalty_clause_second_party <- map["penalty_clause_second_party"]
		penalty_clause_first_party_letters <- map["penalty_clause_first_party_letters"]
		penalty_clause_second_party_letters <- map["penalty_clause_second_party_letters"]
		contract_type <- map["contract_type"]
		working_hours_per_week <- map["working_hours_per_week"]
		contract_actual_end_date <- map["contract_actual_end_date"]
		contract_edit_effect_date <- map["contract_edit_effect_date"]
		notification_period <- map["notification_period"]
		ticket_amount <- map["ticket_amount"]
		auto_renew <- map["auto_renew"]
		remaining_contract_allowed_days <- map["remaining_contract_allowed_days"]
		total_detection_days <- map["total_detection_days"]
		probation_warning <- map["probation_warning"]
		contract_warning <- map["contract_warning"]
		remaining_employee_working_days <- map["remaining_employee_working_days"]
		total_unused_days <- map["total_unused_days"]
		contract_active_status <- map["contract_active_status"]
		working_hours <- map["working_hours"]
		contract_attachment <- map["contract_attachment"]
		writer <- map["writer"]
	}

}
