//
//  TodoStore.swift
//  TodoCleanSwiftSample
//
//  Created by Lina Choi on 2021/01/22.
//  Copyright © 2021 Nali. All rights reserved.
//

import Foundation

class TodoStore: TodoStoreProtocol {

    static var todos = [Todo(todoContent: "코딱지 파기", isDone: true), Todo(todoContent: "코딱지 파기", isDone: true)]

    // 모든 todo를 가져온다.
    func fetchTodos(completionHandler: @escaping (() throws -> [Todo]) -> Void) {
        completionHandler { return type(of: self).todos }
    }

    // todo하나를 add한다.
    func addTodo(todoToAdd: Todo, completionHandler: @escaping (() throws -> [Todo]?) -> Void) {
        type(of: self).todos.append(todoToAdd) // 추가 후 list return
        completionHandler { return type(of: self).todos }
    }

    // todo 한개를 업데이트 한다.
    func updateTodo(todoToUpdate: Todo, completionHandler: @escaping (() throws -> [Todo]?) -> Void) {
        type(of: self).todos.append(todoToUpdate)
        completionHandler { return type(of: self).todos }
    }
}
