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

    //On iPhone 11
    func testScrollPictures() {
        let element = app.collectionViews.cells.staticTexts["Einfahrt"]
        for _ in 0...7 {
            app.collectionViews.element.swipeUp()
        }
        
        XCTAssertTrue(element.isHittable)
    }
    
    func testOtherAuthorPhotosAreVisible() {
        app.navigationBars.buttons["Author"].tap()
        let authorNumbers = app.sheets["Photographer"].buttons.count
        XCTAssertEqual(authorNumbers, 3)
        
        app.sheets["Photographer"].buttons["Alfredo Liverani"].tap()
        let element = app.collectionViews.cells.staticTexts["Work in progress in Bologna"]
        XCTAssertTrue(element.isHittable)
        
        app.navigationBars.buttons["Author"].tap()
        app.sheets["Photographer"].buttons["Martin Tosh"].tap()
        let element2 = app.collectionViews.cells.staticTexts["Negotiations"]
        XCTAssertTrue(element2.isHittable)
    }


}


