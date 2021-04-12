//
//  OperationViewController.swift
//  ConcurrencySample
//
//  Created by Lina Choi on 2021/04/13.
//

import UIKit

class OperationViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!

    @IBAction func startBlockOperation(_ sender: Any) {
        backgroundOperationQueue.addOperation {
            // 필수!! 오퍼레이션은 autoreleasepool을 해줘야함
            autoreleasepool {
                self.wholeText = "\(self.wholeText)\nblockOperation"
            }
        }

    }

    @IBAction func startCustomOperation(_ sender: Any) {
        let customOperation = CustomOperation(type: "CUSTOM")
        backgroundOperationQueue.addOperation(customOperation)

        customOperation.completionBlock = {
            self.wholeText = "\(self.wholeText)\ncustomOperationEND"
        }
    }

    @IBAction func cancelOperation(_ sender: Any) {
        backgroundOperationQueue.cancelAllOperations()
        mainOperationQueue.cancelAllOperations()
    }

    // dependency 설정
    @IBAction func operationRelay(_ sender: Any) {
        let first = FirstOperation()
        let second = SecondOperation()
        let third = ThirdOperation()
        let fourth = FourthOperation()

        second.addDependency(first)
        third.addDependency(second)
        fourth.addDependency(third)

//        backgroundOperationQueue.addOperation(second)
//        backgroundOperationQueue.addOperation(fourth)
//        backgroundOperationQueue.addOperation(third)
//        backgroundOperationQueue.addOperation(first)

        second.completionBlock = {
            print("FINISH SECOND!")
        }
        fourth.completionBlock = {
            print("FINISH FOURTH!")
        }

        backgroundOperationQueue.addOperations([fourth, third, second, first], waitUntilFinished: true)

        /*
         FirstOperation
         SecondOperation
         FINISH SECOND!
         ThirdOperation
         FourthOperation
         FINISH FOURTH!
         */
        print("Wait Until Fisished")
    }

    var wholeText = "" {
        didSet {
            mainOperationQueue.addOperation {
                self.textView.text = self.wholeText
            }
        }
    }

    // 오퍼레이션 구현 방법 2가지
    // 1. 블록 2. 커스텀

    // 백그라운드큐
    var backgroundOperationQueue = OperationQueue()

    // 메인큐
    var mainOperationQueue = OperationQueue.main

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
