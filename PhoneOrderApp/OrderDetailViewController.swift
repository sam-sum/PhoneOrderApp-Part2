//
//  MAPD724 W2023
//  Group 9
//  Assignment 2 - Frameworks App - Part 1
//  App description: Phone Order App
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  OrderDetailViewController.swift
//  Date: MAR 26, 2023
//  Version: 1.0
//

import UIKit

class OrderDetailViewController: UIViewController {
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var storageLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderStatusLabel: UILabel!
    @IBOutlet weak var phoneImage: UIImageView!
    
    private var order: PhoneOrder = PhoneOrder()
    public func setOrder(order: PhoneOrder) {
        self.order = order
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        modelLabel.text = order.model
        storageLabel.text = order.storage
        colorLabel.text = order.color
        orderDateLabel.text = "Order Date: \n" + order.createDate
        orderStatusLabel.text = "Order Status: \n" + order.status
        phoneImage.image = UIImage(named: "iPhone 14 Pro Max")
    }

    @objc func willEnterForeground() {
        (UIApplication.shared.delegate as? AppDelegate)?.overrideThemeStyle()
    }
}
