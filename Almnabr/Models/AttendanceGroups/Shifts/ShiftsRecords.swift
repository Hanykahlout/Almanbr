/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct ShiftsRecords : Mappable {
	var shift_id : String?
	var shift_title_english : String?
	var shift_title_arabic : String?
	var created_by : String?
	var created_date_time : String?
	var updated_date_time : String?
	var writer : String?
	var groups : [ShiftsGroups]?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		shift_id <- map["shift_id"]
		shift_title_english <- map["shift_title_english"]
		shift_title_arabic <- map["shift_title_arabic"]
		created_by <- map["created_by"]
		created_date_time <- map["created_date_time"]
		updated_date_time <- map["updated_date_time"]
		writer <- map["writer"]
		groups <- map["groups"]
	}

}
