//
//  SellingInvoiceTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 22/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown
protocol SellingInvoiceCellDelegate{
    func viewReceipt(invoice_id:String)
    func exportPDFReceipt(invoice_id:String)
    func exportExcelReceipt(invoice_id:String)
    func exportPDFToEmailReceipt(invoice_id:String)
    func exportExcelToEmailReceipt(invoice_id:String)
}

typealias SellingInvoiceDelegate = SellingInvoiceCellDelegate & UIViewController
class SellingInvoiceTableViewCell: UITableViewCell {
    @IBOutlet weak var invoiceNoLabel: UILabel!
    @IBOutlet weak var requestNumberLabel: UILabel!
    @IBOutlet weak var invoiceDateLabel: UILabel!
    @IBOutlet weak var paymentModeLabel: UILabel!
    @IBOutlet weak var customersLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    private var invoice_id = ""
    private var moreDropDown = DropDown()
    weak var delegate: SellingInvoiceDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpDropDownList()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setData(data:SellingInvoiceRecord){
        self.invoice_id = data.invoice_id ?? ""
        invoiceNoLabel.text = data.invoice_system_code ?? "----"
        requestNumberLabel.text = data.transaction_id ?? "----"
        invoiceDateLabel.text = data.invoice_date ?? "----"
        paymentModeLabel.text = data.payment_name ?? "----"
        customersLabel.text = data.customer_account ?? "----"
        writerLabel.text = data.writer_name ?? "----"
        dateLabel.text = data.invoice_created_date ?? "----"
    }
    
    
    @IBAction func moreAction(_ sender: Any) {
        moreDropDown.show()
    }
    
    private func setUpDropDownList(){
        //        moreDropDown
        moreDropDown.anchorView = moreButton
        moreDropDown.bottomOffset = CGPoint(x: -bounds.width, y:(moreDropDown.anchorView?.plainView.bounds.height)!)
        moreDropDown.dataSource = ["Export PDF","Export Excel","Export PDF to Email","Export Excel to Email"]
        moreDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            switch index{
//            case 0:
//                self?.delegate?.viewReceipt(invoice_id: self?.invoice_id ?? "")
            case 0:
                self?.delegate?.exportPDFReceipt(invoice_id: self?.invoice_id ?? "")
            case 1:
                self?.delegate?.exportExcelReceipt(invoice_id: self?.invoice_id ?? "")
            case 2:
                self?.delegate?.exportPDFToEmailReceipt(invoice_id: self?.invoice_id ?? "")
            case 3:
                self?.delegate?.exportExcelToEmailReceipt(invoice_id: self?.invoice_id ?? "")
            default:
                break
            }
        }
    }
}
