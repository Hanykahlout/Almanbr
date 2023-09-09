/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct AttendanceGroupsRecords : Mappable {
	var group_id : String?
	var group_title_english : String?
	var group_title_arabic : String?
	var group_users : String?
	var un_restricted_group : String?
	var created_by : String?
	var created_datetime : String?
	var updated_datetime : String?
	var writer : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		group_id <- map["group_id"]
		group_title_english <- map["group_title_english"]
		group_title_arabic <- map["group_title_arabic"]
		group_users <- map["group_users"]
		un_restricted_group <- map["un_restricted_group"]
		created_by <- map["created_by"]
		created_datetime <- map["created_datetime"]
		updated_datetime <- map["updated_datetime"]
		writer <- map["writer"]
	}

}
