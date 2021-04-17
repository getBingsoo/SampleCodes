//
//  GCDViewController.swift
//  ConcurrencySample
//
//  Created by Lina Choi on 2021/04/14.
//

import UIKit

class GCDViewController: UIViewController {

    let serialQueue = DispatchQueue(label: "SerialQueue")
    let concurrentQueue = DispatchQueue(label: "ConcurrentQueue", attributes: .concurrent)

    @IBOutlet weak var textView: UITextView!


    @IBAction func basicPattern(_ sender: Any) {
        DispatchQueue.global().async {
            var total = 0
            for num in 1...100 {
                total += num
                Thread.sleep(forTimeInterval: 0.1)
            }
            DispatchQueue.main.async {
                self.textView.text = "\(total)"
            }
        }
    }

    @IBAction func sync(_ sender: Any) {
        textView.text = ""
        concurrentQueue.sync {
            for i in 0..<3 {
                textView.text = "\(textView.text ?? "")\n\(i)"
                print("HELLO")
            }
            textView.text = "\(textView.text ?? "")\nPoint 1"
            print("Point 1")
        }
        textView.text = "\(textView.text ?? "")\nPoint 2"
        print("Point 2")
    }

    @IBAction func async(_ sender: Any) {
        textView.text = ""
        concurrentQueue.async {
            for i in 0..<3 {
                // 두번째
                DispatchQueue.main.async {
                    self.textView.text = "\(self.textView.text ?? "")\n\(i)"
                }
                print("HELLO")
                Thread.sleep(forTimeInterval: 0.1)
            }
            // 세번째
            DispatchQueue.main.async {
                self.textView.text = "\(self.textView.text ?? "")\nPoint 1"
            }
            print("Point 1")
        }
        // 가장먼저
        textView.text = "\(textView.text ?? "")\nPoint 2"
        print("Point 2")
    }

    @IBAction func delay(_ sender: Any) {
        let delay = DispatchTime.now() + 3
        // 3초 뒤 실행
        concurrentQueue.asyncAfter(deadline: delay) {
            print("Point 1")
        }
        print("Point 2")

    }

    @IBAction func concurrentIteration(_ sender: Any) {
        var start = DispatchTime.now()
        for index in 0..<20 {
            print(index, separator: " ", terminator: " ")
            Thread.sleep(forTimeInterval: 0.1)
        }
        var end = DispatchTime.now()
        print("\nfor-in mainThread: ", Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1000000000)

        start = .now()
        // concurrentPerform은 블럭 안의 행동이 맘대로 순서가 된다..
        DispatchQueue.concurrentPerform(iterations: 20) { (index) in
            print(index, separator: " ", terminator: " ")
            print(Thread.isMainThread)

            Thread.sleep(forTimeInterval: 0.1)
        }
        end = .now()
        print("\nconcurrentPerform", Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1000000000)

        start = .now()
        concurrentQueue.async {
            for index in 1...20 {
                print(index, separator: " ", terminator: " ")
                Thread.sleep(forTimeInterval: 0.1)
                if index == 20 {
                    end = .now()
                    print("\nconcurrentQueue", Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1000000000)
                }
            }
        }

    }

    var workItem: DispatchWorkItem? = nil

    @IBAction func dispatchWorkItem(_ sender: Any) {
        workItem = DispatchWorkItem {
            for num in 0..<100 {
                print(num, separator: " ", terminator: " ")
                Thread.sleep(forTimeInterval: 0.1)
            }
        }

        guard let workItem = workItem else {
            return
        }
        serialQueue.async(execute: workItem)

        // dispatchWorkItem이 끝난 후 실행
        workItem.notify(queue: serialQueue) {
            print("Done")
        }

        let result = workItem.wait(timeout: DispatchTime.now() + 20)
        switch result {
            case .success:
                print("success")
            case .timedOut:
                print("timedOut")
        }
    }

    @IBAction func cancelWorkItem(_ sender: Any) {
        workItem?.cancel()
    }

    let group = DispatchGroup()

    @IBAction func dispatchGroup(_ sender: Any) {

        concurrentQueue.async(group: group) {
            for _ in 0..<10 {
                print("🍏", separator: "", terminator: "")
                Thread.sleep(forTimeInterval: 0.1)
            }
        }

        concurrentQueue.async(group: group) {
            for _ in 0..<10 {
                print("🍎", separator: "", terminator: "")
                Thread.sleep(forTimeInterval: 0.2)
            }
        }

        serialQueue.async(group: group) {
            for _ in 0..<10 {
                print("🍋", separator: "", terminator: "")
                Thread.sleep(forTimeInterval: 0.3)
            }
        }

        group.notify(queue: DispatchQueue.main) {
            print("DONE")
        }

        let result = group.wait(timeout: DispatchTime.now() + 1)
        switch result {
            case .success:
                print("success")
            case .timedOut:
                print("timedOut")
        }
    }

    var value = 0
    @IBAction func dispatchSemaphore(_ sender: Any) {
        let semaphore = DispatchSemaphore(value: 1) // 0보다 크면 사용가능.

        serialQueue.async(group: group) {
            for _ in 1...1000 {
                semaphore.wait() // 기달려.
                self.value += 1
                semaphore.signal() // 이제 가능함!!
            }
            print("value: \(self.value)")
        }
        print("value: \(value)")

        concurrentQueue.async(group: group) {
            for _ in 1...1000 {
                semaphore.wait() // 기달려.
                self.value += 1
                semaphore.signal() // 이제 가능함!!
            }
            print("value: \(self.value)")
        }

        concurrentQueue.async(group: group) {
            for _ in 1...1000 {
                semaphore.wait() // 기달려.
                self.value += 1
                semaphore.signal() // 이제 가능함!!
            }
            print("value: \(self.value)")
        }

        value = 0
        let sem = DispatchSemaphore(value: 0)

        serialQueue.async {
            for _ in 1...5 {
                self.value += 1
                Thread.sleep(forTimeInterval: 0.1)
            }
            sem.signal()

            DispatchQueue.main.async {
                sem.wait()
                print("\(self.value) self.value")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
