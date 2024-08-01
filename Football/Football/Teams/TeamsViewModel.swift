//
//  TeamsViewModel.swift
//  FootballApp
//

import Foundation
import Network

final class TeamsViewModel: BaseViewModel<ViewState> {
    let teamsService: TeamsServiceable
    
    private(set) var teamsResponseModel: TeamsResponseModel?
    private(set) var allTeams = [Team]()
    
    var currentPage: Int {
        (teamsResponseModel?.pagination.currentPage ?? 0) + 1
    }
    
    //Use dependency injection not assigning in the initializer
    init(teamsService: TeamsServiceable = TeamsService()) { // NewsServiceMock()
        self.teamsService = teamsService
    }

    @MainActor
    func fetchAllTeams(page: Int? = nil) async {
        guard state != .empty else { return }
        
        if currentPage == 1 || allTeams.isEmpty {
            self.changeState(.loading)
        }
        
        do {
            let result: TeamsResponseModel = try await teamsService.getAllTeams(currentPage: page ?? currentPage)
            if page == 1 {
                allTeams = result.data
            } else{
                self.updateAllTeamsData(with: result)
            }
            self.teamsResponseModel = result
            self.changeState(.finished)
        } catch {
            self.changeState(.error(error: error.localizedDescription))
        }
    }
    
    func loadMoreContent() async {
        guard teamsResponseModel?.pagination.nextPage != nil else { return }
        await fetchAllTeams()
    }
    
    func refresh() async {
        await fetchAllTeams(page: 1)
    }
    
    @MainActor
    func changeStateToEmpty() {
        changeState(.empty)
    }
    
    private func updateAllTeamsData(with result: TeamsResponseModel) {
        allTeams += result.data
    }
}
