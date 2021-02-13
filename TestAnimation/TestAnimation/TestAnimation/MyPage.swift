//
//  MyPage.swift
//  TestAnimation
//
//  Created by 60067667 on 2020/10/29.
//  Copyright © 2020 Lina Choi. All rights reserved.
//

import UIKit

class MyPage: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var tableView: UITableView!
    private let xibName = "MyPage"

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit(){
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        
        let nibName = UINib(nibName: "MyTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "MyTableViewCell")
        tableView.dataSource = self
        
        resetAlpha()
    }

    func animateTable() {
        UIView.animateKeyframes(withDuration: 0.9, delay: 0, options: [], animations: {
            for i in 0...(self.tableView?.numberOfRows(inSection: 0) ?? 0) {
                let cell = self.tableView?.cellForRow(at: IndexPath(row: i, section: 0))
                UIView.addKeyframe(withRelativeStartTime: 0.3*Double((i+1)), relativeDuration: 0.3*Double((i+2)), animations: {
                    cell?.contentView.alpha = 1
                })
            }
        }, completion: nil)
    }
    
    func resetAlpha() {
        for i in 0...(self.tableView?.numberOfRows(inSection: 0) ?? 0) {
            let cell = self.tableView?.cellForRow(at: IndexPath(row: i, section: 0))
            cell?.contentView.alpha = 0
        }
    }
}

extension MyPage: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        
        return cell
    }
}
