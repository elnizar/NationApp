//
//  NationsAppUITests.swift
//  NationsAppUITests
//
//  Created by Nizar Elhraiech on 2019-01-25.
//  Copyright © 2019 Nizar. All rights reserved.
//

import XCTest

class NationsAppUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let deadlineTime = DispatchTime.now() + .seconds(5)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            let app = XCUIApplication()
            app.tables/*@START_MENU_TOKEN@*/.staticTexts["Croatia"]/*[[".cells.staticTexts[\"Croatia\"]",".staticTexts[\"Croatia\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            app.navigationBars["Title"].buttons["Back"].tap()
        }
        

        
    }

}
