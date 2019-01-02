//
//  IOSpreTaskTests.swift
//  IOSpreTaskTests
//
//  Created by Oscar on 2018-12-30.
//  Copyright © 2018 Oscar. All rights reserved.
//

import XCTest
@testable import IOSpreTask

class IOSpreTaskTests: XCTestCase {
    
    func testSucceeds() {
        let Houston = weather.init(id: "4699066")
        XCTAssertGreaterThan(Houston.temperature, 100)
    }
    
    
    func testFails1(){
        let Houston = weather.init(id: "469906")
        XCTAssertEqual(Houston.temperature, -400)
    }
    
//    func testFails2(){
//
//    }
}
