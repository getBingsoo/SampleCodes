//
//  TodoListCell.swift
//  TodoCleanSwiftSample
//
//  Created by Lina Choi on 2021/01/22.
//  Copyright © 2021 Nali. All rights reserved.
//

import UIKit

class TodoListCell: UITableViewCell {

    @IBOutlet weak var todoCheckButton: UIButton!
    @IBOutlet weak var todoListTitleLabel: UILabel!
    var item: TodoList.FetchTodos.ViewModel.DisplayedTodo! {
        didSet {
            // 뷰 세팅
            todoCheckButton.isSelected = item.isDone
            todoListTitleLabel.text = item.todoContent
        }
    }

    @IBAction func touchTodoCheckButton(_ sender: Any) {
        if let sender = sender as? UIButton {
            sender.isSelected.toggle()
            // 저장
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
