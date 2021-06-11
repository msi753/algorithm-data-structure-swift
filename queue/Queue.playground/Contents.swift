import Foundation

public struct Queue<T> {
    fileprivate var list = LinkedList<T>()
    
    public var isEmpty: Bool {
        return list.isEmpty
    }
    
    public mutating func enqueue(_ element: T) {
        list.append(element)
    }
    
    public mutating func dequeue() -> T? {
        //리스트가 비어있지 않을 때 리스트이 첫번째 원소를 element에 할당한다
        guard !list.isEmpty, let element = list.first else { return nil }
        list.remove(element)
        return element.value
    }
    
    //옵셔널로 처리해서 값이 없으면 nil을 리턴함
    public func peek() -> T? {
        return list.first?.value
    }
    
}

var queue = Queue<Int>()
queue.enqueue(10)
queue.enqueue(5)
queue.enqueue(37)

print(queue) //Queue(list: [10, 5, 37])

//CustomStringConvertible 프로토콜을 사용하면 String타입의 computed property인 description를 구현한다 (read only)
extension Queue: CustomStringConvertible {
    public var description: String {
        return list.description
    }
}
