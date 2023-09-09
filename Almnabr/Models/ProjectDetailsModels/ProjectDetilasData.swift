/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct ProjectDetilasData : Mappable {
	var projects_profile_id : String?
	var customer_id : String?
	var branch_id : String?
	var customer_type_id : String?
	var projects_profile_location : String?
	var transaction_request_id : String?
	var projects_profile_status : String?
	var projects_profile_writer : String?
	var projects_profile_name_en : String?
	var projects_profile_name_ar : String?
	var latitude : String?
	var longitude : String?
	var projects_profile_created_datetime : String?
	var projects_profile_updated_datetime : String?
	var customer_title_ar : String?
	var customer_title_en : String?
	var project_title : String?
	var branch_name : String?
	var customer_name : String?
	var customer_type : String?
	var writer : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		projects_profile_id <- map["projects_profile_id"]
		customer_id <- map["customer_id"]
		branch_id <- map["branch_id"]
		customer_type_id <- map["customer_type_id"]
		projects_profile_location <- map["projects_profile_location"]
		transaction_request_id <- map["transaction_request_id"]
		projects_profile_status <- map["projects_profile_status"]
		projects_profile_writer <- map["projects_profile_writer"]
		projects_profile_name_en <- map["projects_profile_name_en"]
		projects_profile_name_ar <- map["projects_profile_name_ar"]
		latitude <- map["latitude"]
		longitude <- map["longitude"]
		projects_profile_created_datetime <- map["projects_profile_created_datetime"]
		projects_profile_updated_datetime <- map["projects_profile_updated_datetime"]
		customer_title_ar <- map["customer_title_ar"]
		customer_title_en <- map["customer_title_en"]
		project_title <- map["project_title"]
		branch_name <- map["branch_name"]
		customer_name <- map["customer_name"]
		customer_type <- map["customer_type"]
		writer <- map["writer"]
	}

}
