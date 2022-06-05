//
//  EventListImp.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 04/06/22.
//

import Foundation

final class EventListImp: EventListUseCase {
    
    
    private let repository: EventRepository
    
    init(repository: EventRepository) {
        self.repository = repository
    }
    
    func callAsFunction() -> AnyCollection<EventDataModel> {
        let events = self.repository.listAllEvents()
        return events;
    }
}
