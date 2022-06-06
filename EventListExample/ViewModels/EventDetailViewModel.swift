//
//  EventDetailViewModel.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 06/06/22.
//

import Foundation
import UIKit

final class EventDetailViewModel {

    let name: String
    let title: String
    var imageURL: String?
    let dateTime: String
    
    init(eventId: String, getEventDetailUseCase: GetEventDetailUseCase) {
        guard let  event = getEventDetailUseCase(eventId: eventId) else {
            name = ""
            title = ""
            dateTime = ""
            imageURL = ""
            return
        }
        
        name = event.name
        title = event.title
        if(!event.datetime.isEmpty){
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.date(from:event.datetime)!
            dateFormatter.dateFormat = "MMMM dd, yyyy - hh:mm a"
            dateTime = dateFormatter.string(from: date)
        } else {
            dateTime = ""
        }
        imageURL = event.image.isEmpty ? "https://picsum.photos/500" : event.image
    }
}
