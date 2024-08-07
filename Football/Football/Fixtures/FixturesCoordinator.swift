//
//  FixturesCoordinator.swift
//  Football
//

import SwiftUI
import Network

struct FixturesCoordinator: View {
    @StateObject private var router = ViewRouter()
    @EnvironmentObject private var tabRouter: AppTabRouter
    @EnvironmentObject private var modalRouter: ModalScreenRouter
    
    var body: some View {
        NavigationStack(path: $router.path) {
            FixturesView(model: FixturesViewModel())
                .navigationDestination(for: AnyHashable.self) { destination in
                    switch destination {
                    case let teams as [Team]:
                        TeamsView(model: TeamsViewModel(data: teams))
                    case let teamID as Int:
                        SquadView(model: SquadViewModel(teamID: teamID))
                    default:
                        EmptyView()
                    }
                }
                .onReceive(tabRouter.$tabReselected) { tabReselected in
                    guard tabReselected, tabRouter.selection == .fixtures, !router.path.isEmpty else { return }
                    router.popToRoot()
                }
        }
        .environmentObject(router)
    }
}

#Preview {
    LeaguesCoordinator()
}
