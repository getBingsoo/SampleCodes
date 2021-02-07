//
//  TodoListInteractorTests.swift
//  TodoCleanSwiftSampleTests
//
//  Created by Lina Choi on 2021/02/08.
//  Copyright © 2021 Nali. All rights reserved.
//

import XCTest
@testable import TodoCleanSwiftSample

class TodoListInteractorTests: XCTestCase {

    // MARK: - Subject

    var sut: TodoListInteractor!

//    override func perform(_ run: XCTestRun) {
//        print("PERFORM!!!")
//    }

    override class func setUp() {
        print("SETUP!!! 클래스메서드")
    }

    override func setUp() {

    }

    override func setUpWithError() throws {
        print("SETUP WITH ERROR!!!")
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        print("TEAR DOWN WITH ERROR!!")
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    override class func tearDown() {
        print("TEAR DOWN!!")
    }

    func testExample() throws {
        print("TEST!!!")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
