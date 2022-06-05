//
//  View.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 04/06/22.
//


import Foundation
import Boundaries
import UIKit

final class View: Boundary {
    typealias Dependencies = BoundaryList.Add<ViewModel>
    
    let storyboard: UIStoryboard = .init(name: "Main", bundle: nil)
    
    var rootViewController: InputPort<UIViewController?> {
        let eventListVC = self.instantiateViewController { [weak self] coder -> EventListVC? in
    
            guard let self = self else { fatalError("Component must be retained") }
            return EventListVC(
                listViewModel: self.dependencies.eventListViewModel,
                syncEventListViewModel: self.dependencies.eventsSyncViewModel,
                coder: coder
            )
            
        }
        return makeInputPort(implementation: UINavigationController(rootViewController: eventListVC))
    }
    
}

private extension View {
    func instantiateViewController<T: UIViewController>(construction: @escaping (NSCoder) -> T?) -> UIViewController {
        let identifier = String(describing: T.self)
        return self.storyboard.instantiateViewController(identifier: identifier) { (coder) -> UIViewController? in
            construction(coder)
        }
    }
}
