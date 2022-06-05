//
//  UseCase.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 04/06/22.
//

import Foundation
import Boundaries

final class UseCase: Boundary {
    struct Plugins: PluginBoundary {
        var repository: InputPort<EventRepository>
        var service: InputPort<EventListService>
    }
    typealias Dependencies = BoundaryList.Add<Entity>.Add<Plugins>
    
    var listEvent: InputPort<EventListImp> {
        return makeInputPort(
            implementation: EventListImp(
                repository: self.dependencies.repository
            )
        )
    }

    
    var syncEvents: InputPort<SyncEventListUseCase> {
        return makeInputPort(
            implementation: SyncEventListImp(
                repository: self.dependencies.repository,
                service: self.dependencies.service
            )
        )
    }
}
