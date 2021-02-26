//
//  BottomUpPresentationController.swift
//  BottomSheetSample
//
//  Created by 60067667 on 2021/02/26.
//

import UIKit

class BottomUpPresentationController: UIPresentationController {

    private var dimmingView: UIView!
    private var size: CGSize?

    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, size: CGSize) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.size = size

        setupDimmingView()
    }

    // 뷰 보여줄 때
    override func presentationTransitionWillBegin() {
        guard let dimmingView = dimmingView else { return }

        // 1 컨테이너뷰에 insert
        containerView?.insertSubview(dimmingView, at: 0)
        // 2 전체화면 dimmingView
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|",
                                           options: [], metrics: nil, views: ["dimmingView": dimmingView]))
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|",
                                           options: [], metrics: nil, views: ["dimmingView": dimmingView]))

        // 3
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }

        // 배경 fade in
        coordinator.animate (alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        }, completion: nil)

    }

    // 뷰 dismiss할 때
    override func dismissalTransitionWillBegin() {
        // 배경 fade out
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        })
    }

    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    // 콘텐츠의 사이즈 여기에 (뷰의 크기)
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        var width = parentSize.width
        var height = parentSize.height * (2.0/3.0)

        if let size = size {
            if size.width != 0 { width = size.width }
            if size.height != 0 { height = size.height }
        }
        return CGSize(width: width, height: height)
    }

    // 전체 프레임 반환. 위치 지정
    override var frameOfPresentedViewInContainerView: CGRect {
        // 1
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController,
                          withParentContainerSize: containerView!.bounds.size)

        // 2 현재 전체 높이 - 콘텐츠의 높이
        frame.origin.y = containerView!.frame.height - size!.height
//        frame.origin.y = containerView!.frame.height*(1.0/3.0)

        return frame
    }
}

extension BottomUpPresentationController {
    func setupDimmingView() {
        dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor(white : 0.0 , alpha : 0.5)
        dimmingView.alpha = 0.0

        let recognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(recognizer)
    }

    @objc func handleTap(recognizer : UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true, completion: nil)
    }
}
