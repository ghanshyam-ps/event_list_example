//
//  EventListLocalRepository.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 04/06/22.
//

import Foundation


class EventListLocalRepository: EventRepository {
    
    private var allEvents: [String: EventDataModel] = [:]
    
    var lastSyncDate: Date?
    
    func listAllEvents() -> AnyCollection<EventDataModel> {
        let _events = allEvents.map { $0.value }
        return AnyCollection(_events)
    }
    
    func findEvent(eventId: String) -> EventDataModel? {
        return allEvents[eventId]
    }
    
    func save(events: [EventDataModel], completion: @escaping (SaveStatus) -> Void) {
        events.forEach { allEvents[$0.id] = $0 }
        lastSyncDate = Date()
        completion(.success)
    }
    
    func removeAllEvents() {
        allEvents.removeAll(keepingCapacity: true)
    }
}
