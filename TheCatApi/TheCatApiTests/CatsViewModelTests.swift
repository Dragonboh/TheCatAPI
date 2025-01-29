//
//  CatGridVMTests.swift
//  TheCatApi
//
//  Created by admin on 17.01.2025.
//

import XCTest
@testable import TheCatApi

class CatsViewModelTests: XCTestCase {

    func testInitialInit_Success() async throws {
        //given
        let data = TestUtilities.loadJSONData(from: "catsJSON")
        let expectedCats = try Utilities.decodeJSON([CatModel].self, data: data)
        let sut = await createSUT(cats: expectedCats)
        
        //when
        let testedCats = await sut.cats
        let testedFilteredCats = await sut.filteredCats
        let testedSearchString = await sut.searchText
        
        // then
        XCTAssertEqual(testedCats, [])
        XCTAssertEqual(testedFilteredCats, [])
        XCTAssertEqual(testedSearchString, "")
    }
    
    func testInitialFetchData_Success() async throws {
        //given
        let data = TestUtilities.loadJSONData(from: "catsJSON")
        let expectedCats = try Utilities.decodeJSON([CatModel].self, data: data)
        let sut = await createSUT(cats: expectedCats)
        
        //when
        try await sut.getCats()
        let testedAllCats = await sut.cats
        let testedFilteredCats = await sut.filteredCats
        
        //then
        XCTAssertEqual(testedAllCats, expectedCats)
        XCTAssertEqual(testedFilteredCats, [])
    }
    
    func testFilterData_Success() async throws {
        //given
        let data = TestUtilities.loadJSONData(from: "catsJSON")
        let expectedAllCats = try Utilities.decodeJSON([CatModel].self, data: data)
        let sut = await createSUT(cats: expectedAllCats)
        let searchText = "Abyssinian"
        let expectedFilteredCats = expectedAllCats.filter { cat in
            cat.breeds.contains(where: { $0.name == searchText })
        }
        try await sut.getCats()
        //when
        await MainActor.run {
            sut.searchText = searchText
        }
        let testedAllCats = await sut.cats
        let testedFilteredCats = await sut.filteredCats
        
        //then
        // We need this asyncAfter to test debouce
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(testedAllCats, expectedAllCats)
            XCTAssertEqual(testedFilteredCats, expectedFilteredCats)
        }
    }
}

private extension CatsViewModelTests {
    func createSUT(cats: [CatModel], error: Error? = nil) async -> CatsViewModel {
        
        let mockNetworkService = MockNetworkService(cats: cats, error: error)
        let sut = await CatsViewModel(networkService: mockNetworkService)
        return sut
    }
}
