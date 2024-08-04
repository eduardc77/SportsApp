//
//  SeasonsView.swift
//  FootballApp
//

import SwiftUI
import Network

struct SeasonsView: View {
    @State private var model: SeasonsViewModel
    
    @EnvironmentObject private var router: ViewRouter
    @EnvironmentObject private var tabCoordinator: AppTabRouter
    @EnvironmentObject private var modalRouter: ModalScreenRouter
    
    init(seasons: [Season] = []) {
        model = SeasonsViewModel(seasons: seasons)
    }
    
    var body: some View {
        baseView()
            .navigationBar(title: "Stages")
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
                seasonsGrid
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
                        model.changeStateToEmpty()
                    }
                }
            }
        case .initial:
            ProgressView()
                .onAppear {
                    guard model.allSeasons.isEmpty else { return }
                    Task {
                        await model.fetchTeamSquad()
                    }
                }
        }
    }
}

// MARK: - Subviews

private extension SeasonsView {
    
    var seasonsGrid: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            ForEach(model.allSeasons, id: \.id) { season in
                SwiftUI.Button {
                    
                } label: {
                    SeasonGridItem(item: season)
                }
            }
            
            Rectangle()
                .fill(.clear)
                .frame(height: 20) // Bottom padding
                .task {
                    if model.state != .loading, !model.allSeasons.isEmpty {
                        await model.loadMoreContent()
                    }
                }
        }
        .padding(10)
    }
}

#Preview {
    NavigationStack {
        SeasonsView()
    }
}
