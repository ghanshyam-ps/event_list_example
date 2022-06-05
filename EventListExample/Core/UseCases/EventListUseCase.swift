//
//  ListEventUseCase.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 04/06/22.
//

import Foundation

protocol EventListUseCase {
    func callAsFunction() -> AnyCollection<EventDataModel>
}
