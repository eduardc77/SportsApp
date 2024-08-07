//
//  TopScorerViewModel.swift
//  FootballApp
//

import Foundation
import Network

final class TopScorerViewModel: BaseViewModel<ViewState> {
    private let service: TopScorersServiceable
    
    private(set) var responseModel: TopScorersResponseModel?
    private(set) var data = [TopScorer]()
    
    private(set) var seasonID: Int?
    private(set) var stageID: Int?
    
    var currentPage: Int {
        (responseModel?.pagination?.currentPage ?? 0) + 1
    }
    
    var hasMoreContent: Bool {
        responseModel?.pagination?.hasMore ?? false
    }
    
    init(seasonID: Int? = nil, stageID: Int? = nil, service: TopScorersServiceable = TopScorersService()) {
        self.seasonID = seasonID
        self.stageID = stageID
        self.service = service
    }
    
    @MainActor
    func fetchDataByID(page: Int? = nil) async {
        guard state != .empty else { return }
        
        do {
            var result: TopScorersResponseModel?
            if let seasonID = seasonID {
                result = try await service.getTopScorersBySeasonID(seasonID, currentPage: page ?? currentPage)
            } else if let stageID = stageID {
                result = try await service.getTopScorersByStageID(stageID, currentPage: page ?? currentPage)
            }
            if currentPage == 1 || data.isEmpty {
                self.changeState(.loading)
            }
            if let result = result {
                if page == 1 {
                    data = result.data
                } else {
                    updateData(with: result)
                }
                responseModel = result
            }
            changeState(.finished)
        } catch {
            changeState(.error(error: error.localizedDescription))
        }
    }
    
    func loadMoreContent() async {
        guard responseModel?.pagination?.nextPage != nil, hasMoreContent else { return }
        await fetchDataByID()
    }
    
    func refresh() async {
        await fetchDataByID(page: 1)
    }
    
    @MainActor
    func changeStateToEmpty() {
        changeState(.empty)
    }
    
    private func updateData(with result: TopScorersResponseModel) {
        data += result.data
    }
}
