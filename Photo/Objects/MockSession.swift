//
//  MockSession.swift
//  DogYearsUnitTests
//
//  Created by Đỗ Tấn Khoa on 3/28/19.
//  Copyright © 2019 Razeware. All rights reserved.
//

import Foundation


class MockSession: URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        completionHandler(Data(), nil, nil)
        return MockDataTask()
    }
}
