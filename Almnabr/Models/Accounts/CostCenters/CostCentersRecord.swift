/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct CostCentersRecord : Mappable {
	var branch_name : String?
	var cost_center_id : String?
	var branch_id : String?
	var cost_center_parent : String?
	var cost_center_code : String?
	var cost_center_name_en : String?
	var cost_center_name_ar : String?
	var cost_center_sub : String?
	var cost_center_writer : String?
	var cost_center_created_datetime : String?
	var cost_center_updated_datetime : String?
	var writer_name : String?
	var id : String?
	var name : String?
    var children : [CostCentersRecord]?
    
	init?(map: Map) {

	}
    
    
	mutating func mapping(map: Map) {

		branch_name <- map["branch_name"]
		cost_center_id <- map["cost_center_id"]
		branch_id <- map["branch_id"]
		cost_center_parent <- map["cost_center_parent"]
		cost_center_code <- map["cost_center_code"]
		cost_center_name_en <- map["cost_center_name_en"]
		cost_center_name_ar <- map["cost_center_name_ar"]
		cost_center_sub <- map["cost_center_sub"]
		cost_center_writer <- map["cost_center_writer"]
		cost_center_created_datetime <- map["cost_center_created_datetime"]
		cost_center_updated_datetime <- map["cost_center_updated_datetime"]
		writer_name <- map["writer_name"]
		id <- map["id"]
		name <- map["name"]
        children <- map["children"]
        
	}

}
