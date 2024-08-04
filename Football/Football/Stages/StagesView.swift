//
//  StagesView.swift
//  FootballApp
//

import SwiftUI
import Network

struct StagesView: View {
    @State private var model: StagesViewModel
    
    @EnvironmentObject private var router: ViewRouter
    @EnvironmentObject private var tabCoordinator: AppTabRouter
    @EnvironmentObject private var modalRouter: ModalScreenRouter
    
    init(stages: [Stage] = []) {
        model = StagesViewModel(stages: stages)
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
                stagesGrid
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
                    guard model.allStages.isEmpty else { return }
                    Task {
                        await model.fetchTeamSquad()
                    }
                }
        }
    }
}

// MARK: - Subviews

private extension StagesView {
    
    var stagesGrid: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            ForEach(model.allStages, id: \.id) { stage in
                SwiftUI.Button {
                    
                } label: {
                    StageGridItem(item: stage)
                }
            }
            
            Rectangle()
                .fill(.clear)
                .frame(height: 20) // Bottom padding
                .task {
                    if model.state != .loading, !model.allStages.isEmpty {
                        await model.loadMoreContent()
                    }
                }
        }
        .padding(10)
    }
}

#Preview {
    NavigationStack {
        StagesView()
    }
}
