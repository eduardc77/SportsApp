//
//  SquadView.swift
//  FootballApp
//

import SwiftUI

struct SquadView: View {
    @State var model: SquadViewModel
    
    @EnvironmentObject private var router: ViewRouter
    @EnvironmentObject private var tabCoordinator: AppTabRouter
    @EnvironmentObject private var modalRouter: ModalScreenRouter
    
    var body: some View {
        baseView
            .navigationBar(title: "Team Squad")
            .refreshable {
                await model.refresh()
            }
    }
    
    @ViewBuilder
    private var baseView: some View {
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
                    Button("OK") {
                        //  model.changeStateToEmpty()
                    }
                }
            }
        case .initial:
            ProgressView()
                .task {
                    await model.fetchDataByTeamID()
                }
        }
    }
}

// MARK: - Subviews

private extension SquadView {
    
    var gridView: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            ForEach(model.data, id: \.id) { player in
                SwiftUI.Button {
                    
                } label: {
                    SquadGridItem(item: player)
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
