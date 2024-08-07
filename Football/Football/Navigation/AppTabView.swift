//
//  AppTabView.swift
//  FootballApp
//

import SwiftUI

struct AppTabView: View {
    @StateObject private var tabRouter = AppTabRouter()
    @Environment(\.openURL) var openURL
    @State private var modalRouter = ModalScreenRouter()
    
    var body: some View {
        TabView(selection: $tabRouter.selection) {
            ForEach(AppScreen.allCases) { screen in
                screen.destination
                    .tag(screen as AppScreen?)
                    .tabItem { screen.label }
            }
        }
        .sheet(item: $modalRouter.presentedSheet, content: sheetContent)
        .fullScreenCover(item: $modalRouter.presentedFullScreenCover, content: fullScreenCoverContent)
        .alert($modalRouter.alert)
        .environmentObject(tabRouter)
        .environment(modalRouter)
        .onOpenURL { url in
            
        }
        .onReceive(tabRouter.$urlString) { newValue in
            guard let urlString = newValue, let url = URL(string: urlString) else { return }
            openURL(url)
        }
    }
    
    @ViewBuilder
    private func sheetContent(_ content: AnyIdentifiable) -> some View {
        if let destination = content.destination as? NavigationBarSheetDestination {
            switch destination {
            case .account(profile: let profile):
                AccountDetailView(profile: profile)
            case .share:
                Text("Share")
            }
        }
    }
    
    @ViewBuilder
    private func fullScreenCoverContent(_ content: AnyIdentifiable) -> some View {
        EmptyView()
    }
}

enum NavigationBarSheetDestination: Identifiable {
    case account(profile: Profile)
    case share
    
    var id: String { UUID().uuidString }
}

struct Profile: Equatable {
    let name: String
}

#Preview {
    AppTabView()
}
