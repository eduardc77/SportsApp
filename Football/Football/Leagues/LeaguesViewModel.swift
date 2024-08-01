//
//  LeaguesViewModel.swift
//  FootballApp
//

import Foundation
import Network

final class LeaguesViewModel: BaseViewModel<ViewState> {
    let leaguesService: LeaguesServiceable
    
    @Published private(set) var leaguesResponseModel: LeaguesResponseModel?
    @Published private(set) var allLeagues = [League]()
    
    var currentPage: Int {
        (leaguesResponseModel?.pagination.currentPage ?? 0) + 1
    }
    
    //Use dependency injection not assigning in the initializer
    init(leaguesService: LeaguesServiceable = LeaguesService()) { // NewsServiceMock()
        self.leaguesService = leaguesService
    }

    @MainActor
    func fetchAllLeagues(page: Int? = nil) async {
        guard state != .empty else { return }
        
        if currentPage == 1 || allLeagues.isEmpty {
            self.changeState(.loading)
        }
        
        do {
            let result: LeaguesResponseModel = try await leaguesService.getAllLeagues(currentPage: page ?? currentPage)
            
            if page == 1 {
                allLeagues = result.data
            } else {
                updateAllLeaguesData(with: result)
            }
            leaguesResponseModel = result
            changeState(.finished)
        } catch {
            changeState(.error(error: error.localizedDescription))
        }
    }
    
    func loadMoreContent() async {
        guard leaguesResponseModel?.pagination.nextPage != nil else { return }
        await fetchAllLeagues()
    }
    
    func refresh() async {
        await fetchAllLeagues(page: 1)
    }
    
    @MainActor 
    func changeStateToEmpty() {
        changeState(.empty)
    }
    
    private func updateAllLeaguesData(with result: LeaguesResponseModel) {
        allLeagues += result.data
    }
}
