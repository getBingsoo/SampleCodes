//
//  TodoListCell.swift
//  TodoCleanSwiftSample
//
//  Created by Lina Choi on 2021/01/22.
//  Copyright © 2021 Nali. All rights reserved.
//

import UIKit

class TodoListCell: UITableViewCell {

    @IBOutlet weak var todoListTitleLabel: UILabel!
    @IBAction func todoCheckButton(_ sender: Any) {
        if let sender = sender as? UIButton {
            sender.isSelected.toggle()
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
