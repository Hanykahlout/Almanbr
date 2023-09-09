/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct JoiningDetailsRecord : Mappable {
	var joining_type : String?
	var joining_start_date_english : String?
	var joining_start_date_arabic : String?
	var approved_status : String?
	var writer_name : String?
	var preview_link : String?
	var link : String?
	var joining_type_value : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		joining_type <- map["joining_type"]
		joining_start_date_english <- map["joining_start_date_english"]
		joining_start_date_arabic <- map["joining_start_date_arabic"]
		approved_status <- map["approved_status"]
		writer_name <- map["writer_name"]
		preview_link <- map["preview_link"]
		link <- map["link"]
		joining_type_value <- map["joining_type_value"]
	}

}
