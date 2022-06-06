//
//  ViewModel.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 04/06/22.
//

import Foundation
import Boundaries

final class ViewModel: Boundary {
    typealias Dependencies = BoundaryList.Add<UseCase>
    
    var eventListViewModel: InputPort<EventListViewModel> {
        return makeInputPort(
            implementation:
                EventListViewModel(
                    syncEventData: self.dependencies.syncEvents,
                    listEvents: self.dependencies.listEvent
                )
        )
    }
    
    var eventsSyncViewModel: InputPort<SyncEventListViewModel> {
        return makeInputPort(
            implementation: SyncEventListViewModel(
                syncEventListUseCase: self.dependencies.syncEvents
            )
        )
    }
    
    
    var eventDetailsViewModel: InputPort<Factory<String, EventDetailViewModel>> {
        return makeInputPort(implementation: .init(construction: { [weak self] (eventId) -> EventDetailViewModel in
            guard let self = self else {
                fatalError("The component must be retained")
            }
            return EventDetailViewModel(eventId: eventId, getEventDetailUseCase: self.dependencies.getEventDetails )
        })
        )
    }
}

