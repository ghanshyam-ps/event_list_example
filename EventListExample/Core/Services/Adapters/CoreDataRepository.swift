//
//  CoreDataRepository.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 04/06/22.
//

import Foundation
import CoreData
import MagicalRecord

public final class SyncEventEntity: NSManagedObject {
    @NSManaged public var eventTitle: String?
    @NSManaged public var eventId: String?
}

extension SyncEventEntity: EventDataModel {
    
    var id: String { return eventId ?? "0"}
    
    var title: String { return eventTitle ?? ""}
}

final class CoreDataRepository: EventRepository {
    
    
    var lastSyncDate: Date? {
        get { return UserDefaults.standard.value(forKey:"lastSyncDate") as? Date }
        set(value) { UserDefaults.standard.set(value, forKey: "lastSyncDate") }
    }
    
    init() {
        configureCoreDataStack()
    }
    
    func listAllEvents() -> AnyCollection<EventDataModel> {
        return AnyCollection((SyncEventEntity.mr_findAll() as! [SyncEventEntity]).map { $0 as EventDataModel })
    }
    
    func save(events: [EventDataModel], completion: @escaping (SaveStatus) -> Void) {
        MagicalRecord.save({ (ctx) in
            for event in events {
                let entity = SyncEventEntity.mr_createEntity(in: ctx)
                
                entity?.eventTitle = event.title
                entity?.eventId = event.id
            }
        }) { [weak self] (succeed, _) in
            self?.lastSyncDate = Date()
            completion(succeed ? .success : .failure)
        }
    }
    
    func removeAllEvents() {
        MagicalRecord.save(blockAndWait: { ctx in
            SyncEventEntity.mr_truncateAll(in: ctx)
        })
    }
    
}


private extension CoreDataRepository {
    func configureCoreDataStack() {
        MagicalRecord.setupCoreDataStack()
    }
}
