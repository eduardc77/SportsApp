//
//  ContentView.swift
//  Football
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    var body: some View {
        AppTabView()
            .sheet(isPresented: $isOnboarding) {
                OnboardingView()
            }
    }
}

#Preview {
    ContentView()
}
