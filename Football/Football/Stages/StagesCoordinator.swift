//
//  StagesCoordinator.swift
//  Football
//

import SwiftUI
import Network

struct StagesCoordinator: View {
    @State private var router = ViewRouter()
    @EnvironmentObject private var tabRouter: AppTabRouter
    @Environment(ModalScreenRouter.self) private var modalRouter
    
    var body: some View {
        NavigationStack(path: $router.path) {
            StagesView()
                .navigationDestination(for: AnyHashable.self) { destination in
                    switch destination {
                    case let rounds as [Round]:
                        RoundsView(model: RoundsViewModel(data: rounds))
                        
                    case let fixtures as [Fixture]:
                        FixturesView(model: FixturesViewModel(data: fixtures))
                        
                    case let topScorerDestination as TopScorerDestination:
                        switch topScorerDestination {
                        case .season(let seasonID):
                            TopScorersView(model: TopScorerViewModel(seasonID: seasonID))
                        case .stage(let stageID):
                            TopScorersView(model: TopScorerViewModel(stageID: stageID))
                        }
                    default:
                        EmptyView()
                    }
                }
                .onReceive(tabRouter.$tabReselected) { tabReselected in
                    guard tabReselected, tabRouter.selection == .stages, !router.path.isEmpty else { return }
                    router.popToRoot()
                }
        }
        .environment(router)
    }
}

enum StagesDestination {
    case rounds(rounds: [Round])
}

#Preview {
    LeaguesCoordinator()
}
