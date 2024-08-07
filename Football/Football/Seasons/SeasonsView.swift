//
//  SeasonsView.swift
//  FootballApp
//

import SwiftUI

struct SeasonsView: View {
    @State private var model: SeasonsViewModel
    
    @Environment(ViewRouter.self) private var router
    @EnvironmentObject private var tabCoordinator: AppTabRouter
    @Environment(ModalScreenRouter.self) private var modalRouter
    
    init(model: SeasonsViewModel = SeasonsViewModel()) {
        self.model = model
    }
    
    var body: some View {
        baseView
            .navigationBar(title: "Seasons")
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

private extension SeasonsView {
    
    var gridView: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            ForEach(model.data, id: \.id) { season in
                SwiftUI.Button {
                    router.push(season.id)
                } label: {
                    SeasonGridItem(item: season)
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
        SeasonsView()
    }
}
