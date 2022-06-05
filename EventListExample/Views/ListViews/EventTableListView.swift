//
//  AppTableListView.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 04/06/22.
//

import Foundation
import UIKit


final class EventTableListView: UITableView  {

    weak var listDelegate: EventListViewDelegate?
    
    init(frame: CGRect) {
        super.init(frame: frame, style: .plain)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
}

// MARK: Configuration

private extension EventTableListView {
    func configure() {
        self.delegate = self
        self.dataSource = self
        self.rowHeight = UITableView.automaticDimension;
        self.estimatedRowHeight = 60;

        self.separatorInset = .zero
        //register(EventListCell.self, forCellReuseIdentifier: EventListCell.identify)
        register(UINib(nibName: EventListCell.identify, bundle: nil), forCellReuseIdentifier: EventListCell.identify)
    }
}

// MARK: AppListView

extension EventTableListView: EventListView {
    func cell(atIndex index: Int) -> EventListCell? {
        return cellForRow(at: IndexPath(row: index, section: 0)) as? EventListCell
    }
    
    func reloadData(animated: Bool) {
        if animated {
            UIView.transition(with: self,
                              duration: 2,
                              options: .transitionCrossDissolve,
                              animations: UITableView.reloadData(self),
                              completion: nil)
        } else {
            reloadData()
        }
    }
}

// MARK: UITableViewDataSource

extension EventTableListView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDelegate?.numberOfCells() ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventListCell.identify) as? EventListCell ?? UITableViewCell()
        
        listDelegate?.configure(cell: cell as! EventListCell, atIndex: indexPath.row)
        
        return cell
    }
}

// MARK: UITableViewDelegate

extension EventTableListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listDelegate?.didSelect(cell: tableView.cellForRow(at: indexPath)! as! EventListCell, atIndex: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

