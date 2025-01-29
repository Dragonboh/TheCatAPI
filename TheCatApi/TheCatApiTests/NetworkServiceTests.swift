//
//  NetworkServiceTests.swift
//  TheCatApi
//
//  Created by admin on 17.01.2025.
//


import XCTest
@testable import TheCatApi

class NetworkServiceTests: XCTestCase {

    func testFetchData_Success() async throws {
        // given
        let data = TestUtilities.loadJSONData(from: "catsJSON")
        let response = HTTPURLResponse(url: URL(string: "https://google.com")!,
                                               statusCode: 200,
                                               httpVersion: nil,
                                               headerFields: nil)
        
        let sut = createSUT(response: (data: data, response: response, error: nil))
        let expectedCats = try Utilities.decodeJSON([CatModel].self, data: data)
        // when
        let cats = try await sut.fetchCats()
        // then
        XCTAssertEqual(expectedCats, cats)
    }

    // Do We need test errors????
    func testFetchData_Failure() {
    }
}


private extension NetworkServiceTests {
    func createSUT(response: (data: Data?, response: URLResponse?, error: Error?)) -> NetworkService {
        MockURLProtocol.mockResponses = response
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        
        let session = URLSession(configuration: config)
        let networkService = NetworkService(session: session)
        
        return networkService
    }
}
