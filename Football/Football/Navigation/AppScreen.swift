//
//  AppScreen.swift
//  FootballApp
//

import SwiftUI

enum AppScreen: Codable, Hashable, Identifiable, CaseIterable {
    case leagues
    case teams
    case players
    case settings
    
    var id: AppScreen { self }
}

extension AppScreen {
    @ViewBuilder
    var label: some View {
        switch self {
        case .leagues:
            Label("Leagues", systemImage: "trophy.fill")
        case .teams:
            Label("Teams", systemImage: "soccerball")
        case .players:
            Label("Players", systemImage: "figure.soccer")
        case .settings:
            Label("Settings", systemImage: "gearshape.fill")
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .leagues:
            LeaguesCoordinator()
        case .teams:
            TeamsCoordinator()
        case .players:
            PlayersCoordinator()
        case .settings:
            SettingsCoordinator()
        }
    }
}
