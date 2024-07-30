//
//  OnboardingView.swift
//  FootballApp
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text("Welcome to")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Football App")
                    .foregroundColor(.accentColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .font(.system(size: 42).weight(.heavy))
            .padding([.horizontal, .top], 30)
            
            OnboardingPageView()
            
            Spacer()
            
            Button {
                dismiss()
                isOnboarding = false
            } label: {
                Text("Continue")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
        }
        .interactiveDismissDisabled()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

