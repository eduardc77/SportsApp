//
//  StagesViewModel.swift
//  FootballApp
//

import Foundation
import Network

final class StagesViewModel: BaseViewModel<ViewState> {
    let stagesService: StagesServiceable
    
    private(set) var stagesResponseModel: StagesResponseModel?
    private(set) var allStages: [Stage]
    
    var currentPage: Int {
        (stagesResponseModel?.pagination.currentPage ?? 0) + 1
    }
    
    init(stages: [Stage], stagesService: StagesServiceable = StagesService()) {
        self.allStages = stages
        self.stagesService = stagesService
    }
    
    @MainActor
    func fetchTeamSquad(page: Int? = nil) async {
        guard state != .empty else { return }
        
        if currentPage == 1 || allStages.isEmpty {
            self.changeState(.loading)
        }
        
        do {
            let result: StagesResponseModel = try await stagesService.getAllStages(currentPage: page ?? currentPage)
            if page == 1 {
                allStages = result.data
            } else {
                updateAllStagesData(with: result)
            }
            
            stagesResponseModel = result
            changeState(.finished)
        } catch {
            changeState(.error(error: error.localizedDescription))
        }
    }
    
    func loadMoreContent() async {
        guard stagesResponseModel?.pagination.nextPage != nil else { return }
        await fetchTeamSquad()
    }
    
    func refresh() async {
        await fetchTeamSquad(page: 1)
    }
    
    @MainActor
    func changeStateToEmpty() {
        changeState(.empty)
    }
    
    private func updateAllStagesData(with result: StagesResponseModel) {
        allStages += result.data
    }
}
