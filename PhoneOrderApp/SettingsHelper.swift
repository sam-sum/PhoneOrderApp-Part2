//
//  MAPD724 W2023
//  Group 9
//  Assignment 2 - Frameworks App - Part 2
//  App description: Phone Order App
//  Author: Po Lam Wong, Lizolet (301258847)
//          Chi Hung Sum, Samuel (300858503)
//          Chun Fun Suen, Alan (301277969)

//  SettingsHelper.swift
//  Date: Apr 3, 2023
//  Version: 1.0
//

import Foundation

class SettingsHelper {
    struct SettingsKeys {
        static let AppTheme = "APP_THEME_KEY"
        static let BuildVersionKey = "build_pref"
        static let AppVersionKey = "version_pref"
    }
    
    class func setVersionAndBuildNumber() {
        let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        UserDefaults.standard.set(version, forKey: "version_pref")
        let build: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        UserDefaults.standard.set(build, forKey: "build_pref")
    }
}
