//
//  AnyCollection.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 05/06/22.
//

extension AnyCollection {
  func unbox() -> [Element] {
    return self.map { $0 }
  }
}
