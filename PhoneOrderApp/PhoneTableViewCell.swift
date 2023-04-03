//
//  MAPD724 W2023
//  Group 9
//  Assignment 2 - Frameworks App - Part 1
//  App description: Phone Order App
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  PhoneTableViewCell.swift
//  Date: MAR 26, 2023
//  Version: 1.0
//

import UIKit

class PhoneTableViewCell: UITableViewCell {

    @IBOutlet weak var phoneImage: UIImageView!
    @IBOutlet weak var phoneModel: UILabel!
    @IBOutlet weak var phonePrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
