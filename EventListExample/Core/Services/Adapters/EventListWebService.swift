//
//  EventListWebService.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 04/06/22.
//


import Foundation
import Alamofire

final class EventListWebService: EventListService {
    //https://api.seatgeek.com/2/events?client_id=MjY0MTM2MDd8MTY0OTA2OTI4OS4zODg1NTY1&per_page=100
    static let endPoint = "https://api.seatgeek.com/2/"
    
    func retrieveAllEvent(count: Int, completion: @escaping (EventListResponse) -> Void) {
        let path = "events?client_id=" + App.Key.SeatGeek.clientIdKey + "&per_page=100"
        
        AF.request(type(of: self).endPoint + path).responseJSON
        { response in
            guard let urlResponse = response.response else {
                if .notConnectedToInternet == (response.error?.underlyingError as? URLError)?.code {
                    completion(.notConnectedToInternet)
                } else {
                    completion(.failure)
                }
                return
            }
            
            switch urlResponse.statusCode {
            case 200...299:
                if case .success(let json) = response.result,
                    let jsonDictionary = json as? NSDictionary{
                    //let apps = EventListWebService.parse(response: jsonDictionary)
                
                    let eventData = jsonDictionary["events"] as? [[String:Any]] ?? []
                    
                    let eventModel = eventData.map { event -> EventData in
                        let eventId = event["id"] as? Int ?? 0
                        let venue = event["venue"] as? [String:Any] ?? [String:Any]()
                        let performers = event["performers"] as? [[String:Any]] ?? [[String:Any]]()
                        var image = ""
                        if !performers.isEmpty {
                            image = performers.first?["image"] as? String ?? ""
                        }
                        return EventData(
                            id: String(eventId),
                            title: event["short_title"] as? String ?? "",
                            image: image,
                            name: venue["name_v2"] as? String ?? "",
                            datetime: event["datetime_local"] as? String ?? ""
                        )
                    }
                    
                   completion(.success(events: eventModel))
                } else {
                    completion(.failure)
                }
            case NSURLErrorNotConnectedToInternet:
                completion(.notConnectedToInternet)
            default:
                completion(.failure)
            }
        }
    }
}

// MARK: Parsing

private extension EventListWebService {
    static func parse(response: NSDictionary) -> [EventDataModel]? {
        return [
            EventData(
                id: "",
                title: "",
                image: "",
                name: "",
                datetime: ""
            )
        ]
    }
}

