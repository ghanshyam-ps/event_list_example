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
    var image: String { get }
    var name: String { get }
    var datetime: String { get }
}

struct EventData : EventDataModel{
    let id: String
    let title: String
    var image: String
    var name: String
    var datetime: String
}
