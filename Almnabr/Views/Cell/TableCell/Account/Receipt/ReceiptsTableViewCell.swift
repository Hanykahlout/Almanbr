//
//  ReceiptsTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 01/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown

protocol ReceiptsTableViewCellDelegate{
    func viewReceipt(payment_receipt_id:String)
    func editReceipt(payment_receipt_id:String)
    func deleteReceipt(payment_receipt_id:String)
    func exportPDFReceipt(payment_receipt_id:String)
    func exportExcelReceipt(payment_receipt_id:String)
    func exportPDFToEmailReceipt(payment_receipt_id:String)
    func exportExcelToEmailReceipt(payment_receipt_id:String)
}

typealias ReceiptsCellDelegate = ReceiptsTableViewCellDelegate & UIViewController

class ReceiptsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var receiptNoLabel: UILabel!
    @IBOutlet weak var receiptNoTitleLabel: UILabel!
    @IBOutlet weak var requestNumberLabel: UILabel!
    @IBOutlet weak var actionModeLabel: UILabel!
    @IBOutlet weak var receiptFromLabel: UILabel!
    @IBOutlet weak var receiptFromTitleLabel: UILabel!
    @IBOutlet weak var receiptDateLabel: UILabel!
    @IBOutlet weak var receiptDateTitleLabel: UILabel!
    @IBOutlet weak var receiptAmountLabel: UILabel!
    @IBOutlet weak var receiptAmountTitleLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var onDateLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    private var moreDropDown = DropDown()
    private var payment_receipt_id = ""
    weak var delegate: ReceiptsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpDropDownList()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setUpDropDownList(){
        //        moreDropDown
        moreDropDown.anchorView = moreButton
        moreDropDown.bottomOffset = CGPoint(x: -bounds.width, y:(moreDropDown.anchorView?.plainView.bounds.height)!)
        moreDropDown.dataSource = ["View","Edit","Delete","Export PDF","Export Excel","Export PDF to Email","Export Excel to Email"]
        moreDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            switch index{
            case 0:
                self?.delegate?.viewReceipt(payment_receipt_id: self?.payment_receipt_id ?? "")
            case 1:
                self?.delegate?.editReceipt(payment_receipt_id: self?.payment_receipt_id ?? "")
            case 2:
                self?.delegate?.deleteReceipt(payment_receipt_id: self?.payment_receipt_id ?? "")
            case 3:
                self?.delegate?.exportPDFReceipt(payment_receipt_id: self?.payment_receipt_id ?? "")
            case 4:
                self?.delegate?.exportExcelReceipt(payment_receipt_id: self?.payment_receipt_id ?? "")
            case 5:
                self?.delegate?.exportPDFToEmailReceipt(payment_receipt_id: self?.payment_receipt_id ?? "")
            case 6:
                self?.delegate?.exportExcelToEmailReceipt(payment_receipt_id: self?.payment_receipt_id ?? "")
            default:
                break
            }
        }
        
        
    }
    
    
    func setData(data: ReceiptRecord,isPayment:Bool){
        if isPayment {
            receiptNoTitleLabel.text = "Payment No"
            receiptFromTitleLabel.text = "Payment From"
            receiptDateTitleLabel.text = "Payment Date"
            receiptAmountTitleLabel.text = "Payment Amount"
        }
        
        payment_receipt_id = data.payment_receipt_id ?? ""
        receiptNoLabel.text = data.payreceipt_system_code ?? "----"
        requestNumberLabel.text = data.transaction_id  ?? "----"
        actionModeLabel.text = "----"
        receiptFromLabel.text = data.payment_receipt_to_from ?? "----"
        receiptDateLabel.text = data.payment_receipt_date ?? "----"
        receiptAmountLabel.text = data.payment_receipt_amount ?? "----"
        writerLabel.text = data.writer_name ?? "----"
        onDateLabel.text = data.payment_receipt_created_date ?? "----"
    }
    
    
    @IBAction func moreAction(_ sender: Any) {
        moreDropDown.show()
    }
    
}
