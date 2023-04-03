//
//  AppDelegate.swift
//  PhoneOrderApp
//
//  Created by bee on 21/3/2023.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate {
    func overrideThemeStyle() {
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication
                .shared
                .connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .first { $0.isKeyWindow }
            if UserDefaults.standard.bool(forKey: SettingsHelper.SettingsKeys.AppTheme) {
                keyWindow?.overrideUserInterfaceStyle = .dark
            } else {
                keyWindow?.overrideUserInterfaceStyle = .light
            }
        } else {
            // iOS 12 or less
            if UserDefaults.standard.bool(forKey: SettingsHelper.SettingsKeys.AppTheme) {
                UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .dark
            } else {
                UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .light
            }
        }
    }
}
