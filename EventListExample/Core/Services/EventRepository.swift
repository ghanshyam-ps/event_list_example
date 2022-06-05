//
//  AppsRepository.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 04/06/22.
//

import Foundation

enum SaveStatus {
    case success
    case failure
}

protocol EventRepository {
    var lastSyncDate: Date? { get }
    func listAllEvents() -> AnyCollection<EventDataModel>
    func save(events: [EventDataModel], completion: @escaping (SaveStatus) -> Void)
    func removeAllEvents()
}
