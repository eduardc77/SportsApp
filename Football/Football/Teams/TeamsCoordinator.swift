//
//  TeamsCoordinator.swift
//  FootballApp
//

import SwiftUI
import Network

struct TeamsCoordinator: View {
    @State private var router = ViewRouter()
    @EnvironmentObject private var tabRouter: AppTabRouter
    @Environment(ModalScreenRouter.self) private var modalRouter
    
    var body: some View {
        NavigationStack(path: $router.path) {
            TeamsView()
                .navigationDestination(for: AnyHashable.self) { destination in
                    switch destination {
                    case let players as [Player]:
                        PlayersView(model: PlayersViewModel(data: players))
                    case let teamID as Int:
                        SquadView(model: SquadViewModel(teamID: teamID))
                    default:
                        EmptyView()
                    }
                }
                .onReceive(tabRouter.$tabReselected) { tabReselected in
                    guard tabReselected, tabRouter.selection == .teams, !router.path.isEmpty else { return }
                    router.popToRoot()
                }
        }
        .environment(router)
    }
}

#Preview {
    TeamsCoordinator()
}
