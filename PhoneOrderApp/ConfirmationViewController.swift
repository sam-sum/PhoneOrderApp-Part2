//
//  MAPD724 W2023
//  Group 9
//  Assignment 2 - Frameworks App - Part 1
//  App description: Phone Order App
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  ConfirmationViewController.swift
//  Date: MAR 26, 2023
//  Version: 1.0
//

import UIKit

class ConfirmationViewController: UIViewController {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var storageLabel: UILabel!
    @IBOutlet weak var errorMsgLabel: UILabel!
    @IBOutlet weak var customerNameTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var postalCodeTextField: UITextField!
    @IBOutlet weak var creditCardNumTextField: UITextField!
    @IBOutlet weak var creditCardExpiryDateTextField: UITextField!
    @IBOutlet weak var creditCardCVVTextField: UITextField!
    @IBOutlet weak var creditCardHolderTextField: UITextField!
    
    private var order: PhoneOrder = PhoneOrder()
    public func setOrder(order: PhoneOrder) {
        self.order = order
    }
    
    
    private var customerRepository: CustomerRepository? = nil
    private var phoneOrderRepository: PhoneOrderRepository? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)

        priceLabel.text = "$" + String(order.price)
        modelLabel.text = order.model
        colorLabel.text = order.color
        storageLabel.text = order.storage
        errorMsgLabel.isHidden = true
        customerRepository = CustomerRepository(delegate: self)
        phoneOrderRepository = PhoneOrderRepository(delegate: self)
        
        creditCardNumTextField.allTargets.suffix(16)
        
        
        loadExistingCustomerInfo()
    }

    @objc func willEnterForeground() {
        (UIApplication.shared.delegate as? AppDelegate)?.overrideThemeStyle()
    }
    
    @IBAction func onBtnConfirmTouchUpInside(_ sender: UIButton) {
        if (!validateInputs()) {
            return
        }
        
        order.customerName = customerNameTextField.text!
        order.phoneNum = phoneNumTextField.text!
        order.address = addressTextField.text!
        order.city = cityTextField.text!
        order.postalCode = postalCodeTextField.text!
        order.creditCardNum = creditCardNumTextField.text!
        order.creditCardExpiryDate = creditCardExpiryDateTextField.text!
        order.creditCardCVV = creditCardCVVTextField.text!
        order.creditCardHolder = creditCardHolderTextField.text!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
        dateFormatter.locale = Locale(identifier: "ca")
        order.createDate = dateFormatter.string(from: Date())
        order.status = "Ordered"
        
        saveOrder()
    }
    
    private func validateInputs() -> Bool {
        if (customerNameTextField.text == "") {
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
        if (creditCardNumTextField.text == "") {
            errorMsgLabel.text = "Error: credit card number is invalid"
            errorMsgLabel.isHidden = false
            return false
        }
        if (creditCardExpiryDateTextField.text == "") {
            errorMsgLabel.text = "Error: expiry date is invalid"
            errorMsgLabel.isHidden = false
            return false
        }
        if (creditCardCVVTextField.text == "") {
            errorMsgLabel.text = "Error: CVV is invalid"
            errorMsgLabel.isHidden = false
            return false
        }
        if (creditCardHolderTextField.text == "") {
            errorMsgLabel.text = "Error: credit card holder name is invalid"
            errorMsgLabel.isHidden = false
            return false
        }
        return true
    }
    
    private func saveOrder() {
        let customerId = PhoneOrderAppSetting.sharedPhoneOrderAppSetting.getCustomerId()
        if (customerId == nil) {
            var customer = Customer()
            customer.name = order.customerName
            customer.phoneNum = order.phoneNum
            customer.address = order.address
            customer.city = order.city
            customer.postalCode = order.postalCode
            customerRepository!.saveCustomer(customer: customer) // save order in the delegate after created new Customer
        }
        else {
            phoneOrderRepository!.savePhoneOrder(customerId: customerId!, order: order)
        }
    }
    
    private func loadExistingCustomerInfo() {
        let customerId = PhoneOrderAppSetting.sharedPhoneOrderAppSetting.getCustomerId()
        if (customerId == nil) {
            return
        }
        customerRepository!.getCustomer(customerId: customerId!)
    }
    
    private func fillCustomerInfoTextFields(customer: Customer) {
        customerNameTextField.text = customer.name
        phoneNumTextField.text = customer.phoneNum
        addressTextField.text = customer.address
        cityTextField.text = customer.city
        postalCodeTextField.text = customer.postalCode
    }
    
    private func navigateToOrderCompletionScreen() {
        if let toVC = storyboard?.instantiateViewController(identifier:"OrderCompletionViewController") as? OrderCompletionViewController {
            toVC.setOrder(order: order)
            self.navigationController?.pushViewController(toVC, animated: true)
        }
    }
}

extension ConfirmationViewController: CustomerRepositoryDelegate {
    func onCustomerSaved(customer: Customer) {
        PhoneOrderAppSetting.sharedPhoneOrderAppSetting.setCustomerId(customerId: customer.id)
        phoneOrderRepository!.savePhoneOrder(customerId: customer.id, order: order)
    }
    
    func onCustomerReceived(customer: Customer) {
        fillCustomerInfoTextFields(customer: customer)
    }
    
    func onCustomerUpdated(customer: Customer) {
        return
    }
}

extension ConfirmationViewController: PhoneOrderRepositoryDelegate {
    func onPhoneOrderSaved(order: PhoneOrder) {
        navigateToOrderCompletionScreen()
    }
    
    func onPhoneOrdersReceived(orders: [PhoneOrder]) {
        return
    }
}
