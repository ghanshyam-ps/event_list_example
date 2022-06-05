//
//  SyncEventListImp.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 04/06/22.
//

import Foundation



final class SyncEventListImp: SyncEventListUseCase {
    
    private static var lastSyncResult: SyncResult? = nil
    private static let numberOfAppsToSync: Int = 100
    
    private let repository: EventRepository
    private let service: EventListService
    
    init(repository: EventRepository, service: EventListService) {
        self.repository = repository
        self.service = service
    }
    
    var hasCachedData: Bool {
        return repository.lastSyncDate != nil
    }
    
    var lastSyncResult: SyncResult? {
        return SyncEventListImp.lastSyncResult
    }
    
    func callAsFunction(_ completion: @escaping (SyncResult) -> ()) {
        let repository = self.repository
        func onDidComplete(result: SyncResult) {
            SyncEventListImp.lastSyncResult = result
            completion(result)
        }
        
        service.retrieveAllEvent(count: Self.numberOfAppsToSync) {
            switch $0 {
            case .success(let events):
                repository.removeAllEvents()
                repository.save(events: events) { result in
                    switch result {
                    case .success:
                        onDidComplete(result: .success)
                    case .failure:
                        onDidComplete(result: .failure(error: .unknown))
                    }
                }
            case .notConnectedToInternet:
                onDidComplete(result: .failure(error: .notInternetConnection))
            case .failure:
                onDidComplete(result: .failure(error: .unknown))
            }
        }
    }
}
