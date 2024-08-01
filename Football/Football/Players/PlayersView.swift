//
//  PlayersView.swift
//  FootballApp
//

import SwiftUI
import Network

struct PlayersView: View {
    @State private var model = PlayersViewModel()
    
    @EnvironmentObject private var router: ViewRouter
    @EnvironmentObject private var tabCoordinator: AppTabRouter
    @EnvironmentObject private var modalRouter: ModalScreenRouter
    
    var body: some View {
        baseView()
            .navigationBar(title: "Players")
            .refreshable {
                Task {
                    await model.refresh()
                }
            }
    }
    
    @ViewBuilder
    private func baseView() -> some View {
        switch model.state {
        case .empty:
            Label("No Data", systemImage: "newspaper")
        case .finished:
            ScrollView {
                playersGrid
            }
        case .loading:
            ProgressView("Loading")
        case .error(error: let error):
            VStack {
                Label("Error", systemImage: "alert")
                Text(error)
            }
            .onFirstAppear {
                modalRouter.presentAlert(title: "Error", message: error) {
                    Button("Ok") {
                        model.changeStateToEmpty()
                    }
                }
            }
        case .initial:
            ProgressView()
                .onAppear {
                    Task {
                        await model.fetchAllLeagues()
                    }
                }
        }
    }
}

// MARK: - Subviews

private extension PlayersView {
    
    var playersGrid: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            ForEach(model.allPlayers, id: \.id) { player in
                Button {
                    // router.push(league)
                } label: {
                    PlayerGridItem(item: player)
                }
            }
            
            Rectangle()
                .fill(.clear)
                .frame(height: 20) // Bottom padding
                .task {
                    if model.state != .loading, !model.allPlayers.isEmpty {
                        await model.loadMoreContent()
                    }
                }
        }
        .padding(10)
    }
}

#Preview {
    NavigationStack {
        LeaguesView()
    }
}
