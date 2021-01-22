//
//  TodoStore.swift
//  TodoCleanSwiftSample
//
//  Created by Lina Choi on 2021/01/22.
//  Copyright © 2021 Nali. All rights reserved.
//

import Foundation

class TodoStore: TodoStoreProtocol {

    static var todos = [Todo(todoContent: "코딱지 파기", isDone: true)]

    func fetchTodos(completionHandler: @escaping (() throws -> [Todo]) -> Void) {
        completionHandler { return type(of: self).todos }
    }

    func updateTodo(todoToUpdate: Todo, completionHandler: @escaping (() throws -> Todo?) -> Void) {
        type(of: self).todos.append(todoToUpdate)
        completionHandler { return todoToUpdate }
    }
}
