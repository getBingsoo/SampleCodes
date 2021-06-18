//
//  AppDelegate.swift
//  MusicPlayer
//
//  Created by 60067667 on 2021/06/18.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

//        Thread.sleep(forTimeInterval: 2) // 2초동안 스플래시

        // coordinator
        window = UIWindow(frame: UIScreen.main.bounds)
        let coordinator = AppCoordinator(window: window!)
        coordinator.start()

        return true
    }

}

