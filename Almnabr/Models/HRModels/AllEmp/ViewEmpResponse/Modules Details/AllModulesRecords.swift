/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct AllModulesRecords : Mappable {
	var mention_id : String?
	var branch_id : String?
	var user_id : String?
	var user_type_id : String?
	var module_key : String?
	var permission_key : String?
	var private_key : String?
	var private_value : String?
	var group_key : String?
	var create_by_user_id : String?
	var create_date : String?
	var modulename : String?
	var writer : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		mention_id <- map["mention_id"]
		branch_id <- map["branch_id"]
		user_id <- map["user_id"]
		user_type_id <- map["user_type_id"]
		module_key <- map["module_key"]
		permission_key <- map["permission_key"]
		private_key <- map["private_key"]
		private_value <- map["private_value"]
		group_key <- map["group_key"]
		create_by_user_id <- map["create_by_user_id"]
		create_date <- map["create_date"]
		modulename <- map["modulename"]
		writer <- map["writer"]
	}

}
