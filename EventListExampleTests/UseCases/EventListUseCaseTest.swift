//
//  EventListUseCaseTest.swift
//  EventListExampleTests
//
//  Created by Ghanshyam Bhesaniya on 07/06/22.
//

import XCTest
@testable import EventListExample

class EventListUseCaseTest: XCTestCase {
    var repository: MockEventRepository!
    var sut: EventListImp!
    
    override func setUpWithError() throws {
        repository = MockEventRepository()
        sut = EventListImp(repository: repository)
    }
    
    override func tearDown() {
        repository = nil
        sut = nil
    }
    
    func testListAllApps() {
        let event1 = buildApp(eventId: "1")
        let event2 = buildApp(eventId: "2")
        
        let save = expectation(description: "Saving apps")
        repository.save(events: [event1, event2]) { [weak self] _ in
            guard let self = self else {
                XCTFail("Self was deallocated")
                return
            }
            let listedEvents = self.sut()
            
            XCTAssertEqual(listedEvents.count, 2, "Two Mock Saved")
            XCTAssertEqual(listedEvents.first!.id, event1.id, "event 1 comes first")
            XCTAssertEqual(listedEvents.first!.name, event1.name, "input must match output")
            XCTAssertEqual(listedEvents.first!.image, event1.image, "input must match output")
            save.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
}

private extension EventListUseCaseTest {
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

