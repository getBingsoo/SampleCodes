//
//  ViewController.swift
//  AnimationSample
//
//  Created by Lina Choi on 2020/11/19.
//  Copyright © 2020 anil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func topDownAnim(_ sender: Any) {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "TopDownViewController")
        self.present(vcName!, animated: true, completion: nil)
    }
    
}

