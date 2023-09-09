/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct CommentRepliesResponse : Mappable {
	var path_file : String?
	var userName : String?
	var isAuthor : Bool?
	var avatar : String?
	var comment_date : String?
	var comment_content : String?
	var emp_id : String?
	var history_id : String?
	var files_reply : [String]?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		path_file <- map["path_file"]
		userName <- map["userName"]
		isAuthor <- map["isAuthor"]
		avatar <- map["avatar"]
		comment_date <- map["comment_date"]
		comment_content <- map["comment_content"]
		emp_id <- map["emp_id"]
		history_id <- map["history_id"]
		files_reply <- map["files_reply"]
	}

}
