//
//  TeamsView.swift
//  FootballApp
//

import SwiftUI

struct TeamsView: View {
    @State private var model: TeamsViewModel
    
    @Environment(ViewRouter.self) private var router
    @EnvironmentObject private var tabCoordinator: AppTabRouter
    @Environment(ModalScreenRouter.self) private var modalRouter
    
    init(model: TeamsViewModel = TeamsViewModel()) {
        self.model = model
    }
    
    var body: some View {
        baseView()
            .navigationBar(title: "Teams")
            .refreshable {
                await model.refresh()
            }
    }
    
    @ViewBuilder
    private func baseView() -> some View {
        switch model.state {
        case .empty:
            Label("No Data", systemImage: "newspaper")
        case .finished:
            ScrollView {
                gridView
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
                        //                        model.changeStateToEmpty()
                    }
                }
            }
        case .initial:
            ProgressView()
                .task {
                    guard model.data.isEmpty else {
                        model.changeState(.finished)
                        return
                    }
                    await model.fetchAllData()
                }
        }
    }
}

// MARK: - Subviews

private extension TeamsView {
    
    var gridView: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            ForEach(model.data, id: \.id) { team in
                SwiftUI.Button {
                    if let players = team.players {
                        router.push(players)
                    } else {
                        router.push(team.id)
                    }
                } label: {
                    TeamGridItem(item: team)
                }
            }
            
            if model.state != .loading, !model.data.isEmpty, model.hasMoreContent {
                ProgressView()
                    .task {
                        await model.loadMoreContent()
                    }
            }
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        TeamsView()
    }
}
