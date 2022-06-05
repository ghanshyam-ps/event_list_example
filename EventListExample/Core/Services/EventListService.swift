//
//  EventListService.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 04/06/22.
//

import Foundation

enum EventListResponse {
    case failure
    case notConnectedToInternet
    case success(events: [EventDataModel])
}

protocol EventListService {
    func retrieveAllEvent(count: Int, completion: @escaping (EventListResponse) -> Void)
}

