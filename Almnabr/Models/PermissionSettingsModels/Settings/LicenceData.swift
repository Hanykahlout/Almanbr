/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct LicenceData : Mappable {
	var licence_list_id : String?
	var settings_id : String?
	var licence_name_english : String?
	var licence_name_arabic : String?
	var licence_writer : String?
	var licence_created_datetime : String?
	var licence_updated_datetime : String?
    
	init?(map: Map) {

	}

    init(licence_name_english:String,licence_name_arabic:String){
        self.licence_name_english = licence_name_english
        self.licence_name_arabic = licence_name_arabic
    }
    
    
	mutating func mapping(map: Map) {

		licence_list_id <- map["licence_list_id"]
		settings_id <- map["settings_id"]
		licence_name_english <- map["licence_name_english"]
		licence_name_arabic <- map["licence_name_arabic"]
		licence_writer <- map["licence_writer"]
		licence_created_datetime <- map["licence_created_datetime"]
		licence_updated_datetime <- map["licence_updated_datetime"]
	}

}
