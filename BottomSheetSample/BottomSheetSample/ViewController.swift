//
//  ViewController.swift
//  BottomSheetSample
//
//  Created by 60067667 on 2021/02/26.
//

import UIKit

class ViewController: UIViewController {

    lazy var bottomUpSheetDelegate = BottomSheetPresentationManager(size: CGSize(width: .zero, height: 100))

    @IBAction func touchUpButton(_ sender: Any) {
        let vc = SheetViewController()
        vc.transitioningDelegate = bottomUpSheetDelegate
        vc.modalPresentationStyle = .custom

        present(vc, animated: true, completion: nil)


    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

