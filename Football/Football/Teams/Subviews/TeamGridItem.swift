//
//  TeamGridItem.swift
//  FootballApp
//

import SwiftUI
import Network

struct TeamGridItem: View {
    let item: Team
    @State var isEmpty = false
    
    init(item: Team) {
        self.item = item
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let imageURL = URL(string: item.imagePath ?? "") {
                AsyncImageView(url: imageURL, size: .custom(height: 120), contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: 120)
                    .padding(.vertical)
            } else {
                Color.secondary.frame(height: 120)
            }
            
            VStack(alignment: .leading, spacing: .p8) {
                Text(item.name ?? "")
                    .lineLimit(1)
                    .font(.callout.weight(.bold))
                    .minimumScaleFactor(0.3)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(item.type ?? "")
                    .lineLimit(5)
                    .font(.callout.weight(.semibold))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Color.primary)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
      
                Divider().padding(.horizontal, -15)
                
                Text(item.lastPlayedAt ?? "")
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
