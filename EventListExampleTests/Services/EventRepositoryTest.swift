//
//  EventRepositoryTest.swift
//  EventListExampleTests
//
//  Created by Ghanshyam Bhesaniya on 06/06/22.
//

import XCTest
@testable import EventListExample

class EventRepositoryTest: XCTestCase {
    
    // Add here all the repositories you want to test
    var repositoriesToTest: [EventRepository]!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        repositoriesToTest = [CoreDataRepository(), EventListLocalRepository()]
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        repositoriesToTest.forEach { $0.removeAllEvents() }
        repositoriesToTest = nil
    }
    
    func testSaving() {
        let mockApp = buildApp(eventId: "123")
    
        save(events: [mockApp]) { repository in
            let eventList = repository.listAllEvents()
            XCTAssertEqual(eventList.count, 1, "Single Mock Saved")
            print("apps count \(eventList.count)")
            XCTAssertEqual(eventList.first!.id, mockApp.id, "id must match output")
            XCTAssertEqual(eventList.first!.name, mockApp.name, "name must match output")
            XCTAssertEqual(eventList.first!.title, mockApp.title, "title must match output")
            XCTAssertEqual(eventList.first!.datetime, mockApp.datetime, "datetime must match output")
            XCTAssertNotNil(repository.lastSyncDate, "Sync date must be set")
        }
    }
    
    func testFindEvent() {
        let mockApp = buildApp(eventId: "123")
        
        save(events: [mockApp]) { repository in
            let foundApp = repository.findEvent(eventId: mockApp.id)
            
            XCTAssertNotNil(foundApp, "Event must exist in \(repository)")
            XCTAssertEqual(foundApp?.id, mockApp.id, "Must be the same imported events")
        }
    }
    
    func testListAllEvents() {
        let mockApp1 = buildApp(eventId: "1")
        let mockApp2 = buildApp(eventId: "2")
        
        save(events: [mockApp1, mockApp2]) { repository in
            let events = repository.listAllEvents()
            
            XCTAssertEqual(events.count, 2, "Two Mock Saved")
            XCTAssertEqual(events.first!.id, mockApp1.id, "id 1 comes first")
            let secondApp = events[type(of: events).Index(1)]
            XCTAssertEqual(secondApp.id, mockApp2.id, "id 2 comes last")
        }
    }
}


private extension EventRepositoryTest {
    func buildApp(eventId: String ) -> EventDataModel {
        return EventData(
            id: eventId,
            title: "",
            image: "",
            name: "",
            datetime: ""
        )
    }
    
    func save(events: [EventDataModel], success: @escaping (EventRepository) -> Void) {
        var expectations: [XCTestExpectation] = []
        
        repositoriesToTest.forEach { repository in
            let saving = expectation(description: "saving")
            
            repository.save(events: events) { result in
                if case .success = result {
                    success(repository)
                } else {
                    XCTFail("Saving failed")
                }
                
                saving.fulfill()
            }
            expectations.append(saving)
        }
        wait(for: expectations, timeout: 2)
    }
}
