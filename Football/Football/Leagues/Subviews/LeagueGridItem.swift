//
//  LeagueGridItem.swift
//  FootballApp
//

import SwiftUI
import Network

struct LeagueGridItem: View {
    let item: League
    @State var isEmpty = false
    
    init(item: League) {
        self.item = item
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let imageURl = URL(string: item.imagePath) {
                Color.clear.overlay {
                    AsyncImageView(url: imageURl, size: .custom(height: 120), contentMode: .fit)
                }
                .frame(height: 120)
                .clipped()
            } else {
                Color.secondary.frame(height: 120)
            }
            
            VStack(alignment: .leading, spacing: .xxxSmall) {
                Text(item.name)
                    .lineLimit(1)
                    .font(.callout.weight(.bold))
                    .minimumScaleFactor(0.3)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(item.type)
                    .lineLimit(5)
                    .font(.callout.weight(.semibold))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Color.primary)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Divider().padding(.horizontal, -10)
                
                Text(item.lastPlayedAt)
                    .lineLimit(1)
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(Color.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(10)
        }
        .frame(minWidth: 160, minHeight: 300, maxHeight: .infinity)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
