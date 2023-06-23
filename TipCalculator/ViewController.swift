//
//  ViewController.swift
//  TipCalculator
//
//  Created by Aslıhan Gürkan on 20.06.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleCalLabel: UILabel!
    @IBOutlet weak var opaqueBgView: UIView!
    @IBOutlet weak var greenBlockView: UIView!
    @IBOutlet weak var tipPickerView: UIPickerView!
    @IBOutlet weak var peoplePickerView: UIPickerView!
    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipPerPersonLabel: UILabel!
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    @IBOutlet weak var billTotalLabel: UILabel!
    
    var tipPicker : TipPicker!
    var peoplePicker : PeoplePicker!
    var rotationAngle: CGFloat!
    var selectedTip: Decimal = 0.0
    var selectedPeopleCount: Decimal = 0.0
    var billAmount: Decimal = 0.0
    
    var tipAmount: Decimal = 0.0        // tip Total
    var tipPerPerson: Decimal = 0.0     // tip each person
    var totalPerPerson: Decimal = 0.0   // total each person
    var billTotal: Decimal = 0.0        // total (bill + tip)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipPicker = TipPicker()
        peoplePicker = PeoplePicker()
        
        billTextField.delegate = self
        tipPickerView.dataSource = tipPicker
        tipPickerView.delegate = tipPicker
        peoplePickerView.dataSource = peoplePicker
        peoplePickerView.delegate = peoplePicker
        setupViews()
        
    }
    
    private func setupViews() {
        tipPickerView.layer.borderWidth = 0
        tipPickerView.layer.cornerRadius = 20
        peoplePickerView.layer.borderWidth = 0
        peoplePickerView.layer.cornerRadius = 20
        
        rotationAngle = -(90 * (.pi/180))
        var y = tipPickerView.frame.origin.y
        tipPickerView.transform = CGAffineTransform(rotationAngle: rotationAngle)
        tipPickerView.frame = CGRect(x: 200, y: y, width: 150, height: 40)
        
        y = peoplePickerView.frame.origin.y
        peoplePickerView.transform = CGAffineTransform(rotationAngle: rotationAngle)
        peoplePickerView.frame = CGRect(x: 200, y: y, width: 150, height: 40)
        //y:view.frame.width
        
        titleLabel.font = UIFont(name: "Baskerville-Italic", size: 50)
        titleCalLabel.font = UIFont(name: "Baskerville-Italic", size: 30)
        
        opaqueBgView.layer.cornerRadius = 35
        
        /*
        greenBlockView.layer.shadowOpacity = 0.7
        greenBlockView.layer.shadowOffset = CGSize(width: 3, height: 3)
        greenBlockView.layer.shadowRadius = 15.0
        greenBlockView.layer.shadowColor = UIColor.darkGray.cgColor
        
        tipPickerView.translatesAutoresizingMaskIntoConstraints = false
        tipPickerView.showsSelectionIndicator = false
          */
    }
    
    
    @IBAction func calculateClick(_ sender: Any) {
        calculateTipPercent()
    }
    
    func calculateTipPercent() {
        
        selectedTip = Decimal(string: tipPicker.selectedTipValue) ?? 10.0
        selectedPeopleCount = Decimal(string: peoplePicker.selectedPeopleCountValue) ?? 1.0
        
        let billText = billTextField.text ?? ""
        let bill = Decimal(string: billText) ?? 0.0
        tipAmount = bill * (selectedTip / 100)
        
        
        tipPerPerson = tipAmount / selectedPeopleCount
        totalPerPerson = tipPerPerson + (bill/selectedPeopleCount)
        billTotal = bill + tipAmount
        
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        tipAmountLabel.text =  "$" + (formatter.string(for: tipAmount) ?? "0.0")
        tipPerPersonLabel.text = "$" + (formatter.string(for: tipPerPerson) ?? "0.0")
        totalPerPersonLabel.text = "$" + (formatter.string(for: totalPerPerson) ?? "0.0")
        billTotalLabel.text = "$" + (formatter.string(for: billTotal) ?? "0.0")
    }
}

extension ViewController : UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if billTextField == textField {
            let allowedCharacters = ".1234567890"
            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharacterSetIn = CharacterSet(charactersIn: string)
            return allowedCharacterSet.isSuperset(of: typedCharacterSetIn)
        }
        return true
    }
}
