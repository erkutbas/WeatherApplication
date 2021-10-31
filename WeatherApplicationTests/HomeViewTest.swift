//
//  HomeViewTest.swift
//  WeatherApplicationTests
//
//  Created by Erkut Bas on 31.10.2021.
//

import XCTest
import DefaultNetworkOperationPackage
@testable import WeatherApplication

class HomeViewTest: XCTestCase {
    
    class FakeOperationManager: HomeOperationProtocol {
        
        func getData(with completion: @escaping CharacterDataBlock) {
            
            //completion(.failure(ErrorResponse()))
            
            completion(.success(CharacterDataResponse(data: CharacterListData(offset: 0, limit: 0, total: 0, count: 0, results: [CharacterData(id: 1, name: "Erkut", thumbnail: Thumbnail(path: "", thumbnailExtension: Extension(rawValue: "gif")!), description: "Sugar Developer")]))))
            
        }
        
    }
    
    private var sampleData = CharacterDataResponse(data: CharacterListData(offset: 0, limit: 0, total: 0, count: 0, results: [CharacterData(id: 1, name: "Erkut", thumbnail: Thumbnail(path: "", thumbnailExtension: Extension(rawValue: "gif")!), description: "Sugar Developer")]))

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_interactor_data() {
        
        let operationModule = FakeOperationManager()
        operationModule.getData { [weak self](result) in
            switch result {
            case .failure(let eror):
                XCTFail("Did not supply fake result")
            case .success(let data):
                print("data gathered")
                //XCTAssertEqual(data, sampleData)
            }
        }
        
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
