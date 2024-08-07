//
//  LeaguesViewModel.swift
//  FootballApp
//

import Foundation
import Network

final class LeaguesViewModel: BaseViewModel<ViewState> {
    private let service: LeaguesServiceable
    
    @Published private(set) var responseModel: LeaguesResponseModel?
    @Published private(set) var data = [League]()
    
    var currentPage: Int {
        (responseModel?.pagination.currentPage ?? 0) + 1
    }
    
    var hasMoreContent: Bool {
        responseModel?.pagination.hasMore ?? false
    }
    
    init(service: LeaguesServiceable = LeaguesService()) {
        self.service = service
    }

    @MainActor
    func fetchAllData(page: Int? = nil) async {
        guard state != .empty else { return }

        do {
            let result: LeaguesResponseModel = try await service.getAllLeagues(currentPage: page ?? currentPage)
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
    
    func loadMoreContent() async {
        guard responseModel?.pagination.nextPage != nil, hasMoreContent else { return }
        await fetchAllData()
    }
    
    func refresh() async {
        await fetchAllData(page: 1)
    }
    
    @MainActor 
    func changeStateToEmpty() {
        changeState(.empty)
    }
    
    private func updateData(with result: LeaguesResponseModel) {
        data += result.data
    }
}
