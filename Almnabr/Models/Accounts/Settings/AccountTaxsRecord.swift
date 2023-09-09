/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct AccountTaxsRecord : Mappable {
	var taxt_setup_id : String?
	var branch_id : String?
	var item_tax : String?
	var global_tax : String?
	var item_discount : String?
	var global_discount : String?
	var tax_writer : String?
	var tax_created_datetime : String?
	var tax_updated_datetime : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		taxt_setup_id <- map["taxt_setup_id"]
		branch_id <- map["branch_id"]
		item_tax <- map["item_tax"]
		global_tax <- map["global_tax"]
		item_discount <- map["item_discount"]
		global_discount <- map["global_discount"]
		tax_writer <- map["tax_writer"]
		tax_created_datetime <- map["tax_created_datetime"]
		tax_updated_datetime <- map["tax_updated_datetime"]
	}

}
