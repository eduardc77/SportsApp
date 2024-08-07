//
//  LeaguesCoordinator.swift
//  FootballApp
//

import SwiftUI
import Network

struct LeaguesCoordinator: View {
    @State private var router = ViewRouter()
    @EnvironmentObject private var tabRouter: AppTabRouter
    @Environment(ModalScreenRouter.self) private var modalRouter
    
    var body: some View {
        NavigationStack(path: $router.path) {
            LeaguesView()
                .navigationDestination(for: AnyHashable.self) { destination in
                    switch destination {
                    case let seasons as [Season]:
                        if !seasons.isEmpty {
                            SeasonsView(model: SeasonsViewModel(data: seasons))
                        }
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
                        if !rounds.isEmpty {
                            RoundsView(model: RoundsViewModel(data: rounds))
                        }
                    case let stageID as Int:
                        TopScorersView(model: TopScorerViewModel(stageID: stageID))
                    case let fixtures as [Fixture]:
                        if !fixtures.isEmpty {
                            FixturesView(model: FixturesViewModel(data: fixtures))
                        }
                    case let teamID as Int:
                        SquadView(model: SquadViewModel(teamID: teamID))
                    default:
                        EmptyView()
                    }
                }
                .onReceive(tabRouter.$tabReselected) { tabReselected in
                    guard tabReselected, tabRouter.selection == .leagues, !router.path.isEmpty else { return }
                    router.popToRoot()
                }
        }
        .environment(router)
    }
}


#Preview {
    LeaguesCoordinator()
}
