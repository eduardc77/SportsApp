//
//  TeamsCoordinator.swift
//  FootballApp
//

import SwiftUI

struct TeamsCoordinator: View {
    @StateObject private var router = ViewRouter()
    @EnvironmentObject private var tabRouter: AppTabRouter
    @EnvironmentObject private var modalRouter: ModalScreenRouter
    
    var body: some View {
        NavigationStack(path: $router.path) {
            TeamsView()
                .onReceive(tabRouter.$tabReselected) { tabReselected in
                    guard tabReselected, tabRouter.selection == .teams, !router.path.isEmpty else { return }
                    router.popToRoot()
                }
        }
        .environmentObject(router)
    }
}

#Preview {
    TeamsCoordinator()
}
