//
//  AppDelegate.swift
//  MassiveAppDelegateSample
//
//  Created by Lina Choi on 2021/01/13.
//  Copyright © 2021 lina. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let apps: [UIApplicationDelegate] = [ShinhanApplicationDelgate(), BApplicationDelegate()]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let serverFlag: Bool = false // 서버에서 내려온 플래그

        if serverFlag {
            apps[0].applicationDidFinishLaunching?(application)
        } else {
            apps[1].applicationDidFinishLaunching?(application)
        }

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


class ShinhanApplicationDelgate: NSObject {
    
}

extension ShinhanApplicationDelgate: UIApplicationDelegate {
    // AS-IS Sources..
    func applicationDidFinishLaunching(_ application: UIApplication) {
        ""
    }
}

class BApplicationDelegate: NSObject {

}

extension BApplicationDelegate: UIApplicationDelegate {
    func applicationDidFinishLaunching(_ application: UIApplication) {
        ""
    }
}
