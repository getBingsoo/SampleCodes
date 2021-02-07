//
//  TodoListPresenterTests.swift
//  TodoCleanSwiftSampleTests
//
//  Created by Lina Choi on 2021/02/08.
//  Copyright © 2021 Nali. All rights reserved.
//

import XCTest
@testable import TodoCleanSwiftSample

/// TodoListPresenterTests
/// - interactor로부터 받은 Response를 viewModel로 변경
/// - viewController에 viewModel 전달
class TodoListPresenterTests: XCTestCase {

    var sut: TodoListPresenter!

    override class func setUp() {
        print("클래스..setup..")
    }

    // MARK: - test lifecycle
    override func setUpWithError() throws {
        super.setUp()
        print("setup....")
        setupTodoListPresenter()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    // MARK: - test setup

    func setupTodoListPresenter() {
        sut = TodoListPresenter()
    }

    // MARK: - test doubles

    /// VC의 protocol을 받은 mock class.. VC 대신 쓰일 아이임
    class TodoListDisplayLoginSpy: TodoListDisplayLogic {

        /// fetch todo vm을 받을 아이
        var fetchTodosViewModel: TodoList.FetchTodos.ViewModel?
        var updatedTodoViewModel: TodoList.GetUpdatedTodo.ViewModel?

        func displayFetchedTodos(viewModel: TodoList.FetchTodos.ViewModel) {
            fetchTodosViewModel = viewModel
        }

        func displayUpdatedTodo(viewModel: TodoList.GetUpdatedTodo.ViewModel) {
            updatedTodoViewModel = viewModel
        }
    }


    // MARK: - Fetch Todos

    func test_presentFetchedTodos_formatTodosForDisplay() throws {
        // Given
        let displayLogicSpy = TodoListDisplayLoginSpy()
        sut.viewController = displayLogicSpy

        // When
        let response = TodoList.FetchTodos.Response(todos: [Todo(id: 1, todoContent: "밥먹기", isDone: true)])
        sut.presentFetchedTodos(response: response)

        // Then
        let displayedTodos = displayLogicSpy.fetchTodosViewModel?.displayedTodos
        XCTAssertEqual(displayedTodos?[0].isDone, true, "isDone 불일치")
        XCTAssertEqual(displayedTodos?[0].todoContent, "밥먹기", "content 불일치")
    }

    func test_presentUpdatedTodo_formatTodoForDisplay() {
        // Given
        let displayLoginSpy = TodoListDisplayLoginSpy()
        sut.viewController = displayLoginSpy

        // When
        let response = TodoList.GetUpdatedTodo.Response(updatedIndex: 3, todo: Todo(id: 23, todoContent: "업데이트", isDone: false))
        sut.presentUpdatedTodo(response: response)

        // Then
        let displayedUpdatedTodo = displayLoginSpy.updatedTodoViewModel
        XCTAssertEqual(displayedUpdatedTodo?.displayedTodo.isDone, false, "isDone 불일치")
        XCTAssertEqual(displayedUpdatedTodo?.displayedTodo.todoContent, "업데이트", "content 불일치")
        XCTAssertEqual(displayedUpdatedTodo?.indexToUpdate, 3, "index 불일치")
        
    }


}
