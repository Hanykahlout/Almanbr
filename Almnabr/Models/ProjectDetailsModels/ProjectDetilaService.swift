/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct ProjectDetilaService : Mappable {
	var value : String?
	var projects_ps_id : String?
	var label : String?
	var keyword : String?
	var projects_services_id : String?
	var projects_services_name_en : String?
	var projects_services_name_ar : String?
	var projects_services_code : String?
    var isSelected = false
	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		value <- map["value"]
		projects_ps_id <- map["projects_ps_id"]
		label <- map["label"]
		keyword <- map["keyword"]
		projects_services_id <- map["projects_services_id"]
		projects_services_name_en <- map["projects_services_name_en"]
		projects_services_name_ar <- map["projects_services_name_ar"]
		projects_services_code <- map["projects_services_code"]
	}

}
