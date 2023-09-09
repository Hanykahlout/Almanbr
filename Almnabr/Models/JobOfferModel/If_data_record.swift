/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct If_data_record : Mappable {
	var form_data_id : String?
	var transaction_key : String?
	var transaction_request_id : String?
	var employee_number : String?
	var subject : String?
	var work_domain : String?
	var work_location : String?
	var work_type : String?
	var joining_date_english : String?
	var joining_date_arabic : String?
	var probation_period : String?
	var probation_expiry_date_english : String?
	var probation_expiry_date_arabic : String?
	var contract_start_date_english : String?
	var contract_start_date_arabic : String?
	var contract_period : String?
	var contract_end_date_english : String?
	var contract_end_date_arabic : String?
	var vacation_paid_days : String?
	var upcoming_vacation_date_english : String?
	var upcoming_vacation_date_arabic : String?
	var upcoming_vacation_end_date_english : String?
	var upcoming_vacation_end_date_arabic : String?
	var working_days_per_week : String?
	var working_hours_type : String?
	var working_hours : String?
	var basic_salary : String?
	var home_allowance : String?
	var contract_status : String?
	var first_party_user : String?
	var second_party_user : String?
	var contract_actual_end_date : String?
	var penalty_clause_first_party : String?
	var penalty_clause_second_party : String?
	var penalty_clause_first_party_letters : String?
	var penalty_clause_second_party_letters : String?
	var notification_period : String?
	var ticket_amount : String?
	var auto_renew : String?
	var working_hours_per_week : String?
	var transaction_from : String?
	var transaction_to : String?
	var transaction_from_name : String?
	var transaction_to_name : String?
	var first_party_user_name : String?
	var employee_name : String?
	var tr_work_domain : String?
	var tr_work_location : String?
	var tr_work_type : String?
	var net_amount : String?
	var user_id : String?
	var e_reference_no : String?
	var employee_id_number : String?
	var branch_id : String?
	var firstname_english : String?
	var secondname_english : String?
	var thirdname_english : String?
	var lastname_english : String?
	var firstname_arabic : String?
	var secondname_arabic : String?
	var thirdname_arabic : String?
	var lastname_arabic : String?
	var iqama_expiry_date_english : String?
	var iqama_expiry_date_arabic : String?
	var copy_number : String?
	var birth_date_english : String?
	var birth_date_arabic : String?
	var gender : String?
	var nationality : String?
	var user_type_id : String?
	var job_title_iqama : String?
	var marital_status : String?
	var religion : String?
	var employee_title : String?
	var job_title_id : String?
	var job_descriptions : String?
	var primary_mobile : String?
	var primary_email : String?
	var primary_address : String?
	var account_number : String?
	var bank_short_code : String?
	var primary_graduation_year : String?
	var primary_education_level : String?
	var rating_degree : String?
	var membership_number : String?
	var membership_expiry_date_english : String?
	var membership_expiry_date_arabic : String?
	var passport_number : String?
	var passport_issue_date_english : String?
	var passport_issue_date_arabic : String?
	var passport_expiry_date_english : String?
	var passport_expiry_date_arabic : String?
	var passport_issue_place : String?
	var insurance_number : String?
	var insurance_date : String?
	var insurance_type_class : String?
	var terms_conditions : String?
	var employee_status : String?
	var interview_date_en : String?
	var interview_date_ar : String?
	var employee_writer : String?
	var created_datetime : String?
	var updated_datetime : String?
	var total_detection_vocation_days : String?
	var legal_situation_status : String?
	var total_previous_contract_days : String?
	var employee_title_name : String?
	var settings_name_english : String?
	var settings_name_arabic : String?
	var branchname : String?
	var jobname : String?
	var bankname : String?
	var banknameA : String?
	var typename : String?
	var signature : String?
	var mark : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		form_data_id <- map["form_data_id"]
		transaction_key <- map["transaction_key"]
		transaction_request_id <- map["transaction_request_id"]
		employee_number <- map["employee_number"]
		subject <- map["subject"]
		work_domain <- map["work_domain"]
		work_location <- map["work_location"]
		work_type <- map["work_type"]
		joining_date_english <- map["joining_date_english"]
		joining_date_arabic <- map["joining_date_arabic"]
		probation_period <- map["probation_period"]
		probation_expiry_date_english <- map["probation_expiry_date_english"]
		probation_expiry_date_arabic <- map["probation_expiry_date_arabic"]
		contract_start_date_english <- map["contract_start_date_english"]
		contract_start_date_arabic <- map["contract_start_date_arabic"]
		contract_period <- map["contract_period"]
		contract_end_date_english <- map["contract_end_date_english"]
		contract_end_date_arabic <- map["contract_end_date_arabic"]
		vacation_paid_days <- map["vacation_paid_days"]
		upcoming_vacation_date_english <- map["upcoming_vacation_date_english"]
		upcoming_vacation_date_arabic <- map["upcoming_vacation_date_arabic"]
		upcoming_vacation_end_date_english <- map["upcoming_vacation_end_date_english"]
		upcoming_vacation_end_date_arabic <- map["upcoming_vacation_end_date_arabic"]
		working_days_per_week <- map["working_days_per_week"]
		working_hours_type <- map["working_hours_type"]
		working_hours <- map["working_hours"]
		basic_salary <- map["basic_salary"]
		home_allowance <- map["home_allowance"]
		contract_status <- map["contract_status"]
		first_party_user <- map["first_party_user"]
		second_party_user <- map["second_party_user"]
		contract_actual_end_date <- map["contract_actual_end_date"]
		penalty_clause_first_party <- map["penalty_clause_first_party"]
		penalty_clause_second_party <- map["penalty_clause_second_party"]
		penalty_clause_first_party_letters <- map["penalty_clause_first_party_letters"]
		penalty_clause_second_party_letters <- map["penalty_clause_second_party_letters"]
		notification_period <- map["notification_period"]
		ticket_amount <- map["ticket_amount"]
		auto_renew <- map["auto_renew"]
		working_hours_per_week <- map["working_hours_per_week"]
		transaction_from <- map["transaction_from"]
		transaction_to <- map["transaction_to"]
		transaction_from_name <- map["transaction_from_name"]
		transaction_to_name <- map["transaction_to_name"]
		first_party_user_name <- map["first_party_user_name"]
		employee_name <- map["employee_name"]
		tr_work_domain <- map["tr_work_domain"]
		tr_work_location <- map["tr_work_location"]
		tr_work_type <- map["tr_work_type"]
		net_amount <- map["net_amount"]
		user_id <- map["user_id"]
		e_reference_no <- map["e_reference_no"]
		employee_id_number <- map["employee_id_number"]
		branch_id <- map["branch_id"]
		firstname_english <- map["firstname_english"]
		secondname_english <- map["secondname_english"]
		thirdname_english <- map["thirdname_english"]
		lastname_english <- map["lastname_english"]
		firstname_arabic <- map["firstname_arabic"]
		secondname_arabic <- map["secondname_arabic"]
		thirdname_arabic <- map["thirdname_arabic"]
		lastname_arabic <- map["lastname_arabic"]
		iqama_expiry_date_english <- map["iqama_expiry_date_english"]
		iqama_expiry_date_arabic <- map["iqama_expiry_date_arabic"]
		copy_number <- map["copy_number"]
		birth_date_english <- map["birth_date_english"]
		birth_date_arabic <- map["birth_date_arabic"]
		gender <- map["gender"]
		nationality <- map["nationality"]
		user_type_id <- map["user_type_id"]
		job_title_iqama <- map["job_title_iqama"]
		marital_status <- map["marital_status"]
		religion <- map["religion"]
		employee_title <- map["employee_title"]
		job_title_id <- map["job_title_id"]
		job_descriptions <- map["job_descriptions"]
		primary_mobile <- map["primary_mobile"]
		primary_email <- map["primary_email"]
		primary_address <- map["primary_address"]
		account_number <- map["account_number"]
		bank_short_code <- map["bank_short_code"]
		primary_graduation_year <- map["primary_graduation_year"]
		primary_education_level <- map["primary_education_level"]
		rating_degree <- map["rating_degree"]
		membership_number <- map["membership_number"]
		membership_expiry_date_english <- map["membership_expiry_date_english"]
		membership_expiry_date_arabic <- map["membership_expiry_date_arabic"]
		passport_number <- map["passport_number"]
		passport_issue_date_english <- map["passport_issue_date_english"]
		passport_issue_date_arabic <- map["passport_issue_date_arabic"]
		passport_expiry_date_english <- map["passport_expiry_date_english"]
		passport_expiry_date_arabic <- map["passport_expiry_date_arabic"]
		passport_issue_place <- map["passport_issue_place"]
		insurance_number <- map["insurance_number"]
		insurance_date <- map["insurance_date"]
		insurance_type_class <- map["insurance_type_class"]
		terms_conditions <- map["terms_conditions"]
		employee_status <- map["employee_status"]
		interview_date_en <- map["interview_date_en"]
		interview_date_ar <- map["interview_date_ar"]
		employee_writer <- map["employee_writer"]
		created_datetime <- map["created_datetime"]
		updated_datetime <- map["updated_datetime"]
		total_detection_vocation_days <- map["total_detection_vocation_days"]
		legal_situation_status <- map["legal_situation_status"]
		total_previous_contract_days <- map["total_previous_contract_days"]
		employee_title_name <- map["employee_title_name"]
		settings_name_english <- map["settings_name_english"]
		settings_name_arabic <- map["settings_name_arabic"]
		branchname <- map["branchname"]
		jobname <- map["jobname"]
		bankname <- map["bankname"]
		banknameA <- map["banknameA"]
		typename <- map["typename"]
		signature <- map["signature"]
		mark <- map["mark"]
	}

}
