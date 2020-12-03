//
//  MyClass.swift
//  ObjcSample
//
//  Created by Lina Choi on 2020/12/01.
//  Copyright © 2020 anil. All rights reserved.
//

import Foundation
import UIKit

@objcMembers class MyClass: NSObject {
    func introduce() {
        print("내 이름은 dd이고 11살 입니다.")
    }
}

@objc class MyClass2: UIViewController {

    @objc func class2() {
        print("class2")
    }
    
}
