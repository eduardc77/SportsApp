//
//  LeaguesCoordinator.swift
//  FootballApp
//

import SwiftUI

struct LeaguesCoordinator: View {
    @StateObject private var router = ViewRouter()
    @EnvironmentObject private var tabRouter: AppTabRouter
    @EnvironmentObject private var modalRouter: ModalScreenRouter
    
    var body: some View {
        NavigationStack(path: $router.path) {
            LeaguesView()
                .onReceive(tabRouter.$tabReselected) { tabReselected in
                    guard tabReselected, tabRouter.selection == .leagues, !router.path.isEmpty else { return }
                    router.popToRoot()
                }
        }
        .environmentObject(router)
    }
}

#Preview {
    LeaguesCoordinator()
}
