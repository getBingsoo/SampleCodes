//
//  ViewController.swift
//  TestAnimation
//
//  Created by 60067667 on 2020/10/26.
//  Copyright © 2020 Lina Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var topSheet: UIView!
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var topSheetHeight: CGFloat = 0.0
    let pageCount = 3
    var pages = [MyPage]()
    var fromTap = false
    var isOpen = false
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        fromTap = true
        let frame = scrollView.frame
        scrollView.setContentOffset(CGPoint(x: frame.size.width * CGFloat(sender.currentPage), y: 0), animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        topSheetHeight = topSheet.frame.height
        makeTopSheet()
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: CGFloat(pageCount) * self.view.frame.maxX, height: 0)
    }
    
    // 버튼 클릭
    @IBAction func touchDownBtn(_ sender: Any) {
        animateTopSheet()
    }
    
    // 탑싯 생성
    func makeTopSheet() {
        for i in 0...(pageCount - 1) {
            let page = MyPage(frame: CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: scrollView.frame.height))

            pages.append(page)
            scrollView.addSubview(page)
        }
        pageControl.numberOfPages = pageCount
        resetTopSheet()
    }
    
    // 탑싯 초기화
    func resetTopSheet() {
        for i in 0...(pages.count - 1) {
            pages[i].resetAlpha()
        }
        pageControl.currentPage = 0
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        self.topSheet.transform.ty = -topSheetHeight
    }
    
    // 탑싯 내려가거나 올라가는 애니메이션
    func animateTopSheet() {
        if (isOpen) {
            UIView.animate(withDuration: 0.25, animations: {
                [weak self] in self?.topSheet.transform.ty = -(self?.topSheetHeight ?? 0.0)
                }, completion: { _ in self.resetTopSheet() })
        } else {
            UIView.animate(withDuration: 0.25, animations: { [weak self] in
            self?.topSheet.transform.ty = 0.0
            }, completion: { finished in self.pages[0].animateTable()} )
        }
        isOpen = !isOpen
    }
    
    // 페이지 변경 시 작동할 것들
    func changePage(newPage: Int) {
        pages[newPage].animateTable()
        for i in 0...(pages.count - 1) {
            if i == newPage {
                continue
            }
            pages[i].resetAlpha()
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.size.width
        let x = scrollView.contentOffset.x + (width / 2.0)
        let newPage = Int(x / width)
        changePage(newPage: newPage)
        
        guard !fromTap else { return }
        if pageControl.currentPage != newPage {
            pageControl.currentPage = newPage
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        fromTap = false
        pageControl.updateCurrentPageDisplay()
    }
}
