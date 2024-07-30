//
//  TeamsView.swift
//  FootballApp
//

import SwiftUI
import Network

struct TeamsView: View {
    @StateObject private var model = TeamsViewModel()
    
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
                teamsGrid
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
                        await model.fetchAllTeams()
                    }
                }
        }
    }
}

// MARK: - Subviews

private extension TeamsView {
    
    var teamsGrid: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            ForEach(Array(model.allTeams.enumerated()), id: \.offset) { index, team in
                SwiftUI.Button {
                    //router.push(league)
                } label: {
                    TeamGridItem(item: team)
                }
            }
            
            Rectangle()
                .fill(.clear)
                .frame(height: 20) // Bottom padding
                .task {
                    if model.state != .loading, !model.allTeams.isEmpty {
                        await model.loadMoreContent()
                    }
                }
        }
        .padding(10)
    }
}

#Preview {
    NavigationStack {
        TeamsView()
    }
}
