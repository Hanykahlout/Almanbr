/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct ZonesRecord : Mappable {
	var phase_id : String?
	var projects_profile_id : String?
	var projects_supervision_id : String?
	var transaction_request_id : String?
	var phase_title_en : String?
	var phase_title_ar : String?
	var phase_parent_id : String?
	var phase_type : String?
	var phase_zone_no : String?
	var phase_zone_block_no : String?
	var phase_zone_block_cluster_no : String?
	var phase_zone_block_cluster_unit_no : String?
	var phase_zone_block_cluster_g_no : String?
	var unit_opening_balance : String?
	var phase_short_code : String?
	var phase_writer : String?
	var phase_created_datetime : String?
	var phase_updated_datetime : String?
	var bank_short_code : String?
	var id : String?
	var value : String?
	var label : String?
	var name : String?
	var hasChildren : String?
	var phase_zone_custom_title : String?
	var writer : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		phase_id <- map["phase_id"]
		projects_profile_id <- map["projects_profile_id"]
		projects_supervision_id <- map["projects_supervision_id"]
		transaction_request_id <- map["transaction_request_id"]
		phase_title_en <- map["phase_title_en"]
		phase_title_ar <- map["phase_title_ar"]
		phase_parent_id <- map["phase_parent_id"]
		phase_type <- map["phase_type"]
		phase_zone_no <- map["phase_zone_no"]
		phase_zone_block_no <- map["phase_zone_block_no"]
		phase_zone_block_cluster_no <- map["phase_zone_block_cluster_no"]
		phase_zone_block_cluster_unit_no <- map["phase_zone_block_cluster_unit_no"]
		phase_zone_block_cluster_g_no <- map["phase_zone_block_cluster_g_no"]
		unit_opening_balance <- map["unit_opening_balance"]
		phase_short_code <- map["phase_short_code"]
		phase_writer <- map["phase_writer"]
		phase_created_datetime <- map["phase_created_datetime"]
		phase_updated_datetime <- map["phase_updated_datetime"]
		bank_short_code <- map["bank_short_code"]
		id <- map["id"]
		value <- map["value"]
		label <- map["label"]
		name <- map["name"]
		hasChildren <- map["hasChildren"]
		phase_zone_custom_title <- map["phase_zone_custom_title"]
		writer <- map["writer"]
	}

}
