//
//  BottomSheetPresentationManager.swift
//  BottomSheetSample
//
//  Created by 60067667 on 2021/02/26.
//

import UIKit

class BottomSheetPresentationManager: NSObject {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = BottomUpPresentationController(presentedViewController: presented, presenting: presenting)
        return presentationController
    }
}

extension BottomSheetPresentationManager: UIViewControllerTransitioningDelegate {

}
