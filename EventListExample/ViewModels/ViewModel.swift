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
}

