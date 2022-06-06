//
//  GetEventDetailImp.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 06/06/22.
//

import Foundation

final class GetEventDetailImp: GetEventDetailUseCase {
    private let repository: EventRepository
    
    init(repository: EventRepository) {
        self.repository = repository
    }
    
    func callAsFunction(eventId: String) -> EventDataModel? {
        return repository.findEvent(eventId: eventId)
    }
}
