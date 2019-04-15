//
//  PhotoTests.swift
//  PhotoTests
//
//  Created by Đỗ Tấn Khoa on 4/6/19.
//  Copyright © 2019 Đỗ Tấn Khoa. All rights reserved.
//

import XCTest
@testable import Photo

class PhotoTests: XCTestCase {
    var resData: Data? = nil

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadAPI() {
        let key = String("99538a231288cc67714859f6513e8556be7aa5016b60a516315e8041f09a717c")
        let url = URL(string: "https://api.unsplash.com/photos?client_id=\(key)&page=1&per_page=30")
        let session = MockSession()
        let client = HTTPClient(session: session)
        client.get(url: url!) {(data, error) in
            self.resData = data
        }
        let pred = NSPredicate(format: "resData != nil")
        let exp = expectation(for: pred, evaluatedWith: self, handler: nil)
        let res = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if res == XCTWaiter.Result.completed {
            XCTAssertNotNil(resData, "No data received received from the server for InfoView content")
        } else {
            XCTAssert(false, "The call to get the URL ran into some other error")
        }
    }
    
    func testSearchAPI() {
        let key = String("99538a231288cc67714859f6513e8556be7aa5016b60a516315e8041f09a717c")
        let url = URL(string: "https://api.unsplash.com/search/photos?client_id=\(key)&query=car&page=1&per_page=30")
        let session = MockSession()
        let client = HTTPClient(session: session)
        client.get(url: url!) {(data, error) in
            self.resData = data
        }
        let pred = NSPredicate(format: "resData != nil")
        let exp = expectation(for: pred, evaluatedWith: self, handler: nil)
        let res = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if res == XCTWaiter.Result.completed {
            XCTAssertNotNil(resData, "No data received received from the server for InfoView content")
        } else {
            XCTAssert(false, "The call to get the URL ran into some other error")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
