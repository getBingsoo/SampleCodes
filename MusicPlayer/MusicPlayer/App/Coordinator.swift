//
//  Coordinator.swift
//  MusicPlayer
//
//  Created by 60067667 on 2021/06/18.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }

    func start()
}

class AppCoordinator: Coordinator {

    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }

    func start() {
        window.rootViewController = navigationController

        let coordinator = HomeCoordinator(navigationController: self.navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()

        window.makeKeyAndVisible()
    }
}

class HomeCoordinator: Coordinator {

    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        // https://ios-development.tistory.com/214
        let storyboard = UIStoryboard(name: "MusicDetail", bundle: Bundle.main)
        if let vc = storyboard.instantiateViewController(withIdentifier: "MusicDetailViewController") as? MusicDetailViewController {
            vc.viewModel = MusicDetailViewModel()
            vc.viewModel?.vc = vc
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
