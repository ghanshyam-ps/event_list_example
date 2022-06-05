//
//  Service.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 04/06/22.
//

import Foundation
import Boundaries

final class Service: AdapterBoundary {
    
    typealias PluginAdaptee = UseCase.Plugins
    
    func makePlugin() -> UseCase.Plugins {
        let repository = CoreDataRepository()
        let appstoreService = EventListWebService()
        return UseCase.Plugins(
            repository: makeInputPort(implementation: repository),
            service: makeInputPort(implementation: appstoreService)
        )
    }
}

