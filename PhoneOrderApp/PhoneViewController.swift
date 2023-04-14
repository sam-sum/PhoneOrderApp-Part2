//
//  MAPD724 W2023
//  Group 9
//  Assignment 2 - Frameworks App - Part 2
//  App description: Phone Order App
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  PhoneViewController.swift
//  Date: Apr 3, 2023
//  Version: 1.0
//

import UIKit

class PhoneViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var phones = [Phone]()
    let cellReuseIdentifier = "cell"
    private var brandText: String!
    private var phoneRepository: PhoneRepository? = nil
    
    @IBOutlet weak var brandSegmentedControl: UISegmentedControl!
    @IBOutlet weak var phoneTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        phoneTableView.dataSource = self
        phoneTableView.delegate = self
        brandText = "Apple"
        phoneRepository = PhoneRepository(delegate: self)
        
        brandSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.selected)
        brandSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
        
        phoneRepository?.getPhonesByBrand(brand: brandText)
    }
    
    @objc func willEnterForeground() {
        (UIApplication.shared.delegate as? AppDelegate)?.overrideThemeStyle()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PhoneTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PhoneTableViewCell
        let phone = phones[indexPath.row]
        cell.phoneModel.text = phone.model
        cell.phonePrice.text = "From $" + String(phone.price)
        cell.phoneImage.image = UIImage(named: phone.model)
        return cell
    }
    
    @IBAction func brandSwitch(_ sender: UISegmentedControl) {
        brandText = sender.titleForSegment(at: sender.selectedSegmentIndex)
        phoneRepository?.getPhonesByBrand(brand: brandText)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let phoneDetails = storyboard?.instantiateViewController(identifier:"PhoneDetailsViewController") as? PhoneDetailsViewController {
            let phone = phones[indexPath.row]
            phoneDetails.phone = phone
            phoneDetails.brandText = brandText
            self.navigationController?.pushViewController(phoneDetails, animated: true)
        }
    }
    
    @IBAction func HelpButtonDidClicked(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let helpDocVC = storyboard.instantiateViewController(withIdentifier: "HelpDocVC") as! HelpDocViewController
        //helpDocVC.openURL = URL(string:"https://www.apple.com")
        let htmlPath = Bundle.main.path(forResource: "PhoneOrderHelp", ofType: "html")
        helpDocVC.openURL = URL(fileURLWithPath: htmlPath!)
        //self.navigationController?.pushViewController(helpDocVC,animated:true)
        if let sheet = helpDocVC.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        self.present(helpDocVC, animated: true, completion: nil)
    }
}

extension PhoneViewController: PhoneRepositoryDelegate {
    func onPhonesReceived(phones: [Phone]) {
        self.phones = phones
        phoneTableView.reloadData()
    }
}
