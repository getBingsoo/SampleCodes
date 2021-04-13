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
