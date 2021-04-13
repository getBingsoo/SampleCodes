//
//  CustomOperation.swift
//  ConcurrencySample
//
//  Created by 60067667 on 2021/04/13.
//

import Foundation

class CustomOperation: Operation {

    let type: String

    init(type: String) {
        self.type = type
    }

    // 꼭 구현해야하는 메소드
    // 이게 return되면 completionBlock이 실행된다.
    override func main() {
        autoreleasepool {
            // 취소기능 구현할 때는 Custom Operation이 좋은듯..
            guard !isCancelled else {
                print("Cancelled")
                return
            }
            print("CustomOperation")
            Thread.sleep(forTimeInterval: 0.9)
        }
    }
}
