//
//  TopScorersView.swift
//  FootballApp
//

import SwiftUI

struct TopScorersView: View {
    @State var model = TopScorerViewModel()
    
    @Environment(ViewRouter.self) private var router
    @EnvironmentObject private var tabCoordinator: AppTabRouter
    @Environment(ModalScreenRouter.self) private var modalRouter
    
    var body: some View {
        baseView
            .navigationBar(title: "Top Scorers")
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
                        // model.changeStateToEmpty()
                    }
                }
            }
        case .initial:
            ProgressView()
                .task {
                    await model.fetchDataByID()
                }
        }
    }
}

// MARK: - Subviews

private extension TopScorersView {
    
    var gridView: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            ForEach(model.data, id: \.id) { topScorer in
                SwiftUI.Button {
                    
                } label: {
                    TopScorerGridItem(item: topScorer)
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
        TopScorersView()
    }
}
