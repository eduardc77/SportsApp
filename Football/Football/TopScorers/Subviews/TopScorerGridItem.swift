//
//  TopScorerGridItem.swift
//  FootballApp
//

import SwiftUI
import Network

struct TopScorerGridItem: View {
    let item: TopScorer

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let imageURL = URL(string: item.player?.imagePath ?? "") {
                AsyncImageView(url: imageURL, size: .custom(height: 120), contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: 120)
                    .padding(.vertical)
            } else {
                ZStack {
                    Color.secondary.frame(height: 120)
                    Image(systemName: "figure.soccer")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                }
            }
            
            VStack(alignment: .leading, spacing: .p8) {
                Text(item.player?.name ?? "")
                    .lineLimit(1)
                    .font(.callout.weight(.bold))
                    .minimumScaleFactor(0.3)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(item.participant?.name ?? "")
                    .lineLimit(5)
                    .font(.callout.weight(.semibold))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Color.primary)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()
                Divider().padding(.horizontal, -15)
                
                Text("Total: \(item.total ?? 0)")
                    .lineLimit(1)
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(Color.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Position: \(item.position ?? 0)")
                    .lineLimit(1)
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(Color.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
        }
        .background(.background.secondary)
        .clipShape(.rect(cornerRadius: 8))
    }
}
