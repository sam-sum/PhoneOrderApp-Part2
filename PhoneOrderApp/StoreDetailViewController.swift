//
//  MAPD724 W2023
//  Group 9
//  Assignment 2 - Frameworks App - Part 1
//  App description: Phone Order App
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  StoreDetailViewController.swift
//  Date: MAR 26, 2023
//  Version: 1.0
//

import UIKit

class StoreDetailViewController: UIViewController {

    var store = MyPointAnnotation()
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblWebsite: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        lblName.text = store.name
        lblAddress.text = store.address
        lblHours.text = store.hours
        lblPhone.text = store.phone
        lblWebsite.text = store.website
    }
    
}
