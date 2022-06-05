//
//  EventData.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 04/06/22.
//

import Foundation


protocol EventDataModel {
    var id: String { get }
    var title: String { get }
    
}

struct EventData : EventDataModel{
    let id: String
    let title: String
}
