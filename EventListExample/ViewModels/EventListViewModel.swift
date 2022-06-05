//
//  EventListViewModel.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 04/06/22.
//

import Foundation
final class EventListViewModel {
    
    var events: AnyCollection<EventListCellViewModel> = AnyCollection([])
    
    var onListDidChange: (() -> Void)? = nil
    private let syncEventData: SyncEventListUseCase
    private let listEvents: EventListImp
    
    init(syncEventData: SyncEventListUseCase, listEvents: EventListImp) {
        self.syncEventData = syncEventData
        self.listEvents = listEvents
        updateEvents()
    }

    func updateEvents() {
        events = AnyCollection(listEvents().lazy.map {
            EventListCellViewModel(event: $0)
        })
        onListDidChange?()
    }
}
