//
//  SeasonsCoordinator.swift
//  Football
//

import SwiftUI
import Network

struct SeasonsCoordinator: View {
    @State private var router = ViewRouter()
    @EnvironmentObject private var tabRouter: AppTabRouter
    @Environment(ModalScreenRouter.self) private var modalRouter
    
    var body: some View {
        NavigationStack(path: $router.path) {
            SeasonsView()
                .navigationDestination(for: AnyHashable.self) { destination in
                    switch destination {
                    case let seasonID as Int:
                        StagesView(model: StagesViewModel(seasonID: seasonID))
                        
                    case let topScorerDestination as TopScorerDestination:
                        switch topScorerDestination {
                        case .season(let seasonID):
                            TopScorersView(model: TopScorerViewModel(seasonID: seasonID))
                        case .stage(let stageID):
                            TopScorersView(model: TopScorerViewModel(stageID: stageID))
                        }

                    case let rounds as [Round]:
                        RoundsView(model: RoundsViewModel(data: rounds))
                    default:
                        EmptyView()
                    }
                }
                .onReceive(tabRouter.$tabReselected) { tabReselected in
                    guard tabReselected, tabRouter.selection == .seasons, !router.path.isEmpty else { return }
                    router.popToRoot()
                }
        }
        .environment(router)
    }
}

#Preview {
    LeaguesCoordinator()
}

enum TopScorerDestination: Hashable {
    case season(id: Int)
    case stage(id: Int)
}
