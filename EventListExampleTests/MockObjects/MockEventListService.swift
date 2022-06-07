//
//  MockEventListService.swift
//  EventListExampleTests
//
//  Created by Ghanshyam Bhesaniya on 06/06/22.
//

import Foundation

final class MockEventListService: EventListService {
    var mockResponse: EventListResponse!
    var serviceCalled: Bool = false
    
    init() {
    }
    
    func retrieveAllEvent(count: Int, completion: @escaping (EventListResponse) -> Void) {
        serviceCalled = true
        completion(mockResponse)
    }
}
