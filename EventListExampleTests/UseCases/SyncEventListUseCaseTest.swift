//
//  SyncEventListUseCaseTest.swift
//  EventListExampleTests
//
//  Created by Ghanshyam Bhesaniya on 07/06/22.
//

import XCTest
@testable import EventListExample

final class SyncEventListUseCaseTest: XCTestCase {
    var service: MockEventListService!
    var repository: MockEventRepository!
    var sut: SyncEventListImp!
    
    override func setUpWithError() throws {
        service = MockEventListService()
        repository = MockEventRepository()
        sut = SyncEventListImp(repository: repository, service: service)
    }
    
    override func tearDownWithError() throws {
        service = nil
        repository = nil
        sut = nil
    }
    
    func testFailure() {
        service.mockResponse = .notConnectedToInternet
        sut { result in
            if case .failure = result {
                print("Good status")
            } else {
                XCTFail("Sync is not detecting failures on the service")
            }
        }
    }
    
    func testNotInternetConnection() {
        service.mockResponse = .notConnectedToInternet
        sut { (result) in
            switch result {
            case .failure(error: .notInternetConnection):
                break
            default:
                XCTFail("Sync is not detecting lack of internet connection")
            }
        }
    }
    
    func testRightSync() {
        let mockApp = EventData(
            id: "1234",
            title: "",
            image: "",
            name: "",
            datetime: ""
        )
        service.mockResponse = .success(events: [mockApp])
        sut { [weak self] result in
            guard let self = self else {
                XCTFail("This test is sync given that mocks answer sync")
                return
            }
            if case .success = result {
                XCTAssertTrue(self.sut.hasCachedData, "Data needs to be cached")
                XCTAssertEqual(self.repository.listAllEvents().count, 1, "Mock App Saved")
                XCTAssertTrue(self.repository.removeAllAppsCalled,
                              "Old Data needs to be removed, otherwise rank could be messed up")
            } else {
                XCTFail("Sync is not synching data correctly")
            }
        }
    }
}
