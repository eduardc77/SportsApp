//
//  OnboardingItemModel.swift
//  FootballApp
//

struct OnboardingItemModel: Hashable {
    var title: String
    var description: String
    var imageName: String
    
    static var onboardingItems = [
        [
            OnboardingItemModel(title: "News", description: "Lorem ipsum dolor, consectetur adipiscing elit.", imageName: "square.grid.3x3"),
            OnboardingItemModel(title: "Stories", description: "Lorem ipsum dolor sit amet, ipsum adipiscing elit Lorem ipsum dolor sit amet.", imageName: "text.book.closed"),
            OnboardingItemModel(title: "Videos", description: "Lorem ipsum dolor sit amet, ipsum adipiscing elit, elit adipiscing elit.", imageName: "figure.stand")
        ],
        
        [
            OnboardingItemModel(title: "News", description: "Lorem ipsum dolor sit amet, dolor, dolor adipiscing elit.", imageName: "newspaper"),
            OnboardingItemModel(title: "Articles", description: "Lorem ipsum dolor sit amet, ipsum adipiscing elit, elit adipiscing elit.", imageName: "list.bullet.rectangle"),
            OnboardingItemModel(title: "Videos", description: "Lorem ipsum dolor sit amet, elit adipiscing elit.", imageName: "tablecells")
            
        ],
        
        [
            OnboardingItemModel(title: "Videos", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", imageName: "video.square"),
            OnboardingItemModel(title: "Articles", description: "Lorem ipsum dolor sit, consectetur adipiscing elit Lorem ipsum dolor sit amet.", imageName: "character.book.closed"),
            OnboardingItemModel(title: "News", description: "String.adaptiveBiometricDescription", imageName: "camera.metering.partial")
        ]
    ]
}
