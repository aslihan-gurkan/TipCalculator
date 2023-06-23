//
//  PeoplePicker.swift
//  DesignTest
//
//  Created by Aslıhan Gürkan on 22.06.2023.
//

import UIKit

class PeoplePicker: UIPickerView {
    let peopleList = (1...50).map { "\($0)" }
    let width: CGFloat = 100
    let height: CGFloat = 100
    var selectedPeopleCountValue: String = ""
}

extension PeoplePicker : UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return peopleList.count
    }
}

extension PeoplePicker : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 45
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let peopleView = UIView()
        peopleView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        let peopleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        peopleLabel.font = UIFont.systemFont(ofSize: 30)
        peopleLabel.textColor = UIColor.white
        peopleLabel.text = peopleList[row]
        peopleLabel.textAlignment = .center
        
        peopleView.addSubview(peopleLabel)
        
        peopleView.transform = CGAffineTransform(rotationAngle: (90 * (.pi/180)))
        return peopleView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("\(peopleList[row])")
        var selectedPeopleCount = "\(peopleList[row])"
        selectedPeopleCountValue = selectedPeopleCount.components(separatedBy: "%")[0]
    }
}

