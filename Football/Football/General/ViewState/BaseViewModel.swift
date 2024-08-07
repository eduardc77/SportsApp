//
//  BaseViewModel.swift
//  FootballApp
//

import Observation

@Observable
class BaseViewModel<State: ViewStateProtocol> {
    var state: State = .initial
    
    @MainActor
    func changeState(_ state: State) {
        self.state = state
    }
}
