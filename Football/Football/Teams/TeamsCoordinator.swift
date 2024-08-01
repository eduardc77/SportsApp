//
//  TeamsCoordinator.swift
//  FootballApp
//

import SwiftUI
import Network

struct TeamsCoordinator: View {
    @StateObject private var router = ViewRouter()
    @EnvironmentObject private var tabRouter: AppTabRouter
    @EnvironmentObject private var modalRouter: ModalScreenRouter
    
    var body: some View {
        NavigationStack(path: $router.path) {
            TeamsView()
                .navigationDestination(for: AnyHashable.self) { destination in
                    switch destination {
                    case .teamSquad(let teamID) as TeamDestination:
                        SquadView(teamID: teamID)
                    default:
                        EmptyView()
                    }
                }
                .onReceive(tabRouter.$tabReselected) { tabReselected in
                    guard tabReselected, tabRouter.selection == .teams, !router.path.isEmpty else { return }
                    router.popToRoot()
                }
        }
        .environmentObject(router)
    }
}

enum TeamDestination: Hashable {
    case teamSquad(id: Int)
}

#Preview {
    TeamsCoordinator()
}
