//
//  HTTPClient.swift
//  Photo
//
//  Created by Đỗ Tấn Khoa on 4/15/19.
//  Copyright © 2019 Đỗ Tấn Khoa. All rights reserved.
//

import Foundation

class HTTPClient {
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    // MARK:- Public Methods
    func get(url: URL, completionHandler: @escaping (_ data: Data?, _ error: Error?)->Void ) {
        let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
            if let error = error {
                NSLog("Error: \(error)")
                return
            }
            completionHandler(data, error)
        })
        task.resume()
    }
}
