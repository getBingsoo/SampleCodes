//
//  Coordinator.swift
//  MVVMRxTutorial
//
//  Created by 60067667 on 2021/06/15.
//

import UIKit

class Coordinator {
    
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let rootViewController = RootViewController()
        let navigationRootViewController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navigationRootViewController
        window.makeKeyAndVisible()
    }
}
