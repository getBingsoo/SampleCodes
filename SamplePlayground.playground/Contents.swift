import UIKit

enum eee: CustomStringConvertible {
    case a
    case b
    
    var description: String {
        "desdes"
    }
}

print(eee.a)

class calss {
    enum e2: CustomStringConvertible {
        case aaaa
        case bbbb
        var description: String {
            "asa"
        }
    }
}

// enum은 저장속성을 가질 수 없다..
// 하지만 왜 ??????? CustomStringConvertible을 사용하면 description 가질 수 있음..
// description은 저장인지 연산인지 모르는 프로퍼티이다.
// 하지만 enum에서는 연산프로퍼티만 가질 수 있으므로 let으로는 구현할 수 없다.
// 그래서 var로 연산프로퍼티로 만들어서 준수해야 함..
// 저 찾아봤는데요 .. enum에서 지원님 말씀대로 저장속성을 가질 수 없고, 그래서 CustomStringConvertible 프로토콜(프로토콜 내에서 프로퍼티를 선언할 때 get set으로만 최소 조건만 명시한다고 합니당.. 연산인지 저장인지 프로토콜 내에서는 정하는게 아닌 것 같아요) 을 준수할 때 description을 연산속성으로 만들어야 해서 var description: String { return “aaa” } 요런식으로 아까 하신것처럼 해서 구현하면 description이 연산프로퍼티가 되는건가봐요

protocol ProTest {
    var proTest: String { get }
}



class SampleClass {
    enum eee: CustomStringConvertible {
        case a
        case b
        
        var description: String {
            "aaa"
        }

    }
    var aaasd: String = ""
    
    let k = eee.a
    
    class smasa {
        
    }
}

class Ttt: CustomStringConvertible {
    let description: String = "aaa"
}

let attt = Ttt()
print(attt)

enum aascac {
    case aa, bb
    
}

let asmaee = SampleClass.eee.a
print(asmaee)

enum cnxzmczm: CustomStringConvertible {
    case asda, aascac
    var description: String {
        "aaaa"
    }
}

class asdaszxc {
    enum cnxzmczm: CustomStringConvertible {
        case asda, aascac
        var description: String {
            "aaaa"
        }
    }
}

class kkkasdasd: CustomStringConvertible {
    let deeas = "kasd"
    var description: String {
        get {
            return self.deeas
        }
    }
}

kkkasdasd()
