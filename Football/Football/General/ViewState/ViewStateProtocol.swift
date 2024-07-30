//
//  ViewStateProtocol.swift
//  FootballApp
//

protocol ViewStateProtocol {
    static var initial: Self { get }
}

protocol ViewStatable {
    associatedtype ViewState: ViewStatable = DefaultViewState
}

enum DefaultViewState: ViewStateProtocol {
    case initial
}
