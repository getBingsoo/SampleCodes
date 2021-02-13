//
//  MyTableViewCell.swift
//  TestAnimation
//
//  Created by 60067667 on 2020/10/29.
//  Copyright © 2020 Lina Choi. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

//    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
}
