//
//  AllJournalVouchersTableViewCell.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 19/02/2023.
//  Copyright © 2023 Samar Akkila. All rights reserved.
//

import UIKit
import DropDown


protocol AllJournalVouchersCellDelegate{
    func viewReceipt(journal_voucher_id:String)
    func editReceipt(journal_voucher_id:String)
    func deleteReceipt(journal_voucher_id:String)
    func exportPDFReceipt(journal_voucher_id:String)
    func exportExcelReceipt(journal_voucher_id:String)
    func exportPDFToEmailReceipt(journal_voucher_id:String)
    func exportExcelToEmailReceipt(journal_voucher_id:String)
}

typealias  AllJournalVouchersDelegate = AllJournalVouchersCellDelegate & UIViewController

class AllJournalVouchersTableViewCell: UITableViewCell {

    @IBOutlet weak var journalNumberLabel: UILabel!
    @IBOutlet weak var requestNumberLabel: UILabel!
    @IBOutlet weak var journalDateLabel: UILabel!
    @IBOutlet weak var journalAmountLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var onDateLabel: UILabel!
    
    @IBOutlet weak var moreButton: UIButton!
    
    private var journal_voucher_id = ""
    
    private var moreDropDown = DropDown()
    weak var delegate: AllJournalVouchersDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpDropDownList()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:AllJournalVoucherRecord){
        journal_voucher_id = data.journal_voucher_id ?? ""
        journalNumberLabel.text = data.journal_system_code ?? "----"
        requestNumberLabel.text = data.transaction_id ?? "----"
        journalDateLabel.text = data.transaction_date ?? "----"
        journalAmountLabel.text = data.transaction_amount ?? "----"
        writerLabel.text = data.writer_name ?? "----"
        onDateLabel.text = data.transaction_created_date ?? "----"
    }
    
    private func setUpDropDownList(){
        //        moreDropDown
        moreDropDown.anchorView = moreButton
        moreDropDown.bottomOffset = CGPoint(x: -bounds.width, y:(moreDropDown.anchorView?.plainView.bounds.height)!)
        moreDropDown.dataSource = ["View","Edit","Delete","Export PDF","Export Excel","Export PDF to Email","Export Excel to Email"]
        moreDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            switch index{
            case 0:
                self?.delegate?.viewReceipt(journal_voucher_id: self?.journal_voucher_id ?? "")
            case 1:
                self?.delegate?.editReceipt(journal_voucher_id: self?.journal_voucher_id ?? "")
            case 2:
                self?.delegate?.deleteReceipt(journal_voucher_id: self?.journal_voucher_id ?? "")
            case 3:
                self?.delegate?.exportPDFReceipt(journal_voucher_id: self?.journal_voucher_id ?? "")
            case 4:
                self?.delegate?.exportExcelReceipt(journal_voucher_id: self?.journal_voucher_id ?? "")
            case 5:
                self?.delegate?.exportPDFToEmailReceipt(journal_voucher_id: self?.journal_voucher_id ?? "")
            case 6:
                self?.delegate?.exportExcelToEmailReceipt(journal_voucher_id: self?.journal_voucher_id ?? "")
            default:
                break
            }
        }
    }
    
    @IBAction func moreAction(_ sender: Any) {
        moreDropDown.show()
    }
}
