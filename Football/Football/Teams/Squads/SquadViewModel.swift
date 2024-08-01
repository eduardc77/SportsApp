//
//  SquadViewModel.swift
//  FootballApp
//

import Foundation
import Network

final class SquadViewModel: BaseViewModel<ViewState> {
    let squadsService: SquadsServiceable
    let playersService: PlayersServiceable
    
    private(set) var playersResponseModel: PlayersResponseModel?
    private(set) var teamSquad = [Player]()
    
    private(set) var teamID: Int
    
    var currentPage: Int {
        (playersResponseModel?.pagination?.currentPage ?? 0) + 1
    }
    
    init(teamID: Int, squadsService: SquadsServiceable = SquadsService(), playersService: PlayersServiceable = PlayersService()) {
        self.teamID = teamID
        self.squadsService = squadsService
        self.playersService = playersService
    }
    
    @MainActor
    func fetchTeamSquad(page: Int? = nil) async {
        guard state != .empty else { return }
        
        if currentPage == 1 || teamSquad.isEmpty {
            self.changeState(.loading)
        }
        
        do {
            let result: PlayersResponseModel = try await squadsService.getSquadsByTeamID(teamID, currentPage: page ?? currentPage)
            if page == 1 {
                teamSquad = result.data
            } else {
                self.updateTeamSquadData(with: result)
            }
            
            for (index, player) in teamSquad.enumerated() {
                let playerResult: PlayerResponseModel = try await playersService.getPlayerByID(player.playerId ?? 0)
                teamSquad[index].name = playerResult.data.name
                teamSquad[index].gender = playerResult.data.gender
                teamSquad[index].imagePath = playerResult.data.imagePath
            }
            self.playersResponseModel = result
            self.changeState(.finished)
        } catch {
            self.changeState(.error(error: error.localizedDescription))
        }
    }
    
    func loadMoreContent() async {
        guard playersResponseModel?.pagination?.nextPage != nil else { return }
        await fetchTeamSquad()
    }
    
    func refresh() async {
        await fetchTeamSquad(page: 1)
    }
    
    @MainActor
    func changeStateToEmpty() {
        changeState(.empty)
    }
    
    private func updateTeamSquadData(with result: PlayersResponseModel) {
        teamSquad += result.data
    }
}
