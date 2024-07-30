//
//  ContentView.swift
//  Football
//
//  Created by iMac on 30.07.2024.
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
