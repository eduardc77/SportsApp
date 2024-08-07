//
//  SettingsCoordinator.swift
//  Football
//

import SwiftUI

struct SettingsCoordinator: View {
    @EnvironmentObject private var tabRouter: AppTabRouter
    @State private var router = ViewRouter()
    @Environment(ModalScreenRouter.self) private var modalRouter
    
    var body: some View {
        NavigationStack(path: $router.path) {
            SettingsView()
                .onReceive(tabRouter.$tabReselected) { tabReselected in
                    guard tabReselected, tabRouter.selection == .settings, !router.path.isEmpty else { return }
                    router.popToRoot()
                }
        }
        .environment(router)
    }
}

#Preview {
    TeamsCoordinator()
}
