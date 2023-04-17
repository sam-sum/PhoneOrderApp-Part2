//
//  MAPD724 W2023
//  Group 9
//  Assignment 2 - Frameworks App - Part 2
//  App description: Phone Order App
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  OrderCompletionViewController.swift
//  Date: MAR 26, 2023
//  Version: 1.0
//

import UIKit

class OrderCompletionViewController: UIViewController {
    private var order: PhoneOrder = PhoneOrder()
    public func setOrder(order: PhoneOrder) {
        self.order = order
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    @objc func willEnterForeground() {
        (UIApplication.shared.delegate as? AppDelegate)?.overrideThemeStyle()
    }
    
    @IBAction func onBtnBackToPhoneListTouchUpInside(_ sender: UIButton) {
        if let phoneViewController = storyboard?.instantiateViewController(withIdentifier: "PhoneViewController")
            as? PhoneViewController {
            //self.navigationController?.pushViewController(phoneViewController, animated: true)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}

