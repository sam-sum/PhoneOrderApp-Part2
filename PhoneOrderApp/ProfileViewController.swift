//
//  MAPD724 W2023
//  Group 9
//  Assignment 2 - Frameworks App - Part 2
//  App description: Phone Order App
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  ProfileViewController.swift
//  Date: Apr 3, 2023
//  Version: 1.0
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var customerInfoView: UIView!
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var customerAddressLabel: UILabel!
    
    var orders: [PhoneOrder] = []
    var customer: Customer = Customer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onCustomerInfoViewTapped(_:)))
        customerInfoView.addGestureRecognizer(tapGestureRecognizer)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
        dateFormatter.locale = Locale(identifier: "ca")
        var order = PhoneOrder()
        order.createDate = dateFormatter.string(from: Date())
        order.status = "Ordered"
        order.model = "iPhone 14 Pro Max"
        order.storage = "128GB"
        order.color = "Deep Purple"
        orders.append(order)
        order = PhoneOrder()
        order.createDate = dateFormatter.string(from: Date())
        order.status = "Ordered"
        order.model = "iPhone 14"
        order.storage = "256GB"
        order.color = "Gold"
        orders.append(order)
        
        customer.name = "Harry Potter"
        customer.phoneNum = "4161234567"
        customer.address = "937 Progress Avenue, Scarborough"
        customer.city = "Toronto"
        customer.postalCode = "M1G3T8"
        
        customerNameLabel.text = customer.name
        customerAddressLabel.text = customer.address
    }
    
    @objc func willEnterForeground() {
        (UIApplication.shared.delegate as? AppDelegate)?.overrideThemeStyle()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:OrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderTableViewCell
        let order = orders[indexPath.row]
        cell.statusLabel.text = order.status
        cell.modelLabel.text = order.model
        cell.storageLabel.text = order.storage
        cell.colorLabel.text = order.color
        cell.phoneImage.image = UIImage(named: "iPhone 14 Pro Max")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = orders[indexPath.row]
        if let toVC = storyboard?.instantiateViewController(identifier:"OrderDetailViewController") as? OrderDetailViewController {
            toVC.setOrder(order: order)
            self.navigationController?.pushViewController(toVC, animated: true)
        }
    }

    @objc private func onCustomerInfoViewTapped(_ sender: UITapGestureRecognizer) {
        if let toVC = storyboard?.instantiateViewController(identifier:"EditProfileViewController") as? EditProfileViewController {
            toVC.setCustomer(customer: customer)
            self.navigationController?.pushViewController(toVC, animated: true)
        }
    }
    
    @IBAction func HelpButtonDidClicked(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let helpDocVC = storyboard.instantiateViewController(withIdentifier: "HelpDocVC") as! HelpDocViewController
        //helpDocVC.openURL = URL(string:"https://www.apple.com")
        let htmlPath = Bundle.main.path(forResource: "ProfileHelp", ofType: "html")
        helpDocVC.openURL = URL(fileURLWithPath: htmlPath!)
        //self.navigationController?.pushViewController(helpDocVC,animated:true)
        if let sheet = helpDocVC.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        self.present(helpDocVC, animated: true, completion: nil)
    }
}
