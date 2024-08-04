//
//  SquadViewModel.swift
//  FootballApp
//

import Foundation
import Network

final class SquadViewModel: BaseViewModel<ViewState> {
    let squadsService: SquadsServiceable
    
    private(set) var playersResponseModel: PlayersResponseModel?
    private(set) var teamSquad = [Player]()
    
    private(set) var teamID: Int
    
    var currentPage: Int {
        (playersResponseModel?.pagination.currentPage ?? 0) + 1
    }
    
    init(teamID: Int, squadsService: SquadsServiceable = SquadsService()) {
        self.teamID = teamID
        self.squadsService = squadsService
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
                updateTeamSquadData(with: result)
            }
            playersResponseModel = result
            changeState(.finished)
        } catch {
            changeState(.error(error: error.localizedDescription))
        }
    }
    
    func loadMoreContent() async {
        guard playersResponseModel?.pagination.nextPage != nil else { return }
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
