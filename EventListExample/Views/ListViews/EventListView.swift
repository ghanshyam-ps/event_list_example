//
//  AppListView.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 04/06/22.
//

import Foundation
import UIKit

//protocol EventListCellProtocol: AnyObject {
//    var lblTitle: UILabel? { get }
//}

protocol EventListView: AnyObject {
    var listDelegate: EventListViewDelegate? { get set }
    
    func cell(atIndex: Int) -> EventListCell?
    func reloadData(animated: Bool)
}

protocol EventListViewDelegate: AnyObject {
    func numberOfCells() -> Int
    func configure(cell: EventListCell, atIndex index: Int)
    func didSelect(cell: EventListCell, atIndex index: Int)
}

