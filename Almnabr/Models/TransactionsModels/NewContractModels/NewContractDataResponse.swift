/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct NewContractDataResponse : Mappable {
	var status : Bool?
	var transactions_request : TransactionsContractRequest?
	var transactions_date : TransactionsContractDate?
	var transactions_notes : TransactionsContractNotes?
	var transactions_records : TransactionsContractRecords?
	var transactions_submitter : TransactionsContractSubmitter?
	var transactions_barcode_version : TransactionsContractBarcodeVersion?
	var transactions_persons : Transactions_personsVD?
	var transactions_buttons : TransactionsContractButtons?
	var form_ct1_data : Form_ct1_data?
	var form_ct1_data_additional_terms : Form_ct1_data_additional_terms?
	var form_ct1_data_allowances : Form_ct1_data_allowances?
	var steps : ContractSteps?
	var last_request_step : String?
    var error: String?
    
	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		status <- map["status"]
		transactions_request <- map["transactions_request"]
		transactions_date <- map["transactions_date"]
		transactions_notes <- map["transactions_notes"]
		transactions_records <- map["transactions_records"]
		transactions_submitter <- map["transactions_submitter"]
		transactions_barcode_version <- map["transactions_barcode_version"]
		transactions_persons <- map["transactions_persons"]
		transactions_buttons <- map["transactions_buttons"]
		form_ct1_data <- map["form_ct1_data"]
		form_ct1_data_additional_terms <- map["form_ct1_data_additional_terms"]
		form_ct1_data_allowances <- map["form_ct1_data_allowances"]
		steps <- map["steps"]
        error <- map["error"]
		last_request_step <- map["last_request_step"]
	}

}
