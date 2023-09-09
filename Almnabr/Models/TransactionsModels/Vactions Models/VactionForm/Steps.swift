/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Steps : Mappable {
	var cONFIGURATION : Bool?
	var eMPLOYEE : Bool?
	var dIRECT_MANAGER : Bool?
	var hUMAN_RESOURCE_TEAM : Bool?
	var aCCOUNT_TEAM : Bool?
	var hUMAN_RESOURCE_MANAGER : Bool?
	var last : Bool?
	var completed : Bool?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		cONFIGURATION <- map["CONFIGURATION"]
		eMPLOYEE <- map["EMPLOYEE"]
		dIRECT_MANAGER <- map["DIRECT_MANAGER"]
		hUMAN_RESOURCE_TEAM <- map["HUMAN_RESOURCE_TEAM"]
		aCCOUNT_TEAM <- map["ACCOUNT_TEAM"]
		hUMAN_RESOURCE_MANAGER <- map["HUMAN_RESOURCE_MANAGER"]
		last <- map["last"]
		completed <- map["completed"]
	}

}