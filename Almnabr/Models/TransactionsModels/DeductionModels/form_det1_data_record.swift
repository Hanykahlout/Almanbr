/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct form_det1_data_record : Mappable {
	var form_data_id : String?
	var transaction_key : String?
	var transaction_request_id : String?
	var employee_number : String?
	var subject : String?
	var deduction_date_english : String?
	var deduction_date_arabic : String?
	var deduction_reason : String?
	var deduction_percentage : String?
	var deduction_amount : String?
	var direct_manager : String?
	var transaction_from : String?
	var transaction_to : String?
	var direct_manager_name : String?
	var transaction_from_name : String?
	var transaction_to_name : String?
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
	var profile_image : String?
	var job_title_iqama : String?
	var marital_status : String?
	var religion : String?
	var work_domain : String?
	var work_location : String?
	var work_type : String?
	var employee_title : String?
	var job_title_id : String?
	var job_descriptions : String?
	var username : String?
	var password : String?
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
	var employee_signature : String?
	var employee_mark : String?
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
	var employee_name : String?
	var job_title : String?
	var branch : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		form_data_id <- map["form_data_id"]
		transaction_key <- map["transaction_key"]
		transaction_request_id <- map["transaction_request_id"]
		employee_number <- map["employee_number"]
		subject <- map["subject"]
		deduction_date_english <- map["deduction_date_english"]
		deduction_date_arabic <- map["deduction_date_arabic"]
		deduction_reason <- map["deduction_reason"]
		deduction_percentage <- map["deduction_percentage"]
		deduction_amount <- map["deduction_amount"]
		direct_manager <- map["direct_manager"]
		transaction_from <- map["transaction_from"]
		transaction_to <- map["transaction_to"]
		direct_manager_name <- map["direct_manager_name"]
		transaction_from_name <- map["transaction_from_name"]
		transaction_to_name <- map["transaction_to_name"]
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
		profile_image <- map["profile_image"]
		job_title_iqama <- map["job_title_iqama"]
		marital_status <- map["marital_status"]
		religion <- map["religion"]
		work_domain <- map["work_domain"]
		work_location <- map["work_location"]
		work_type <- map["work_type"]
		employee_title <- map["employee_title"]
		job_title_id <- map["job_title_id"]
		job_descriptions <- map["job_descriptions"]
		username <- map["username"]
		password <- map["password"]
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
		employee_signature <- map["employee_signature"]
		employee_mark <- map["employee_mark"]
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
		employee_name <- map["employee_name"]
		job_title <- map["job_title"]
		branch <- map["branch"]
	}

}
