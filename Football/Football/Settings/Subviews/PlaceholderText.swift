//
//  PlaceholderText.swift
//  Football
//

import SwiftUI

struct PlaceholderText: View {
    let title: SettingsOption
    
    var body: some View {
        ScrollView {
            Text(AboutFootballApp.lorem)
                .padding()
        }
        .navigationTitle(title.rawValue.capitalized)
    }
}

#Preview {
    NavigationStack {
        PlaceholderText(title: .termsOfUse)
    }
}
