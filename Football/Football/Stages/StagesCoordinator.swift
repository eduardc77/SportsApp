//
//  StagesCoordinator.swift
//  Football
//

import SwiftUI
import Network

struct StagesCoordinator: View {
    @StateObject private var router = ViewRouter()
    @EnvironmentObject private var tabRouter: AppTabRouter
    @EnvironmentObject private var modalRouter: ModalScreenRouter
    
    var body: some View {
        NavigationStack(path: $router.path) {
            StagesView()
                .navigationDestination(for: AnyHashable.self) { destination in
                    switch destination {
                    case let rounds as [Round]:
                        RoundsView(model: RoundsViewModel(data: rounds))
                    case let fixtures as [Fixture]:
                        FixturesView(model: FixturesViewModel(data: fixtures))
                    default:
                        EmptyView()
                    }
                }
                .onReceive(tabRouter.$tabReselected) { tabReselected in
                    guard tabReselected, tabRouter.selection == .stages, !router.path.isEmpty else { return }
                    router.popToRoot()
                }
        }
        .environmentObject(router)
    }
}

enum StagesDestination {
    case rounds(rounds: [Round])
}

#Preview {
    LeaguesCoordinator()
}
