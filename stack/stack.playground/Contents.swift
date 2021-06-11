import Foundation

public struct Stack<T> {
    fileprivate var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func push(_ element: T) {
        array.append(element)
    }
    
    public mutating func pop() -> T? {
        return array.popLast()
    }
    
    public var top: T? {
        return array.last
    }
}

extension Stack: CustomStringConvertible {
  
  //프로토콜을 따르기 위해 반드시 구현해야하는 프로퍼티 description
    public var description: String {
    
    let topDivider = "---Stack---\n"
    let bottomDivider = "\n-----------\n"

    //joined(separator:)를 통해
    //["3D Games by Tutorials", "tvOS Apprentice"] 이렇게 되어있으면
    //"3D Games by Tutorials\ntvOS Apprentice" 이렇게 바뀐다
        let stackElements = array.map{ "\($0)" }.reversed().joined(separator: "\n")
    
    return topDivider + stackElements + bottomDivider
  }
}


var rwBookStack = Stack<String>()
rwBookStack.push("3D Games by Tutorials")
rwBookStack.push("tvOS Apprentice")
rwBookStack.push("iOS Apprentice")
rwBookStack.push("Swift Apprentice")
print(rwBookStack)

//---Stack---
//Swift Apprentice
//iOS Apprentice
//tvOS Apprentice
//3D Games by Tutorials
//-----------
