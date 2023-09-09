/* 
 Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar
 
 */

import Foundation
import ObjectMapper

struct form_c2_filesRecords : Mappable {
    var form_c2_files_id : String?
    var form_c1_files_id : String?
    var transaction_key : String?
    var transaction_request_id : String?
    var form_c2_file_size : String?
    var form_c2_file_extension : String?
    var form_c2_file_attach_title : String?
    var form_c2_file_attach_with_the_document : String?
    var form_c2_file_print_official_paper : String?
    
    var form_c1_file_size : String?
    var form_c1_file_extension : String?
    var form_c1_file_attach_title : String?
    var form_c1_file_attach_with_the_document : String?
    var form_c1_file_print_official_paper : String?
    
    
    var link : String?
    var attach_with_pdf : String?
    var official_paper : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        form_c2_files_id <- map["form_c2_files_id"]
        form_c1_files_id <- map["form_c1_files_id"]
        transaction_key <- map["transaction_key"]
        transaction_request_id <- map["transaction_request_id"]
        form_c2_file_size <- map["form_c2_file_size"]
        form_c2_file_extension <- map["form_c2_file_extension"]
        form_c2_file_attach_title <- map["form_c2_file_attach_title"]
        form_c2_file_attach_with_the_document <- map["form_c2_file_attach_with_the_document"]
        form_c2_file_print_official_paper <- map["form_c2_file_print_official_paper"]
        
        form_c1_file_size <- map["form_c1_file_size"]
        form_c1_file_extension <- map["form_c1_file_extension"]
        form_c1_file_attach_title <- map["form_c1_file_attach_title"]
        form_c1_file_attach_with_the_document <- map["form_c1_file_attach_with_the_document"]
        form_c1_file_print_official_paper <- map["form_c1_file_print_official_paper"]
        
        
        link <- map["link"]
        attach_with_pdf <- map["attach_with_pdf"]
        official_paper <- map["official_paper"]
    }
    
}
