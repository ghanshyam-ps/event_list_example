//
//  SyncEventListViewModel.swift
//  EventListExample
//
//  Created by Ghanshyam Bhesaniya on 05/06/22.
//

final class SyncEventListViewModel {
    enum State {
        case idle
        case finish(errorMessage: String?)
        case syncing
    }
    
    var onDidChangeState: ((State) -> Void)? = nil
    fileprivate(set) var eventSyncState: State = .idle {
        didSet { onDidChangeState?(eventSyncState) }
    }
    
    private let syncEventListUseCase: SyncEventListUseCase
    
    init(syncEventListUseCase: SyncEventListUseCase) {
        self.syncEventListUseCase = syncEventListUseCase
    }
    
    func startSync() {
        eventSyncState = .syncing
        syncEventListUseCase { [weak self] result in
            guard let self = self else {
                return
            }
            self.didFinishSync(result: result, hasCachedData: self.syncEventListUseCase.hasCachedData)
        }
    }
    
}

fileprivate extension SyncEventListViewModel {
    func didFinishSync(result: SyncResult, hasCachedData: Bool) {
        switch result {
        case .success:
            eventSyncState = .finish(errorMessage: nil)
        case .failure(error: .unknown):
            let error = !hasCachedData ? "Cannot connect to the AppStore, please try again later" : nil
            eventSyncState = .finish(errorMessage: error)
        case .failure(error: .notInternetConnection):
            let error = !hasCachedData ? "Please check your internet connection" : nil
            eventSyncState = .finish(errorMessage: error)
        }
    }
}

