//
//  PickerVC.swift
//  Almnabr
//
//  Created by MacBook on 20/04/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import UIKit

class PickerVC: UIViewController {

    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    
    var arr_data:[String] = []
    var name:String = ""
    var index : Int = 0
    var delegate : ((_ name: String ,_ index:Int) -> Void)?
    //pickerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configGUI()

    }
    
    
    
    //MARK: - Config GUI
    //------------------------------------------------------
    func configGUI() {
        
        self.picker.delegate = self
        self.btnNext.setTitle("Done".localized(), for: .normal)
        self.btnCancel.setTitle("Cancel".localized(), for: .normal)
        self.btnNext.titleLabel?.font = .kufiRegularFont(ofSize: 14)
        self.btnCancel.titleLabel?.font = .kufiRegularFont(ofSize: 14)
        
        if arr_data.count > 0 {
            self.name = arr_data[0]
            self.index = 0
        }else{
            self.arr_data.append("No items found".localized())
        }
        
    }
    
    //MARK: - Button Action
    //------------------------------------------------------
    
    @IBAction func btnSubmit_Click(_ sender: UIButton) {
        if arr_data.contains("No items found".localized()) && arr_data.count == 1 {
            self.dismiss(animated: true, completion: nil)
        }else{
            delegate!(name, index)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func btnCancel_Click(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }

}
extension PickerVC : UIPickerViewDelegate, UIPickerViewDataSource {
    
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arr_data.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
      
        return arr_data[row]
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var attributedString: NSAttributedString!
        
        let item = arr_data[row]
        attributedString = NSAttributedString(string: item, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        
        return attributedString
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = .kufiRegularFont(ofSize: 15)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = arr_data[row]
        pickerLabel?.textColor = maincolor

        return pickerLabel!
    }
    

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 35.0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if pickerView.tag == 0 {
            print("tag 1")
            print(arr_data[row])
            self.name = (arr_data[row])
            self.index = row
            
        }

   }
}

