//
//  MAPD724 W2023
//  Group 9
//  Assignment 2 - Frameworks App - Part 2
//  App description: Phone Order App
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  StoreDetailViewController.swift
//  Date: Apr 3, 2023
//  Version: 1.0
//

import UIKit

class StoreDetailViewController: UIViewController {

    var store = MyPointAnnotation()
    var parentVC: LocationsViewController!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblWebsite: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    @objc func willEnterForeground() {
        (UIApplication.shared.delegate as? AppDelegate)?.overrideThemeStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        lblName.text = store.name
        lblAddress.text = store.address
        lblHours.text = store.hours
        lblPhone.text = store.phone
        lblWebsite.text = store.website
    }
    
    @IBAction func routeButtonDidCliecked(_ sender: UIButton) {
        parentVC.drawRoute(storeLocation: store.coordinate)
    }
}
