//
//  EventListVC.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 04/06/22.
//

import UIKit

class EventListVC: UIViewController {

    weak var listView: EventListView?

    @IBOutlet weak var listContainerView: UIView?
    
    fileprivate let eventListViewModel: EventListViewModel
    fileprivate let syncEventListViewModel: SyncEventListViewModel
    
    init?(
        listViewModel: EventListViewModel,
        syncEventListViewModel: SyncEventListViewModel,
        coder: NSCoder
    ) {
        self.eventListViewModel = listViewModel
        self.syncEventListViewModel = syncEventListViewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init(listViewModel: EventListViewModel, coder: NSCoder)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Events"
        self.configureUI()
        self.configureBinding()
        self.syncEventListViewModel.startSync()
    }
}

// MARK: - Configuration

private extension EventListVC {
    func configureUI() {
        guard let listContainerView = self.listContainerView else {
            return
        }
        
        
        let listView: UIView = EventTableListView(frame: listContainerView.bounds)
            
        listView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        listView.translatesAutoresizingMaskIntoConstraints = true
        (listView as? EventListView)?.listDelegate = self
        listContainerView.addSubview(listView)
        self.listView = listView as? EventListView
    }
    
    func configureBinding() {
        updateUI(animated: false)
        syncEventListViewModel.onDidChangeState = {
            [weak self] state in
           self?.onDidChange(state: state)
        }
        eventListViewModel.onListDidChange = { [weak self] in
            self?.updateUI(animated: true)
        }
    }
    
    func updateUI(animated: Bool) {
        listView?.reloadData(animated: animated)
    }
    
    func onDidChange(state: SyncEventListViewModel.State) {
        switch state {
        case .finish(errorMessage: .none):
            eventListViewModel.updateEvents()
            updateUI(animated: false)
            break
        case .finish(.some( _)):
        
            break
        case .syncing:
            break
        case .idle:
            break
        }
    }
}

// MARK: - AppListViewDelegate
extension EventListVC: EventListViewDelegate {
    func numberOfCells() -> Int {
        return eventListViewModel.events.count
    }
    
    func configure(cell: EventListCell, atIndex index: Int) {
        let event = events(atIndex: index)
        cell.lblTitle?.text = event.name
    }
    
    func didSelect(cell: EventListCell, atIndex index: Int) {
    
    }
    
    private func events(atIndex index: Int) -> EventListCellViewModel {
        //return eventListViewModel.events[AnyIndex(AnyIndex(AnyIndex(index)))]
        return eventListViewModel.events.unbox()[index]
    }

}
