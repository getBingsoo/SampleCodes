//
//  CustomStackView.swift
//  AutoLayoutSample
//
//  Created by Lina Choi on 2021/02/16.
//  Copyright © 2021 lina. All rights reserved.
//

import Foundation
import UIKit

class CustomStackView: UIStackView {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var button: UIButton!


    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
//        commonInit()
    }

    func commonInit() {
        distribution = .fill
        alignment = .center

        let name = String(describing: CustomStackView.self)
        guard let loadedNib = Bundle.main.loadNibNamed(name, owner: self, options: nil) else { return }
        guard let stackView = loadedNib.first as? UIStackView else { return }
        self.addArrangedSubview(stackView)

//        if let nibView = Bundle.main.loadNibNamed(name, owner: self, options: nil)?.first as? UIView {
//            addArrangedSubview(nibView)
//        }
    }
}
