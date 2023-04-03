//
//  MAPD724 W2023
//  Group 9
//  Assignment 2 - Frameworks App - Part 1
//  App description: Phone Order App
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  PhoneViewController.swift
//  Date: MAR 26, 2023
//  Version: 1.0
//

import UIKit

class PhoneViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var phone_model = [["iPhone 14 Pro Max", "iPhone 14 Pro","iPhone 14 Plus","iPhone 14","iPhone 13 Mini","iPhone 13","iPhone 12","iPhone SE"], ["Pixel 7 Pro","Pixel 7","Pixel 6a","Pixel 6", "Pixel 6 Pro"],["Galaxy S23 Ultra","Galaxy S23+","Galaxy S23","Galaxy S22 Ultra","Galaxy S22+","Galaxy S22","Galaxy Z Fold4","Galaxy Z Flip4","Galaxy S21 FE 5G","Galaxy Z Flip3 5G"]]
    var phone_image = [["iPhone 14 Pro Max", "iPhone 14 Pro","iPhone 14 Plus","iPhone 14","iPhone 13 Mini","iPhone 13","iPhone 12","iPhone SE"], ["Pixel 7 Pro","Pixel 7","Pixel 6a","Pixel 6", "Pixel 6 Pro"],["Galaxy S23 Ultra","Galaxy S23+","Galaxy S23","Galaxy S22 Ultra","Galaxy S22+","Galaxy S22","Galaxy Z Fold4","Galaxy Z Flip4","Galaxy S21 FE 5G","Galaxy Z Flip3 5G"]]
    var phone_price = [[1549,1399,1249,1099,849,999,849,579],[1179,599,599,799, 1179],[1649.99,1399.99,1179.99,1789.99,1399.99 ,969.99,2269.99,1259.99,819.99,1129.99]]
    
    let cellReuseIdentifier = "cell"
    var currentTableView: Int!
    var brandText: String!
    
    @IBOutlet weak var brandSegmentedControl: UISegmentedControl!
    @IBOutlet weak var phoneTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneTableView.dataSource = self
        phoneTableView.delegate = self
        currentTableView = 0
        brandText = "Apple"
        
        brandSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.selected)
        brandSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phone_model[currentTableView].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PhoneTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PhoneTableViewCell
        cell.phoneModel.text = phone_model[currentTableView][indexPath.row]
        cell.phonePrice.text = "From $" + String(phone_price[currentTableView][indexPath.row])
        cell.phoneImage.image = UIImage(named: phone_image[currentTableView][indexPath.row])
        return cell
    }
    
    @IBAction func brandSwitch(_ sender: UISegmentedControl) {
        currentTableView = sender.selectedSegmentIndex
        phoneTableView.reloadData()
        brandText = sender.titleForSegment(at: sender.selectedSegmentIndex)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let phoneDetails = storyboard?.instantiateViewController(identifier:"PhoneDetailsViewController") as? PhoneDetailsViewController {
            phoneDetails.phoneImage = UIImage(named: phone_image[currentTableView][indexPath.row])!
            phoneDetails.phoneName = phone_model[currentTableView][indexPath.row]
            phoneDetails.phonePrice = phone_price[currentTableView][indexPath.row]
            phoneDetails.brandText = brandText
            self.navigationController?.pushViewController(phoneDetails, animated: true)
        }
    }
}
