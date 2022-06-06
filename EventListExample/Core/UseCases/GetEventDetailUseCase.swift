//
//  GetEventDetailUseCase.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 06/06/22.
//

import Foundation


protocol GetEventDetailUseCase {
    func callAsFunction(eventId: String) -> EventDataModel?
}
