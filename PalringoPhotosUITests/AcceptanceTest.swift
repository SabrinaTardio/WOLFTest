//
//  AcceptanceTest.swift
//  PalringoPhotosUITests
//
//  Created by Sabrina Tardio on 19/03/2021.
//  Copyright © 2021 Palringo. All rights reserved.
//

import XCTest

class AcceptanceTest: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    
    func testScrollPictures() {
        for _ in 0...7 {
            app.collectionViews.element.swipeUp()
        }
        let element = app.collectionViews.cells.staticTexts["Einfahrt"]
        XCTAssertTrue(element.isHittable)
    }


}


