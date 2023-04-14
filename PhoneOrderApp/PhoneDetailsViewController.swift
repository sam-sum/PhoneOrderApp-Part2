//
//  MAPD724 W2023
//  Group 9
//  Assignment 2 - Frameworks App - Part 1
//  App description: Phone Order App
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  PhoneDetailsViewController.swift
//  Date: MAR 26, 2023
//  Version: 1.0
//

import UIKit

class PhoneDetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var sizeTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var phoneImageView: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phonePriceLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    
    //used picker view for drop down menu
    private var sizePickerView = UIPickerView()
    private var colorPickerView = UIPickerView()
    
    var phone = Phone()
    var brandText = ""
    private var storages = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)

        sizeTextField.inputView = sizePickerView
        colorTextField.inputView = colorPickerView
        
        sizeTextField.placeholder = "Select Storage Size"
        colorTextField.placeholder = "Pick your favourite Color "
        
        sizeTextField.textAlignment = .center
        colorTextField.textAlignment = .center
        
        sizePickerView.delegate = self
        colorPickerView.delegate = self
        sizePickerView.dataSource = self
        colorPickerView.dataSource = self
        
        sizePickerView.tag = 1
        colorPickerView.tag = 2
        
        phoneLabel.text = phone.model
        phoneImageView.image = UIImage(named: phone.model)
        brandLabel.text = "Brand: " + brandText
        phonePriceLabel.text = String(phone.price)
        storages = Array(phone.storagesAndPrices.keys)
    }
    
    @objc func willEnterForeground() {
        (UIApplication.shared.delegate as? AppDelegate)?.overrideThemeStyle()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //function for drop down menu
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return storages.count
        case 2:
            return phone.colors.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return storages[row]
        case 2:
            return phone.colors[row]
        default:
            return "Data not found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            sizeTextField.text = storages[row]
            phonePriceLabel.text = String(phone.storagesAndPrices[storages[row]]!)
            sizeTextField.resignFirstResponder()
            break
        case 2:
            colorTextField.text = phone.colors[row]
            var imageName = phone.model + "_" + phone.colors[row]
            imageName = imageName.replacingOccurrences(of: " ", with: "")
            phoneImageView.image = UIImage(named: imageName)
            colorTextField.resignFirstResponder()
            break
        default:
            return
        }
    }

    @IBAction func onBtnContinueTouchUpInside(_ sender: UIButton) {
        let order = PhoneOrder()
        order.model = phone.model
        order.price = Double(phonePriceLabel.text!)!
        order.storage = sizeTextField.text!
        order.color = colorTextField.text!
        
        if sizeTextField.text!.isEmpty || colorTextField.text!.isEmpty {
            errorLabel.isHidden = false
            errorLabel.text = "Please select the storage size and color."
        } else {
            if let toVC = storyboard?.instantiateViewController(identifier:"ConfirmationViewController") as? ConfirmationViewController {
                toVC.setOrder(order: order)
                self.navigationController?.pushViewController(toVC, animated: true)
            }
        }
    }
}

