//
//  SettingsCoordinator.swift
//  Football
//

import SwiftUI

struct SettingsCoordinator: View {
    @StateObject private var router = ViewRouter()
    @EnvironmentObject private var tabRouter: AppTabRouter
    @EnvironmentObject private var modalRouter: ModalScreenRouter
    
    var body: some View {
        NavigationStack(path: $router.path) {
            SettingsView()
                .onReceive(tabRouter.$tabReselected) { tabReselected in
                    guard tabReselected, tabRouter.selection == .settings, !router.path.isEmpty else { return }
                    router.popToRoot()
                }
        }
        .environmentObject(router)
    }
}

#Preview {
    TeamsCoordinator()
}
