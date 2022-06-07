//
//  MockEventRepository.swift
//  EventListExampleTests
//
//  Created by Ghanshyam Bhesaniya on 06/06/22.
//

import Foundation

class MockEventRepository: EventListLocalRepository {
    var removeAllAppsCalled = false
    
    override func removeAllEvents() {
        super.removeAllEvents()
        removeAllAppsCalled = true
    }
}
