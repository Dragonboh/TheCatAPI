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
        guard let data = loadJSONFile(named: "catsJSON") else {
            XCTFail("bad json")
            return
        }
        let response = HTTPURLResponse(url: URL(string: "https://google.com")!,
                                               statusCode: 200,
                                               httpVersion: nil,
                                               headerFields: nil)
        let sut = createSUT(response: (data: data, response: response, error: nil))

        let expectedCats = try  JSONDecoder().decode([CatModel].self, from: data)
        let cats = try await sut.fetchCats()
        XCTAssertEqual(expectedCats, cats)
    }

    // Do We need test errors????
    
    func testFetchData_Failure() {
    }
}


extension NetworkServiceTests {
    func createSUT(response: (data: Data?, response: URLResponse?, error: Error?)) -> NetworkService {
       
        
        MockURLProtocol.mockResponses = response
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        
        let session = URLSession(configuration: config)
        let networkService = NetworkService(session: session)
        
        return networkService
    }
    
    func loadJSONFile(named fileName: String) -> Data? {
        guard let fileURL = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: "json") else {
            print("File not found in bundle")
            return nil
        }

        do {
            let jsonData = try Data(contentsOf: fileURL)
            return jsonData
        } catch {
            print("Error reading JSON file: \(error)")
            return nil
        }
    }
}
