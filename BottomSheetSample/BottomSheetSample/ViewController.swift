//
//  ViewController.swift
//  BottomSheetSample
//
//  Created by 60067667 on 2021/02/26.
//

import UIKit

class ViewController: UIViewController {

    lazy var bottomUpSheetDelegate = BottomSheetPresentationManager()

    @IBAction func touchUpButton(_ sender: Any) {
        let vc = SheetViewController()
        vc.transitioningDelegate = bottomUpSheetDelegate
        vc.modalPresentationStyle = .custom
        
//        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)


    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

