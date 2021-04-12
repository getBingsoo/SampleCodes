//
//  Operations.swift
//  ConcurrencySample
//
//  Created by 60067667 on 2021/04/13.
//

import Foundation

class FirstOperation: Operation {
    override func main() {
        autoreleasepool {
            print("FirstOperation")
        }
    }
}

class SecondOperation: Operation {
    override func main() {
        autoreleasepool {
            print("SecondOperation")
        }
    }
}

class ThirdOperation: Operation {
    override func main() {
        autoreleasepool {
            print("ThirdOperation")
        }
    }
}

class FourthOperation: Operation {
    override func main() {
        autoreleasepool {
            print("FourthOperation")
        }
    }
}
