//
//  MAPD724 W2023
//  Group 9
//  Assignment 2 - Frameworks App - Part 2
//  App description: Phone Order App
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  PhoneOrderAppSetting.swift
//  Date: Apr 11, 2023
//  Version: 2.0
//

import Foundation

// Manage the PhoneOrderApp settings saved in the user defaults
class PhoneOrderAppSetting {
    static let sharedPhoneOrderAppSetting: PhoneOrderAppSetting = PhoneOrderAppSetting()
    private static let customerIdKey: String = "customerId"
    private var customerId: String?
    
    // load PhoneOrderApp settings from the user defaults
    init() {
        customerId = UserDefaults.standard.string(forKey: PhoneOrderAppSetting.customerIdKey)
    }
    
    func getCustomerId() -> String? {
        return customerId
    }
    
    func setCustomerId(customerId: String) {
        self.customerId = customerId
        UserDefaults.standard.set(self.customerId, forKey: PhoneOrderAppSetting.customerIdKey)
        UserDefaults.standard.synchronize()
    }
}
