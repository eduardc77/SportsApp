//
//  AppScreen.swift
//  FootballApp
//

import SwiftUI

enum AppScreen: Codable, Hashable, Identifiable, CaseIterable {
    case leagues
    case seasons
    case stages
    case fixtures
    case teams
    case players
    case coaches
    case settings
    
    var id: AppScreen { self }
}

extension AppScreen {
    @ViewBuilder
    var label: some View {
        switch self {
        case .leagues:
            Label("Leagues", systemImage: "trophy.fill")
        case .seasons:
            Label("Seasons", systemImage: "calendar")
        case .stages:
            Label("Stages", systemImage: "squares.leading.rectangle")
        case .fixtures:
            Label("Fixtures", systemImage: "sportscourt.fill")
        case .teams:
            Label("Teams", systemImage: "soccerball")
        case .players:
            Label("Players", systemImage: "figure.soccer")
        case .coaches:
            Label("Coaches", systemImage: "figure.stairs")
        case .settings:
            Label("Settings", systemImage: "gearshape.fill")
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .leagues:
            LeaguesCoordinator()
        case .seasons:
            SeasonsCoordinator()
        case .stages:
            StagesCoordinator()
        case .fixtures:
            FixturesCoordinator()
        case .teams:
            TeamsCoordinator()
        case .players:
            PlayersCoordinator()
        case .coaches:
            CoachesCoordinator()
        case .settings:
            SettingsCoordinator()
        }
    }
}
