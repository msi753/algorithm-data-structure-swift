//
//  linked_listTests.swift
//  linked-listTests
//
//  Created by 임명심 on 2021/06/11.
//

import XCTest
@testable import linked_list

class linked_listTests: XCTestCase {

    let numbers = [8, 2, 10, 9, 7, 5]
    
    fileprivate func buildList() -> LinkedList<Int> {
        let list = LinkedList<Int>()
        for number in numbers {
            list.append(value: number)
        }
        return list
    }

    func testEmptyList() {
        let list = LinkedList<Int>()
        XCTAssertTrue(list.isEmpty)
        XCTAssertEqual(list.count, 0)
        XCTAssertNil(list.first)
        XCTAssertNil(list.first)
        XCTAssertNil(list.last)
    }
    
    func testListWithOneElement() {
        let list = LinkedList<Int>()
        list.append(value: 123)
        
        XCTAssertFalse(list.isEmpty)
        XCTAssertEqual(list.count, 1)
        
        XCTAssertNotNil(list.first)
        XCTAssertNil(list.head!.previous)
        XCTAssertNil(list.head!.next)
        XCTAssertEqual(list.head!.value, 123)
        
        XCTAssertNotNil(list.last)
        XCTAssertNil(list.last!.previous)
        XCTAssertNil(list.last!.next)
        XCTAssertEqual(list.last!.value, 123)
        
        XCTAssertTrue(list.head === list.last)
    }
    
    func testNodeAtIndexInListWithOneElement() {
        let list = LinkedList<Int>()
        list.append(value: 123)
        
        let node = list.nodeAt(index: 0)
        XCTAssertNotNil(node)
        XCTAssertEqual(node?.value, 123)
        XCTAssertTrue(node === list.head)
    }
    
    func testNodeAtIndex() {
        let list = buildList()
        
        let nodeCount = list.count
        XCTAssertEqual(nodeCount, numbers.count)
        
        let first = list.nodeAt(index: 0)
        XCTAssertNotNil(first)
        XCTAssertTrue(first === list.head)
        XCTAssertEqual(first?.value, numbers[0])
        
        let last = list.nodeAt(index: nodeCount - 1)
        XCTAssertNotNil(last)
        XCTAssertTrue(last === list.last)
        XCTAssertEqual(last?.value, numbers[nodeCount - 1])
        
        for i in 0 ..< nodeCount {
            let node = list.nodeAt(index: i)
            XCTAssertNotNil(node)
            XCTAssertEqual(node?.value, numbers[i])
        }
    }
    
    func testSubscript() {
        let list = buildList()
        for i in 0 ..< list.count {
            XCTAssertEqual(list[i], numbers[i])
        }
    }
}
