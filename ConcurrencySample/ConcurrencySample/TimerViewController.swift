//
//  ViewController.swift
//  ConcurrencySample
//
//  Created by Lina Choi on 2021/04/13.
//

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!

    @IBAction func startTimer(_ sender: Any) {
        makeTimerByConstructor()
    }

    @IBAction func stopTimer(_ sender: Any) {
        timer?.invalidate()
        timer = nil
    }

    var timer: Timer?
    lazy var formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "hh:mm:ss"
        return f
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    // 타이머 만드는 방법 2가지
    // 1. 생성자로 만들기 - runloop에 추가 해줘야 됨
    func makeTimerByConstructor() {
        timer = Timer(timeInterval: 1, repeats: true, block: { (timer) in
            guard timer.isValid else { return }
            self.timeLabel.text = self.formatter.string(from: Date())
        })
        guard let timer = timer else { return }
        RunLoop.main.add(timer, forMode: .default)
        timer.fire()
    }

    // 2. scheduledTimer로 만들기 - runloop에 추가 안해줘도 됨
    func makeTimerByMethod() {
        // timeInterval: 시간마다 block 실행
        // repeats: true하면 계속 찍힘
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { (timer) in
            guard timer.isValid else { return }
            self.timeLabel.text = self.formatter.string(from: Date())
        })
    }


}

