//
//  BaseViewModel.swift
//  FootballApp
//

import Foundation

class BaseViewModel<State: ViewStateProtocol>: ObservableObject {
    @Published var state: State = .initial
    
    func changeState(_ state: State) {
        DispatchQueue.main.async { [weak self] in
            self?.state = state
            //            debugPrint("State changed to \(state)")
        }
    }
}
