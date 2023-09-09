/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct AccountTypesRecord : Mappable {
	var account_setting_id : String?
	var branch_id : String?
	var setting_type_code : String?
	var setting_parent : String?
	var setting_title_english : String?
	var setting_title_arabic : String?
	var setting_key_code : String?
	var setting_tax_value : String?
	var setting_accounts_config : String?
	var setting_status : String?
	var settings_default : String?
	var setting_writer : String?
	var setting_created_datetime : String?
	var setting_updated_datetime : String?
	var cost_center_required : String?
	var label : String?
	var value : String?

    
    
    
	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		account_setting_id <- map["account_setting_id"]
		branch_id <- map["branch_id"]
		setting_type_code <- map["setting_type_code"]
		setting_parent <- map["setting_parent"]
		setting_title_english <- map["setting_title_english"]
		setting_title_arabic <- map["setting_title_arabic"]
		setting_key_code <- map["setting_key_code"]
		setting_tax_value <- map["setting_tax_value"]
		setting_accounts_config <- map["setting_accounts_config"]
		setting_status <- map["setting_status"]
		settings_default <- map["settings_default"]
		setting_writer <- map["setting_writer"]
		setting_created_datetime <- map["setting_created_datetime"]
		setting_updated_datetime <- map["setting_updated_datetime"]
		cost_center_required <- map["cost_center_required"]
		label <- map["label"]
		value <- map["value"]
	}

}
