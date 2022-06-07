//
//  GetEventDetailUseCaseTest.swift
//  EventListExampleTests
//
//  Created by Ghanshyam Bhesaniya on 06/06/22.
//

import XCTest
@testable import EventListExample

final class GetEventDetailUseCaseTest: XCTestCase {
    var repository: MockEventRepository!
    var sut: GetEventDetailImp!
    
    override func setUpWithError() throws {
        repository = MockEventRepository()
        sut = GetEventDetailImp(repository: repository)
    }
    
    override func tearDown() {
        repository = nil
        sut = nil
    }
    
    func testGetDetails() {
        let mockApp = buildApp(eventId: "1")
        
        let save = expectation(description: "Saving events")
        repository.save(events: [mockApp]) { [weak self] _ in
            guard let self = self else {
                XCTFail("Self was deallocated")
                return
            }
            let details = self.sut(eventId: "1")
            
            XCTAssertNotNil(details)
            XCTAssertEqual(details!.id, mockApp.id, "id must match output")
            XCTAssertEqual(details!.name, mockApp.name, "name must match output")
            XCTAssertEqual(details!.image, mockApp.image, "image must match output")
            XCTAssertEqual(details!.datetime, mockApp.datetime, "datetime must match output")
            XCTAssertEqual(details!.title, mockApp.title, "title must match output")
            
            save.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
}


private extension GetEventDetailUseCaseTest {
    func buildApp(eventId: String ) -> EventDataModel {
        return EventData(
            id: eventId,
            title: "",
            image: "",
            name: "",
            datetime: ""
        )
    }
}
