//
//  SettingsView.swift
//  FootballApp
//

import SwiftUI
import StoreKit
import Network

struct SettingsView: View {
    @EnvironmentObject private var settings: AppSettings
    @Environment(ViewRouter.self) private var router
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        Form {
            Section {
                appThemeColorPicker
                displayAppearancePicker
            } header: {
                Text("Preferences")
            }
            
            Section {
                aboutRow
                rateRow
                
            } header: {
                Text("Football App")
            }
            
            Section {
                feedbackRow
                followLinkRow
            } header: {
                Text("Developer")
            }
            
            Section {
                moreSectionRows
            } header: {
                Text("More")
            }

            Section {
                
            } header: {
                VStack {
                    Text("Football App")
                    Text(settings.appVersion ?? "")
                }
                .font(.caption.weight(.medium))
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity)
            }
            .listRowInsets(.none)
            .listRowBackground(Color.clear)
        }
        .formStyle(.grouped)
        .navigationBar(title: "Settings")
    }
    
    var appThemeColorPicker: some View {
        Picker(selection: settings.$theme) {
            ForEach(AppSettings.Theme.allCases, id: \.self) { theme in
                Text(theme.title)
                    .tag(theme)
            }
        } label: {
            SettingsLabel(settingsOption: .appColor)
        }
        .tint(.secondary)
        .frame(height: 20)
    }
    
    var displayAppearancePicker: some View {
        Picker(selection: settings.$displayAppearance) {
            ForEach(AppSettings.DisplayAppearance.allCases, id: \.self) { displayAppearance in
                displayAppearance.title
                    .tag(displayAppearance)
                
            }
        } label: {
            SettingsLabel(settingsOption: .displayAppearance)
        }
        .tint(.secondary)
        .frame(height: 20)
    }
    
    var aboutRow: some View {
        NavigationButton {
            router.push(SettingsDestination.about)
        } label: {
            SettingsLabel(settingsOption: .about)
        }
        .tint(Color.primary)
    }
    
    var rateRow: some View {
        HStack {
            Button {
                requestReview()
            } label: {
                SettingsLabel(settingsOption: .rate)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            .tint(.primary)
            .buttonStyle(.borderless)
            
            externalArrowIcon
        }
    }
    
    var feedbackRow: some View {
        NavigationButton {
            router.push(SettingsDestination.feedback)
        } label: {
            SettingsLabel(settingsOption: .feedback)
        }
        .tint(Color.primary)
        .buttonStyle(.borderless)
    }
 
    var followLinkRow: some View {
        HStack {
            Link(destination: URL(string: "https://github.com/eduardc77")!) {
                SettingsLabel(settingsOption: .follow)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .tint(.primary)
            
            externalArrowIcon
        }
    }
    
    var externalArrowIcon: some View {
        Group {
            Spacer()
            
            Image(systemName: "arrow.up.forward")
                .foregroundStyle(.secondary)
                .fontWeight(.medium)
        }
    }
    
    var moreSectionRows: some View {
        Group {
            NavigationButton {
                router.push(SettingsDestination.termsOfUse)
            } label: {
                SettingsLabel(settingsOption: .termsOfUse)
            }

            NavigationButton {
                router.push(SettingsDestination.privacyPolicy)
            } label: {
                SettingsLabel(settingsOption: .privacyPolicy)
            }
        }
        .tint(Color.primary)
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppSettings())
        .environment(ViewRouter())
}


enum SettingsDestination: Hashable {
    case settings
    case termsOfUse
    case privacyPolicy
    case about
    case feedback
}
