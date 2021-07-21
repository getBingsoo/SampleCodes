//
//  FoldingViewController.swift
//  AnimationSample
//
//  Created by 60067667 on 2021/07/21.
//  Copyright © 2021 anil. All rights reserved.
//

import UIKit

class FoldingViewController: UIViewController {

    let minHeight = 100
    let totalAlpha: CGFloat = 1

    @IBOutlet weak var animateView: UIView!

    @IBOutlet weak var background1HeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var contents1HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contents2HeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var backgroundView1: UIView!
    @IBOutlet weak var backgroundView2: UIView!

    @IBOutlet weak var topSmallView: UILabel!
    @IBOutlet weak var topLargeView: UILabel!
    @IBOutlet weak var bottomSmallView: UILabel!
    @IBOutlet weak var bottomLargeView: UILabel!

    var foldTop = false
    var firstLongHeight: CGFloat = 0


    override func viewDidLoad() {
        super.viewDidLoad()

        makeBackgroundViews()
        setDefaultStatus()
    }


    func makeBackgroundViews() {
        backgroundView1.layer.cornerRadius = 20
        backgroundView1.backgroundColor = .systemBlue

        backgroundView2.layer.cornerRadius = 20
        backgroundView2.layer.borderColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        backgroundView2.layer.borderWidth = 1
    }

    func setDefaultStatus() {

        if !foldTop {
            self.bottomSmallView.alpha = 1
            self.bottomLargeView.alpha = self.totalAlpha - self.bottomSmallView.alpha

            self.topSmallView.alpha = 0
            self.topLargeView.alpha = self.totalAlpha - self.topSmallView.alpha
        } else {
            self.bottomSmallView.alpha = 0
            self.bottomLargeView.alpha = self.totalAlpha - self.bottomSmallView.alpha

            self.topSmallView.alpha = 1
            self.topLargeView.alpha = self.totalAlpha - self.topSmallView.alpha
        }


        firstLongHeight = backgroundView1.frame.size.height
        contents1HeightConstraint.constant = firstLongHeight // 한번만 긴길이에 맞춰서 세팅해줌.
        contents2HeightConstraint.constant = firstLongHeight // 한번만 긴길이에 맞춰서 세팅해줌.
    }

    @IBAction func animate(_ sender: Any) {
        foldTop.toggle()
        foldingAnimation(foldTop)
    }


    func foldingAnimation(_ foldTop: Bool) {

        if foldTop {

            background1HeightConstraint.constant = 100
            UIView.animate(withDuration: 0.5) {
                self.animateView.layoutIfNeeded()


                self.topSmallView.alpha = 1
                self.topLargeView.alpha = self.totalAlpha - self.topSmallView.alpha

                self.bottomSmallView.alpha = 0
                self.bottomLargeView.alpha = self.totalAlpha - self.bottomSmallView.alpha
            }



        } else {

            background1HeightConstraint.constant = firstLongHeight
            UIView.animate(withDuration: 0.5) {
                self.animateView.layoutIfNeeded()


                self.topSmallView.alpha = 0
                self.topLargeView.alpha = self.totalAlpha - self.topSmallView.alpha

                self.bottomSmallView.alpha = 1
                self.bottomLargeView.alpha = self.totalAlpha - self.bottomSmallView.alpha
            }
        }


    }
}
