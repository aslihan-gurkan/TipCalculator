//
//  TipPicker.swift
//  DesignTest
//
//  Created by Aslıhan Gürkan on 22.06.2023.
//

import UIKit

class TipPicker: UIPickerView {
    let tipList = ["10%","11%","12%","13%","14%", "15%","16%","17%","18%","19%","20%","21%","22%","23%","24%","25%"]
    let width: CGFloat = 100
    let height: CGFloat = 100
    var selectedTipValue: String = ""
}

extension TipPicker : UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tipList.count
    }
}

extension TipPicker : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 45
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let tipView = UIView()
        tipView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        let tipLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        tipLabel.font = UIFont.systemFont(ofSize: 20)
        tipLabel.textColor = UIColor.white
        tipLabel.text = tipList[row]
        tipLabel.textAlignment = .center
        
        tipView.addSubview(tipLabel)
        
        tipView.transform = CGAffineTransform(rotationAngle: (90 * (.pi/180)))
        return tipView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("\(tipList[row])")
        var selectedTip = "\(tipList[row])"
        selectedTipValue = selectedTip.components(separatedBy: "%")[0]
    }
}
