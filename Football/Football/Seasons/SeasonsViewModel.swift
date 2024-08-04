//
//  SeasonsViewModel.swift
//  FootballApp
//

import Foundation
import Network

final class SeasonsViewModel: BaseViewModel<ViewState> {
    let seasonsService: SeasonsServiceable
    
    private(set) var seasonsResponseModel: SeasonsResponseModel?
    private(set) var allSeasons: [Season]
    
    var currentPage: Int {
        (seasonsResponseModel?.pagination.currentPage ?? 0) + 1
    }
    
    init(seasons: [Season], seasonsService: SeasonsServiceable = SeasonsService()) {
        self.allSeasons = seasons
        self.seasonsService = seasonsService
    }
    
    @MainActor
    func fetchTeamSquad(page: Int? = nil) async {
        guard state != .empty else { return }
        
        if currentPage == 1 || allSeasons.isEmpty {
            self.changeState(.loading)
        }
        
        do {
            let result: SeasonsResponseModel = try await seasonsService.getAllSeasons(currentPage: page ?? currentPage)
            if page == 1 {
                allSeasons = result.data
            } else {
                updateAllSeasonsData(with: result)
            }
            
            seasonsResponseModel = result
            changeState(.finished)
        } catch {
            changeState(.error(error: error.localizedDescription))
        }
    }
    
    func loadMoreContent() async {
        guard seasonsResponseModel?.pagination.nextPage != nil else { return }
        await fetchTeamSquad()
    }
    
    func refresh() async {
        await fetchTeamSquad(page: 1)
    }
    
    @MainActor
    func changeStateToEmpty() {
        changeState(.empty)
    }
    
    private func updateAllSeasonsData(with result: SeasonsResponseModel) {
        allSeasons += result.data
    }
}
