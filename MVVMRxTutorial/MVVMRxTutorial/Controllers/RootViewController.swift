//
//  RootViewController.swift
//  MVVMRxTutorial
//
//  Created by 60067667 on 2021/06/15.
//

import UIKit

class RootViewController: UIViewController {

    // MARK: Properties

    // MARK: LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuerUI()
    }

    // MARK: Configures
    func configuerUI() {
        view.backgroundColor = .red
    }
}
