//
//  FixtureGridItem.swift
//  FootballApp
//

import SwiftUI
import Network

struct FixtureGridItem: View {
    let item: Fixture

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: .p8) {
                Text(item.name ?? "")
                    .lineLimit(1)
                    .font(.callout.weight(.bold))
                    .minimumScaleFactor(0.3)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(item.details ?? "")
                    .lineLimit(5)
                    .font(.callout.weight(.semibold))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Color.primary)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Divider().padding(.horizontal, -15)
                
                Text(item.resultInfo ?? "")
                    .lineLimit(1)
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(Color.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
        }
        .background(.background.secondary, in: .rect(cornerRadius: 8))
    }
}
