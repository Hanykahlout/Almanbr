/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct VactionTypesRecords : Mappable {
	var value : String?
	var text_en : String?
	var text_ar : String?
	var vacation_type_paid_days_limits : String?
	var vacation_type_extra_paid_days : String?
	var vacation_type_extra_paid_days_percentage : String?
	var vacation_conditional_days : String?
	var gender_type : String?
	var need_attachment : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		value <- map["value"]
		text_en <- map["text_en"]
		text_ar <- map["text_ar"]
		vacation_type_paid_days_limits <- map["vacation_type_paid_days_limits"]
		vacation_type_extra_paid_days <- map["vacation_type_extra_paid_days"]
		vacation_type_extra_paid_days_percentage <- map["vacation_type_extra_paid_days_percentage"]
		vacation_conditional_days <- map["vacation_conditional_days"]
		gender_type <- map["gender_type"]
		need_attachment <- map["need_attachment"]
	}

}
