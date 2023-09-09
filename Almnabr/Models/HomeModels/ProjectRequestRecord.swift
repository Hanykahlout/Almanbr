/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct ProjectRequestRecord : Mappable {
	var result_id : String?
	var projects_work_area_id : String?
	var transaction_request_id : String?
	var template_id : String?
	var transactions_date_m : String?
	var template_name : String?
	var group_type_id : String?
	var group_type_name : String?
	var group1_id : String?
	var group1_name : String?
	var group2_id : String?
	var group2_name : String?
	var platform_code_system : String?
	var platform_name : String?
	var transaction_key : String?
	var phase_zone_no : String?
	var phase_zone_block_no : String?
	var phase_zone_block_cluster_no : String?
	var phase_short_code : String?
	var unit_id : String?
	var level_key : String?
	var color : String?
	var level_name : String?
	var barcode : String?
	var file_path : String?
	var result_code : String?
	var transaction_request_last_step : String?

//    var platform_code_system:String?
    var platform_subject:String?
    var platform_work_level_title:String?
    var total:String?
    var total_transactions:String?
    var total_units:String?
    var work_level:String?
    
    
    
    
    
    
    
    
    
    
    
    
	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		result_id <- map["result_id"]
		projects_work_area_id <- map["projects_work_area_id"]
		transaction_request_id <- map["transaction_request_id"]
		template_id <- map["template_id"]
		transactions_date_m <- map["transactions_date_m"]
		template_name <- map["template_name"]
		group_type_id <- map["group_type_id"]
		group_type_name <- map["group_type_name"]
		group1_id <- map["group1_id"]
		group1_name <- map["group1_name"]
		group2_id <- map["group2_id"]
		group2_name <- map["group2_name"]
		platform_code_system <- map["platform_code_system"]
		platform_name <- map["platform_name"]
		transaction_key <- map["transaction_key"]
		phase_zone_no <- map["phase_zone_no"]
		phase_zone_block_no <- map["phase_zone_block_no"]
		phase_zone_block_cluster_no <- map["phase_zone_block_cluster_no"]
		phase_short_code <- map["phase_short_code"]
		unit_id <- map["unit_id"]
		level_key <- map["level_key"]
		color <- map["color"]
		level_name <- map["level_name"]
		barcode <- map["barcode"]
		file_path <- map["file_path"]
		result_code <- map["result_code"]
		transaction_request_last_step <- map["transaction_request_last_step"]
	}

}
