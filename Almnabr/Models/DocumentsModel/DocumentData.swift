/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct DocumentData : Mappable {
	var document_id : String?
	var document_branch : String?
	var branch_name : String?
	var document_type : String?
	var document_number : String?
	var document_name : String?
	var document_issue_date_english : String?
	var document_issue_date_arabic : String?
	var document_expire_date_english : String?
	var document_expire_date_arabic : String?
	var user_add_id : String?
	var insert_date : String?
	var notes : String?
	var status : String?
	var user_name : String?
	var document_type_name : String?
	var last_title_file : String?
	var last_file_path : String?
	var can_edit : Bool?
	var can_delete : Bool?
	var can_view : Bool?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		document_id <- map["document_id"]
		document_branch <- map["document_branch"]
		branch_name <- map["branch_name"]
		document_type <- map["document_type"]
		document_number <- map["document_number"]
		document_name <- map["document_name"]
		document_issue_date_english <- map["document_issue_date_english"]
		document_issue_date_arabic <- map["document_issue_date_arabic"]
		document_expire_date_english <- map["document_expire_date_english"]
		document_expire_date_arabic <- map["document_expire_date_arabic"]
		user_add_id <- map["user_add_id"]
		insert_date <- map["insert_date"]
		notes <- map["notes"]
		status <- map["status"]
		user_name <- map["user_name"]
		document_type_name <- map["document_type_name"]
		last_title_file <- map["last_title_file"]
		last_file_path <- map["last_file_path"]
		can_edit <- map["can_edit"]
		can_delete <- map["can_delete"]
		can_view <- map["can_view"]
	}

}
