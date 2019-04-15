//
//  URLSessionDataTaskProtocol.swift
//  DogYears
//
//  Created by Đỗ Tấn Khoa on 3/28/19.
//  Copyright © 2019 Razeware. All rights reserved.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask : URLSessionDataTaskProtocol {
    
}
