//
//  TodoListCell.swift
//  TodoCleanSwiftSample
//
//  Created by Lina Choi on 2021/01/22.
//  Copyright © 2021 Nali. All rights reserved.
//

import UIKit

protocol TodoListCellDelegate {
    var completion: (Todo) -> () { get set }
    func updateCell()
}

class TodoListCell: UITableViewCell {

    var delegate: TodoListCellDelegate?

    @IBOutlet weak var todoCheckButton: UIButton!
    @IBOutlet weak var todoListTitleLabel: UILabel!

    @IBAction func touchTodoCheckButton(_ sender: Any) {
        if let sender = sender as? UIButton {
            sender.isSelected.toggle()
            delegate?.updateCell()
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
