/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct SettingsDataRecords : Mappable {
	var settings_id : String?
	var settings_type : String?
	var settings_name_english : String?
	var settings_name_arabic : String?
	var settings_status : String?
	var settings_short_code : String?
	var settings_need_licence : String?
	var settings_writer : String?
	var settings_created_datetime : String?
	var settings_updated_datetime : String?
	var name : String?

    
	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		settings_id <- map["settings_id"]
		settings_type <- map["settings_type"]
		settings_name_english <- map["settings_name_english"]
		settings_name_arabic <- map["settings_name_arabic"]
		settings_status <- map["settings_status"]
		settings_short_code <- map["settings_short_code"]
		settings_need_licence <- map["settings_need_licence"]
		settings_writer <- map["settings_writer"]
		settings_created_datetime <- map["settings_created_datetime"]
		settings_updated_datetime <- map["settings_updated_datetime"]
		name <- map["name"]
	}

}
