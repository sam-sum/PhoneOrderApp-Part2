//
//  MAPD724 W2023
//  Group 9
//  Assignment 2 - Frameworks App - Part 1
//  App description: Phone Order App
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  EditProfileViewController.swift
//  Date: MAR 26, 2023
//  Version: 1.0
//

import UIKit

class EditProfileViewController: UIViewController {
    @IBOutlet weak var errorMsgLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var postalCodeTextField: UITextField!
    
    private var customer: Customer = Customer()
    public func setCustomer(customer: Customer) {
        self.customer = customer
    }
    
    private var customerRepository: CustomerRepository? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        customerRepository = CustomerRepository(delegate: self)
        
        nameTextField.text = customer.name
        phoneNumTextField.text = customer.phoneNum
        addressTextField.text = customer.address
        cityTextField.text = customer.city
        postalCodeTextField.text = customer.postalCode
        errorMsgLabel.isHidden = true
    }
    
    @objc func willEnterForeground() {
        (UIApplication.shared.delegate as? AppDelegate)?.overrideThemeStyle()
    }
    
    @IBAction func onBtnConfirmTouchUpInside(_ sender: UIButton) {
        if (!validateInputs()) {
            return
        }
        
        customer.name = nameTextField.text!
        customer.phoneNum = phoneNumTextField.text!
        customer.address = addressTextField.text!
        customer.city = cityTextField.text!
        customer.postalCode = postalCodeTextField.text!
        
        customerRepository?.updateCustomer(customer: customer)
    }
    
    private func navigateToProfileScreen() {
        if let toVC = storyboard?.instantiateViewController(identifier:"ProfileViewController") as? ProfileViewController {
            self.navigationController?.pushViewController(toVC, animated: true)
        }
    }
    
    private func validateInputs() -> Bool {
        if (nameTextField.text == "") {
            errorMsgLabel.text = "Error: customer name is invalid!"
            errorMsgLabel.isHidden = false
            return false
        }
        if (phoneNumTextField.text == "") {
            errorMsgLabel.text = "Error: phone number is invalid"
            errorMsgLabel.isHidden = false
            return false
        }
        if (addressTextField.text == "") {
            errorMsgLabel.text = "Error: address is invalid"
            errorMsgLabel.isHidden = false
            return false
        }
        if (cityTextField.text == "") {
            errorMsgLabel.text = "Error: city is invalid"
            errorMsgLabel.isHidden = false
            return false
        }
        if (postalCodeTextField.text == "") {
            errorMsgLabel.text = "Error: postal code is invalid"
            errorMsgLabel.isHidden = false
            return false
        }
        return true
    }
    
    private func saveCustomer() {
        print(customer.name)
        print(customer.phoneNum)
        print(customer.address)
        print(customer.city)
        print(customer.postalCode)
    }
}

extension EditProfileViewController: CustomerRepositoryDelegate {
    func onCustomerUpdated(customer: Customer) {
        navigateToProfileScreen()
    }
    
    func onCustomerSaved(customer: Customer) {
        return
    }
    
    func onCustomerReceived(customer: Customer) {
        return
    }
}
