//
//  MAPD724 W2023
//  Group 9
//  Assignment 2 - Frameworks App - Part 1
//  App description: Phone Order App
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  Store.swift
//  Date: MAR 26, 2023
//  Version: 1.0
//

import Foundation

class Store {
    var name = ""
    var address = ""
    var phone = ""
    var hours = ""
    var website = ""
    var lat = ""
    var lng = ""
    
    public func toMap() -> [String : String] {
        var data = [String : String]()
        data["name"] = name
        data["address"] = address
        data["phone"] = phone
        data["hours"] = hours
        data["website"] = website
        data["lat"] = lat
        data["lng"] = lng
        return data
    }
}
