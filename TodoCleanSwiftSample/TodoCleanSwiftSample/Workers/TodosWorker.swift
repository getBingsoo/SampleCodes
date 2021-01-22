//
//  TodoListWorker.swift
//  TodoCleanSwiftSample
//
//  Created by 60067667 on 2021/01/22.
//  Copyright © 2021 Nali. All rights reserved.
//

import Foundation

class TodosWorker {
    var todosStore: TodoStoreProtocol

      init(todosStore: TodoStoreProtocol) {
          self.todosStore = todosStore
      }

    func fetchTodos(completionHandler: @escaping ([Todo]) -> Void) {
        todosStore.fetchTodos { (todos: () throws -> [Todo]) -> Void in
            do {
                let todos = try todos()
                DispatchQueue.main.async {
                    completionHandler(todos)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler([])
                }
            }
        }
    }

    func updateTodo(todoToUpdate: Todo, completionHandler: @escaping (Todo?) -> Void)
    {
        todosStore.updateTodo(todoToUpdate: todoToUpdate) { (todo: () throws -> Todo?) in
            do {
                let todo = try todo()
                DispatchQueue.main.async {
                    completionHandler(todo)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(nil)
                }
            }
        }
    }
}


protocol TodoStoreProtocol {
    func fetchTodos(completionHandler: @escaping (() throws -> [Todo]) -> Void)
    func updateTodo(todoToUpdate: Todo, completionHandler: @escaping (() throws -> Todo?) -> Void)
}


enum TodosStoreResult<U>
{
  case Success(result: U)
  case Failure(error: TodosStoreError)
}

enum TodosStoreError: Equatable, Error
{
  case CannotFetch(String)
  case CannotUpdate(String)
}
