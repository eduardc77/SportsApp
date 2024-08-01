//
//  SquadView.swift
//  FootballApp
//

import SwiftUI
import Network

struct SquadView: View {
    @State private var model: SquadViewModel
    
    @EnvironmentObject private var router: ViewRouter
    @EnvironmentObject private var tabCoordinator: AppTabRouter
    @EnvironmentObject private var modalRouter: ModalScreenRouter
    
    init(teamID: Int) {
        model = SquadViewModel(teamID: teamID)
    }
    
    var body: some View {
        baseView()
            .navigationBar(title: "Team Squad")
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
                squadGrid
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
                        await model.fetchTeamSquad()
                    }
                }
        }
    }
}

// MARK: - Subviews

private extension SquadView {
    
    var squadGrid: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            ForEach(model.teamSquad, id: \.id) { player in
                SwiftUI.Button {
                    
                } label: {
                    SquadGridItem(item: player)
                }
            }
            
            Rectangle()
                .fill(.clear)
                .frame(height: 20) // Bottom padding
                .task {
                    if model.state != .loading, !model.teamSquad.isEmpty {
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
