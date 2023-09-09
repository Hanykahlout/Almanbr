/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct EducationRecord : Mappable {
    
	var education_id : String?
	var employee_number : String?
	var education_title : String?
	var education_descriptions : String?
	var education_start_date : String?
	var education_end_date : String?
	var education_certification_file : String?
	var education_writer : String?
	var education_createddatetime : String?
	var education_updateddatetime : String?
	var name : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		education_id <- map["education_id"]
		employee_number <- map["employee_number"]
		education_title <- map["education_title"]
		education_descriptions <- map["education_descriptions"]
		education_start_date <- map["education_start_date"]
		education_end_date <- map["education_end_date"]
		education_certification_file <- map["education_certification_file"]
		education_writer <- map["education_writer"]
		education_createddatetime <- map["education_createddatetime"]
		education_updateddatetime <- map["education_updateddatetime"]
		name <- map["name"]
	}

}
