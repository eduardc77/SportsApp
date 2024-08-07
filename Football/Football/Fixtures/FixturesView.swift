//
//  FixturesView.swift
//  FootballApp
//

import SwiftUI

struct FixturesView: View {
    @State var model: FixturesViewModel
    
    @EnvironmentObject private var router: ViewRouter
    @EnvironmentObject private var tabCoordinator: AppTabRouter
    @EnvironmentObject private var modalRouter: ModalScreenRouter
    
    var body: some View {
        baseView
            .navigationBar(title: "Fixtures")
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
                    await model.fetchAllData()
                }
        }
    }
}

// MARK: - Subviews

private extension FixturesView {
    
    var gridView: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            ForEach(model.data, id: \.id) { fixture in
                Button {
                    router.push(fixture.participants ?? [])
                } label: {
                    FixtureGridItem(item: fixture)
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
        FixturesView(model: FixturesViewModel())
    }
}
