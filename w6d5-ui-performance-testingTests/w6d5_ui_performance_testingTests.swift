//
//  w6d5_ui_performance_testingTests.swift
//  w6d5-ui-performance-testingTests
//
//  Created by Bennett on 2018-09-07.
//  Copyright © 2018 Roland. All rights reserved.
//

import XCTest
@testable import w6d5_ui_performance_testing

class w6d5_ui_performance_testingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
  
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
          PerformanceDataModel.doSomething()
        }
    }
    
}
