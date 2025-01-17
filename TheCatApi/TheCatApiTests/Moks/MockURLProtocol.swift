//
//  MockURLProtocol.swift
//  TheCatApi
//
//  Created by admin on 17.01.2025.
//

import Foundation

class MockURLProtocol: URLProtocol {
    static var mockResponses: (data: Data?, response: URLResponse?, error: Error?)
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let error = MockURLProtocol.mockResponses.error {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            if let response = MockURLProtocol.mockResponses.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let data = MockURLProtocol.mockResponses.data {
                client?.urlProtocol(self, didLoad: data)
            }
            client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    override func stopLoading() {
        // No action needed
    }
}
