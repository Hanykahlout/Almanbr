/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct JobDetailsRecord : Mappable {
	var settings_need_licence : String?
	var postition_name : String?
	var position_id : String?
	var employee_number : String?
	var settings_id : String?
	var job_descriptions : String?
	var position_writer : String?
	var created_datetime : String?
	var name : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		settings_need_licence <- map["settings_need_licence"]
		postition_name <- map["postition_name"]
		position_id <- map["position_id"]
		employee_number <- map["employee_number"]
		settings_id <- map["settings_id"]
		job_descriptions <- map["job_descriptions"]
		position_writer <- map["position_writer"]
		created_datetime <- map["created_datetime"]
		name <- map["name"]
	}

}
