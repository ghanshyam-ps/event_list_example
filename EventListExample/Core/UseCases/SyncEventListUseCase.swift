//
//  SyncEventListUseCase.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 04/06/22.
//

import Foundation



enum SyncResult {
    enum Error {
        case unknown
        case notInternetConnection
    }
    
    case success
    case failure(error: Error)
}

protocol SyncEventListUseCase {
    var lastSyncResult: SyncResult? { get }
    var hasCachedData: Bool { get }
    
    func callAsFunction(_ completion: @escaping (SyncResult) -> ())
}
