//
//  TodoStore.swift
//  TodoCleanSwiftSample
//
//  Created by Lina Choi on 2021/01/22.
//  Copyright © 2021 Nali. All rights reserved.
//

import Foundation

class TodoStore: TodoStoreProtocol {

    static var todos = [Todo(id: 1, todoContent: "코딱지 파기", isDone: true), Todo(id: 2, todoContent: "코딱지 파기", isDone: true)]

    // 모든 todo를 가져온다.
    func fetchTodos(completionHandler: @escaping (() throws -> [Todo]) -> Void) {
        completionHandler { return type(of: self).todos }
    }

    func fetchLastTodo() -> Todo? {
        return (type(of: self).todos.last ?? nil)
    }

    // todo하나를 add한다.
    func addTodo(todoToAdd: Todo, completionHandler: @escaping (() throws -> [Todo]?) -> Void) {
        type(of: self).todos.append(todoToAdd) // 추가 후 list return
        completionHandler { return type(of: self).todos }
    }
    
    // todo 한개를 업데이트 한다.
    func updateTodo(todoToUpdate: Todo, completionHandler: @escaping (() throws -> [Todo]?) -> Void) {
        let idx = type(of: self).todos.firstIndex {
            return $0.id == todoToUpdate.id // firstIndex: id가 같은 첫번째 인자 하나의 index를 리턴
        }
        if let idx = idx {
            type(of: self).todos[idx] = todoToUpdate
            completionHandler { return type(of: self).todos } // 정상일 때 업데이트 후 리스트 리턴
        }
        completionHandler { return nil } // 비정상일 때 nil 리턴
    }
    
}
