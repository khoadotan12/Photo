//
//  PhotoUITests.swift
//  PhotoUITests
//
//  Created by Đỗ Tấn Khoa on 4/6/19.
//  Copyright © 2019 Đỗ Tấn Khoa. All rights reserved.
//

import XCTest

class PhotoUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchBar() {
        let searchBar = app.collectionViews.searchFields["Tìm kiếm"]
        
        XCTAssert(searchBar.exists, "Search bar doesn't exist")
        
        searchBar.tap()
        
        
        let cKey = app/*@START_MENU_TOKEN@*/.keys["C"]/*[[".keyboards.keys[\"C\"]",".keys[\"C\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        cKey.tap()
        
        let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        
        let tKey = app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        let app = XCUIApplication()
        tKey.tap()
        
        XCTAssert(searchBar.value as! String == "Cat", "Search bar value is not correct")
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"Tìm\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()

        searchBar.tap()
        searchBar.buttons["Clear text"].tap()
        XCTAssertFalse(searchBar.value as! String == "Cat", "Search bar is not cleared the text")
        
    }
    
    func testScroll() {
        
        let oldCount = app.collectionViews.cells.count
        
        
        app.collectionViews.element.swipeUp()
        app.collectionViews.element.swipeUp()
        let newCount = app.collectionViews.cells.count
        XCTAssert(oldCount != newCount, "Collection views did not scroll down")

    }

}
