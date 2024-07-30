//
//  OnboardingPageView.swift
//  FootballApp
//

import SwiftUI

struct OnboardingPageView: View {
    @State var onboardingPages: [[OnboardingItemModel]]
    
    init(welcomePages: [[OnboardingItemModel]] = OnboardingItemModel.onboardingItems) {
        self.onboardingPages = welcomePages
    }
    
    var body: some View {
        TabView {
            ForEach(onboardingPages, id: \.self) { page in
                LazyVGrid(columns: columns, alignment: .leading) {
                    ForEach(page, id: \.self) { item in
                        
                        OnboardingItem(image: item.imageName, text: LocalizedStringKey(item.description), title: LocalizedStringKey(item.title))
                            .padding(.vertical)
                    }
                    .padding(.horizontal, 30)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.secondaryLabel
            UIPageControl.appearance().pageIndicatorTintColor = UIColor.tertiaryLabel
        }
    }
    
    var columns: [GridItem] {
        [ GridItem(.flexible(minimum: 260)) ]
    }
}

struct OnboardingItem: View {
    let image: String
    let text: LocalizedStringKey
    let title: LocalizedStringKey
    
    var body: some View {
        HStack(spacing: .medium4) {
            ZStack {
                Circle()
                    .foregroundColor(.accentColor)
                    .frame(width: 54, height: 54)
                
                Image(systemName: image)
                    .font(.title)
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .foregroundStyle(Color.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(text)
                    .lineLimit(3)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}


// MARK: - Previews

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView(welcomePages: OnboardingItemModel.onboardingItems)
    }
}
