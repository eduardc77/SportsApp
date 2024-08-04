//
//  PlayersViewModel.swift
//  FootballApp
//

import Foundation
import Network

final class PlayersViewModel: BaseViewModel<ViewState> {
    let playersService: PlayersServiceable
    
    private(set) var playersResponseModel: PlayersResponseModel?
    private(set) var allPlayers = [Player]()
    
    var currentPage: Int {
        (playersResponseModel?.pagination.currentPage ?? 0) + 1
    }
    
    //Use dependency injection not assigning in the initializer
    init(playersService: PlayersServiceable = PlayersService()) { // NewsServiceMock()
        self.playersService = playersService
    }

    @MainActor
    func fetchAllLeagues(page: Int? = nil) async {
        guard state != .empty else { return }
        
        if currentPage == 1 || allPlayers.isEmpty {
            self.changeState(.loading)
        }
        
        do {
            let result: PlayersResponseModel = try await playersService.getAllPlayers(currentPage: page ?? currentPage)
            
            if page == 1 {
                allPlayers = result.data
            } else {
                updateAllPlayersData(with: result)
            }
            playersResponseModel = result
            changeState(.finished)
        } catch {
            changeState(.error(error: error.localizedDescription))
        }
    }
    
    func loadMoreContent() async {
        guard playersResponseModel?.pagination.nextPage != nil else { return }
        await fetchAllLeagues()
    }
    
    func refresh() async {
        await fetchAllLeagues(page: 1)
    }
    
    @MainActor
    func changeStateToEmpty() {
        changeState(.empty)
    }
    
    private func updateAllPlayersData(with result: PlayersResponseModel) {
        allPlayers += result.data
    }
}
