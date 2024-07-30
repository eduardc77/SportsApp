//
//  LeaguesView.swift
//  FootballApp
//

import SwiftUI
import Network

struct LeaguesView: View {
    @StateObject private var model = LeaguesViewModel()
    
    @EnvironmentObject private var router: ViewRouter
    @EnvironmentObject private var tabCoordinator: AppTabRouter
    @EnvironmentObject private var modalRouter: ModalScreenRouter

    var body: some View {
        baseView()
            .navigationBar(title: "News")
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
                leaguesGrid
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

private extension LeaguesView {
    
    var leaguesGrid: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            ForEach(Array(model.allLeagues.enumerated()), id: \.offset) { index, league in
                Button {
//                    router.push(league)
                } label: {
                    LeagueGridItem(item: league)
                }
            }
            
            Rectangle()
                .fill(.clear)
                .frame(height: 20) // Bottom padding
                .task {
                    if model.state != .loading, !model.allLeagues.isEmpty {
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
