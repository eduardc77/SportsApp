//
//  FootballApp.swift
//  Football
//
//  Created by iMac on 30.07.2024.
//

import SwiftUI

@main
struct FootballApp: App {
    @StateObject private var settings = AppSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .tint(settings.theme.color)
                .environmentObject(settings)
                .preferredColorScheme(settings.displayAppearance.colorScheme)
        }
    }
}
