//
//  StagesView.swift
//  FootballApp
//

import SwiftUI

struct StagesView: View {
    @State private var model: StagesViewModel
    
    @Environment(ViewRouter.self) private var router
    @EnvironmentObject private var tabCoordinator: AppTabRouter
    @EnvironmentObject private var modalRouter: ModalScreenRouter
    
    init(model: StagesViewModel = StagesViewModel()) {
        self.model = model
    }
    
    var body: some View {
        baseView
            .navigationBar(title: "Stages")
            .refreshable {
                Task {
                    await model.refresh()
                }
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
                        //                        model.changeStateToEmpty()
                    }
                }
            }
        case .initial:
            ProgressView()
                .task {
                    if let seasonID = model.seasonID {
                        await model.fetchDataBySeasonID(seasonID)
                    } else {
                        await model.fetchAllData()
                    }
                }
        }
    }
}

// MARK: - Subviews

private extension StagesView {
    
    var gridView: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            ForEach(model.data, id: \.id) { stage in
                Button {
                    if let rounds = stage.rounds, !rounds.isEmpty {
                        router.push(rounds)
                    } else {
                        router.push(stage.fixtures)
                    }
                } label: {
                    StageGridItem(item: stage)
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
        StagesView()
    }
}
