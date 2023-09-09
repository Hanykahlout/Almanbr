/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct AccountHistoryRecord : Mappable {
	var history_log_id : String?
	var log_action : String?
	var user_id : String?
	var log_effected_table : String?
	var log_effected_row : String?
	var log_action_date : String?
	var account_operation : String?
	var description_ar : String?
	var description_en : String?
	var name : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		history_log_id <- map["history_log_id"]
		log_action <- map["log_action"]
		user_id <- map["user_id"]
		log_effected_table <- map["log_effected_table"]
		log_effected_row <- map["log_effected_row"]
		log_action_date <- map["log_action_date"]
		account_operation <- map["account_operation"]
		description_ar <- map["description_ar"]
		description_en <- map["description_en"]
		name <- map["name"]
	}

}
