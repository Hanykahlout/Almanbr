/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct ProjectsDesignData : Mappable {
	var project_design_id : String?
	var projects_work_area_id : String?
	var projects_design_code : String?
	var projects_design_status : String?
	var projects_design_writer : String?
	var insert_date : String?
	var user_username : String?
	var contact_titel : String?
	var contract_grand_total : String?
	var contract_vat : String?
	var contract_net_amount : String?
	var firstname_english : String?
	var secondname_english : String?
	var lastname_english : String?
	var firstname_arabic : String?
	var secondname_arabic : String?
	var lastname_arabic : String?
	var projects_work_area_code : String?
	var quotation_subject : String?
	var quotation_title_english : String?
	var quotation_title_arabic : String?
	var quotation_created_date : String?
	var quotation_grand_total : String?
	var quotation_tax_amount : String?
	var quotation_net_amount : String?
	var create_project_design : String?
	var is_can_view : Bool?
	var is_can_edit : Bool?
	var is_can_delete : Bool?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		project_design_id <- map["project_design_id"]
		projects_work_area_id <- map["projects_work_area_id"]
		projects_design_code <- map["projects_design_code"]
		projects_design_status <- map["projects_design_status"]
		projects_design_writer <- map["projects_design_writer"]
		insert_date <- map["insert_date"]
		user_username <- map["user_username"]
		contact_titel <- map["contact_titel"]
		contract_grand_total <- map["contract_grand_total"]
		contract_vat <- map["contract_vat"]
		contract_net_amount <- map["contract_net_amount"]
		firstname_english <- map["firstname_english"]
		secondname_english <- map["secondname_english"]
		lastname_english <- map["lastname_english"]
		firstname_arabic <- map["firstname_arabic"]
		secondname_arabic <- map["secondname_arabic"]
		lastname_arabic <- map["lastname_arabic"]
		projects_work_area_code <- map["projects_work_area_code"]
		quotation_subject <- map["quotation_subject"]
		quotation_title_english <- map["quotation_title_english"]
		quotation_title_arabic <- map["quotation_title_arabic"]
		quotation_created_date <- map["quotation_created_date"]
		quotation_grand_total <- map["quotation_grand_total"]
		quotation_tax_amount <- map["quotation_tax_amount"]
		quotation_net_amount <- map["quotation_net_amount"]
		create_project_design <- map["create_project_design"]
		is_can_view <- map["is_can_view"]
		is_can_edit <- map["is_can_edit"]
		is_can_delete <- map["is_can_delete"]
	}

}
