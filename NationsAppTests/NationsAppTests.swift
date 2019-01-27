//
//  NationsAppTests.swift
//  NationsAppTests
//
//  Created by Nizar Elhraiech on 2019-01-25.
//  Copyright © 2019 Nizar. All rights reserved.
//

import XCTest
@testable import NationsApp

class NationsAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testCountryService() {
        
        let countryService = CountryService()
        
        
        let expectation = self.expectation(description: "Get coutries")
        var result : [Country]?
        
        countryService.getCoutries { (countries) in
            result = countries
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssertNotNil(result)
        if(result != nil) {
            XCTAssertGreaterThan(result!.count, 0)
        }
    }

}
