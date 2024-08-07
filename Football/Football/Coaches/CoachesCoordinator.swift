//
//  CoachesCoordinator.swift
//  FootballApp
//

import SwiftUI

struct CoachesCoordinator: View {
    @State private var router = ViewRouter()
    @EnvironmentObject private var tabRouter: AppTabRouter
    @Environment(ModalScreenRouter.self) private var modalRouter
    
    var body: some View {
        NavigationStack(path: $router.path) {
            CoachesView(model: CoachesViewModel())
                .onReceive(tabRouter.$tabReselected) { tabReselected in
                    guard tabReselected, tabRouter.selection == .players, !router.path.isEmpty else { return }
                    router.popToRoot()
                }
        }
        .environment(router)
    }
}

#Preview {
    LeaguesCoordinator()
}
