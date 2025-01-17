//
//  CatGridVMTests.swift
//  TheCatApi
//
//  Created by admin on 17.01.2025.
//

import XCTest
@testable import TheCatApi

class CatGridVMTests: XCTestCase {

    func testFetchData_Success() async throws {
        guard let data = loadJSONFile(named: "catsJSON") else {
            XCTFail("bad json")
            return
        }
        
        let expectedCats = try  JSONDecoder().decode([CatModel].self, from: data)
        let sut = createSUT(cats: expectedCats)
        let cats = try await sut.getCats()
        XCTAssertEqual(expectedCats, cats)
    }

    // Do We need test errors????
    
    func testFetchData_Failure() {
    }
}

extension CatGridVMTests {
    func createSUT(cats: [CatModel], error: Error? = nil) -> CatsGridVM {
       
        let mockNetworkService = MockNetworkService(cats: cats, error: error)
        let sut = CatsGridVM(networkService: mockNetworkService)
        return sut
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
