//
//  AccountDetailView.swift
//  Football
//

import SwiftUI

struct AccountDetailView: View {
    @Environment(\.dismiss) var dismiss
    let profile: Profile
    
    var body: some View {
        NavigationStack {
            Form {
                Text("Account Profile")
                Text("Name: \(profile.name)")
            }
            .navigationTitle("Account Profile")
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}
//
//#Preview {
//    MenuDetailView(path: <#T##Binding<NavigationPath>#>)
//}
