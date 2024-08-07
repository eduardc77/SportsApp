//
//  RoundsView.swift
//  FootballApp
//

import Foundation
import Network

final class RoundsViewModel: BaseViewModel<ViewState> {
    private let service: RoundsServiceable
    
    private(set) var responseModel: RoundsResponseModel?
    private(set) var data: [Round]
    
    private(set) var seasonID: Int?
    
    var currentPage: Int {
        (responseModel?.pagination?.currentPage ?? 0) + 1
    }
    
    var hasMoreContent: Bool {
        responseModel?.pagination?.hasMore ?? false
    }
    
    init(data: [Round] = [], seasonID: Int? = nil, service: RoundsServiceable = RoundsService()) {
        self.data = data
        self.service = service
    }
    
    @MainActor
    func fetchAllData(page: Int? = nil) async {
        guard state != .empty else { return }
        
        do {
            let result: RoundsResponseModel = try await service.getAllRounds(currentPage: page ?? currentPage)
            
            if currentPage == 1 || data.isEmpty {
                self.changeState(.loading)
            }
            if page == 1 {
                data = result.data
            } else {
                updateData(with: result)
            }
            
            responseModel = result
            changeState(.finished)
        } catch {
            changeState(.error(error: error.localizedDescription))
        }
    }
    
    @MainActor
    func fetchDataBySeasonID(_ seasonID: Int) async {
        guard state != .empty else { return }
        
        do {
            let result: RoundsResponseModel = try await service.getRoundsBySeasonID(seasonID)
            
            if currentPage == 1 || data.isEmpty {
                self.changeState(.loading)
            }
            data = result.data
            responseModel = result
            changeState(.finished)
        } catch {
            changeState(.error(error: error.localizedDescription))
        }
    }
    
    func loadMoreContent() async {
        guard responseModel?.pagination?.nextPage != nil, hasMoreContent else { return }
        
        if let seasonID = seasonID {
            await fetchDataBySeasonID(seasonID)
        } else if data.isEmpty {
            await fetchAllData()
        }
    }
    
    func refresh() async {
        if let seasonID = seasonID {
            await fetchDataBySeasonID(seasonID)
        } else if data.isEmpty {
            await fetchAllData(page: 1)
        }
    }
    
    @MainActor
    func changeStateToEmpty() {
        changeState(.empty)
    }
    
    private func updateData(with result: RoundsResponseModel) {
        data += result.data
    }
}
