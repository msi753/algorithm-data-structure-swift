//
//  LinkedList.swift
//  linked-list
//
//  Created by 임명심 on 2021/06/11.
//

//노드는 참조값이 필요해서 클래스를 사용했고
//클래스는 init이 필수인데 value가 있어야 하도록 만들었다
public class Node<T> {
    var value: T
    var next: Node<T>?
    weak var previous: Node<T>?
    
    init(value: T) {
        self.value = value
    }
}

public class LinkedList<T> {
    //fileprivate var head: Node<T>?
    var head: Node<T>?
    //private var tail: Node<T>?
    var tail: Node<T>?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node<T>? {
        return head
    }
    
    public var last: Node<T>? {
        return tail
    }
    
    public var count: Int {
        guard var node = head else {
            return 0
        }
        
        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        return count
    }
    
    
    public subscript(index: Int) -> T {
        let node = self.nodeAt(index: index)
        return node!.value
    }
    
    public func append(value: T) {
        let newNode = Node(value: value)    //노드 생성
        
        // 새로운 노드의 앞부분 연결하기
        if let tailNode = tail {    // 연결리스트에 값이 있는 경우
            newNode.previous = tailNode
            tailNode.next = newNode
        } else {    // 연결리스트에 값이 없는 경우
            head = newNode
        }
        
        // 새로운 노드의 뒷부분 연결하기
        tail = newNode
    }
    
    public func nodeAt(index: Int) -> Node<T>? {
        if index >= 0 {
            var node = head
            var i = index
            
            while node != nil {
                if i == 0 {
                    return node
                }
                i -= 1
                node = node!.next
            }
        }
        return nil
    }
    
    public func removeAll() {
        head = nil
        tail = nil
    }
    
    public func remove(node: Node<T>) -> T {
        let prev = node.previous
        let next = node.next
        
        // next 포인터의 값 저장
        if let prev = prev {    // 첫번째 노드가 아닐 때
            prev.next = next
        } else {                // 첫번째 노드일 때
            head = next
        }
        
        // prev 포인터의 값 저장
        next?.previous = prev   // 마지막 노드가 아닐 때
        if next == nil {        // 마지막 노드일 때
            tail = prev
        }
        
        // 연결 해제
        node.previous = nil
        node.next = nil
        
        return node.value
    }
}
