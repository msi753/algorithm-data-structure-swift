//
//  binary_searchTests.swift
//  binary-searchTests
//
//  Created by 임명심 on 2021/06/14.
//

import XCTest
@testable import binary_search

class binary_searchTests: XCTestCase {

    var searchList = [Int]()
    
    override func setUpWithError() throws {
        super.setUp()
        for number in 1 ... 500 {
            searchList.append(number)
        }
    }
    
    
}
