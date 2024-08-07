//
//  RoundsView.swift
//  FootballApp
//

import SwiftUI

struct RoundsView: View {
    @State var model: RoundsViewModel
    
    @Environment(ViewRouter.self) private var router
    @EnvironmentObject private var tabCoordinator: AppTabRouter
    @EnvironmentObject private var modalRouter: ModalScreenRouter
    
    var body: some View {
        baseView
            .navigationBar(title: "Rounds")
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
                    if let seasonID = model.seasonID {
                        await model.fetchDataBySeasonID(seasonID)
                    } else if model.data.isEmpty {
                        await model.fetchAllData()
                    }
                }
        }
    }
}

// MARK: - Subviews

private extension RoundsView {
    
    var gridView: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            ForEach(model.data, id: \.id) { round in
                Button {
                    router.push(round.fixtures)
                } label: {
                    RoundGridItem(item: round)
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
        RoundsView(model: RoundsViewModel())
    }
}
